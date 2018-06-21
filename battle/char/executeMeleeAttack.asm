; Calculating melee success
; -------------------------
; 1. Determine the target's AC
;    a. Party member
;	targetAc = member.ac
;    b. Monster
;       targetAc = monsterType.ac + monsterType.acBonus + monsterType.advanceSpeedBonus - freezeSpell.penalty
;
; 2. Subtract equipped weapon (if any) toHit bonus from targetAc
;    targetAc -= weapon.toHitBonus
;
; 3. Add monster-cast Word of Fear bonus
;    targetAc += monster.wofBonus
;
; 4. Determine source attack value
;    a. Summon
;       sourceAttack = random(summon.toHitLo, summon.toHitHi)
;    b. Character
;       i.  sourceAttack = MAX((level >> 4), 255)
;       ii. Subtract (strength >> 1) from targetAc
;           targetAc -= (strength >> 1)
;
; 5. Calculate pre-bonus attackSuccess
;    attackSuccessFlag = targetAc - sourceAttack
;
; 6. Apply bonues
;    attackSuccessFlag -= (classToHitBonus + freezeSpellToHitBonus + 2d8 + strengthSpellBonus)
;
; 7. If (attackSuccessFlag > 0)
;    Attack fails
;
; Attributes: bp-based frame

bat_charExecuteMeleeAttack proc far

	monkLevel=	word ptr -1Ch
	summonP=	dword ptr -1Ah
	numberOfAttacks=	word ptr -16h
	damageDice=	word ptr -14h
	vorpalLoopCounter=	word ptr -12h
	sourceToHitValue=	word ptr -10h
	weaponBonusDamage=	word ptr -0Eh
	monsterTargetGroup= word ptr	-0Ch
	targetGroupDistance= word ptr	-0Ah
	attackSuccessFlag= word ptr	-8h
	equippedWeaponSlot= word ptr	-6
	targetAc= word ptr	-4
	loopCounter= word ptr	-2
	slotNumber= word ptr	 6
	actionTarget= word ptr	 8

	FUNC_ENTER(1Ch)
	push	si

	cmp	[bp+actionTarget], 80h
	jge	short l_monsterTarget

	CHARINDEX(ax, STACKVAR(actionTarget), bx)		; if target is party member
	mov	al, gs:party.ac[bx]				;   then targetAc = member AC
	cbw
	mov	[bp+targetAc], ax
	jmp	l_getSourceAttackValue

l_monsterTarget:
	mov	ax, [bp+actionTarget]
	and	ax, 3
	mov	[bp+monsterTargetGroup], ax
	MONINDEX(ax, STACKVAR(monsterTargetGroup), ax)
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+targetGroupDistance], ax			; if targetGroupDistance == 0
	or	ax, ax						;   then goto l_inMeleeRange
	jz	short l_inMeleeRange

	mov	bx, [bp+slotNumber]				; else if characterMeleeDistance < targetGroupDistance
	mov	al, gs:g_characterMeleeDistance[bx]		;   then return MISSED
	sub	ah, ah
	mov	cx, [bp+targetGroupDistance]
	dec	cx
	cmp	ax, cx
	jb	l_returnZero

l_inMeleeRange:
	MONINDEX(ax, STACKVAR(monsterTargetGroup), si)
	mov	al, gs:monGroups.packedGenAc[si]
	sub	ah, ah
	and	ax, 3Fh
	mov	[bp+targetAc], ax				; targetAc = monsterType.Ac

	mov	al, gs:monGroups.flags[si]			; Apply a bonus/penalty to the
	sub	ah, ah						; targetAc based on the monster
	mov	cl, 6						; flags.
	shr	ax, cl						;
	and	ax, 3						; I have no idea why this isn't
	mov	bx, ax						; just part of the monster's base
	mov	al, g_monsterAcBonusList[bx]			; AC.
	cbw
	add	[bp+targetAc], ax				; targetAc += AcBonus

	mov	al, gs:monGroups.distance[si]			; Apply a bonus/penalty to the
	sub	ah, ah						; targetAc based on the monster's
	mov	cl, 4						; advance speed.
	shr	ax, cl						;
	mov	bx, ax						; Again, no idea why this wasn't
	mov	al, g_monsterAdvanceSpeedAcBonusList[bx]	; just included in the base AC.
	cbw
	add	[bp+targetAc], ax				; targetAc += advanceSpeedBonus

	mov	bx, [bp+monsterTargetGroup]			; Apply Freeze Foes penalty to
	mov	al, gs:g_monFreezeAcPenalty[bx]			; targetAc
	sub	ah, ah						;
	sub	[bp+targetAc], ax				; targetAc -= freezeAcPenalty

l_getSourceAttackValue:
	mov	ax, itType_weapon
	push	ax
	push	[bp+slotNumber]
	CALL(character_getTypeEquippedSlot)
	mov	[bp+equippedWeaponSlot], ax
	or	ax, ax
	jl	short l_noWeaponEquipped

	mov	bx, ax						; Set the special attack value
	mov	al, itemTypeList[bx]				; for the equipped weapon
	sub	ah, ah						; e.g. stoning, criticial hit
	mov	cl, 4
	shr	ax, cl
	mov	gs:specialAttackVal, ax

	mov	al, item_acBonWeapDam[bx]			; Some weapons provide an to-hit bonus
	sub	ah, ah						; to the attacker. Deduct the bonus amount
	shr	ax, cl						; from the target's AC.
	mov	[bp+weaponBonusDamage], ax			;
	sub	[bp+targetAc], ax				; targetAc -= weapon to-hit bonus
	jmp	short loc_1DFC8

l_noWeaponEquipped:
	mov	[bp+weaponBonusDamage], 0
	mov	gs:specialAttackVal, 0

loc_1DFC8:
	mov	al, gs:g_monsterWOFBonus			; Add bonus from monsters casting
	sub	ah, ah						; Word of Fear. The added value
	add	ax, [bp+targetAc]				; was getting written to an unused
	mov	[bp+targetAc], ax				; stack var. Write to targetAc to fix

	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_monster
	jb	short l_getCharacterToHit

	add	ax, offset party				; Summon toHit value is a random number
	mov	word ptr [bp+summonP], ax			; between the monster type's toHitLo
	mov	word ptr [bp+summonP+2], seg seg027		; and toHitHi values.
	lfs	bx, [bp+summonP]
	mov	al, fs:[bx+summonStat_t.toHitHi]
	sub	ah, ah
	push	ax
	mov	al, fs:[bx+summonStat_t.toHitLo]
	push	ax
	CALL(randomBetweenXandY, near)
	mov	[bp+sourceToHitValue], ax
	mov	ax, [bp+targetAc]				; attackSuccessFlag = targetAc - sourceToHitValue
	sub	ax, [bp+sourceToHitValue]
	mov	[bp+attackSuccessFlag], ax
	jmp	short l_applyToHitBonuses

l_getCharacterToHit:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)			; Charcter toHitValue uses the level as the base.
	mov	ax, gs:party.level[bx]				; sourceToHitValue = level >> 2
	shr	ax, 1
	shr	ax, 1
	mov	[bp+sourceToHitValue], ax
	cmp	ax, 0FFh					; Maximum toHit base of 255. Indicates a character
	jle	short l_applyStrengthBonus			; level > 1020. That's a LOT of grinding...
	mov	[bp+sourceToHitValue], 0FFh

l_applyStrengthBonus:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)			; Subtract (strength >> 1) from targetAc.
	mov	al, gs:party.strength[bx]			;
	sub	ah, ah						;
	shr	ax, 1						;
	mov	cx, [bp+targetAc]				; targetAc -= (strength >> 1)
	sub	cx, ax						;
	sub	cx, [bp+sourceToHitValue]			; attackSuccessFlag = targetAc - sourceToHitValue
	mov	[bp+attackSuccessFlag], cx

l_applyToHitBonuses:
	CALL(random_2d8)					; Store a 2d8 roll
	mov	cx, ax						;   in cx

	CHARINDEX(ax, STACKVAR(slotNumber), bx)			; Store a bonus based on class
	mov	bl, gs:party.class[bx]				;   .
	sub	bh, bh						;   .
	mov	al, g_classToHitBonus[bx]			;   .
	cbw							;   in ax

	mov	bx, [bp+slotNumber]				; Store strenghth spell bonus
	mov	dl, gs:g_strengthSpellBonus[bx]			;   .
	sub	dh, dh						;   in dx
	add	ax, dx						; ax += dx
	add	ax, cx						; ax += cx
	mov	cl, gs:g_charFreezeToHitBonus			; Store freeze foes toHit bonus
	sub	ch, ch						;   in cx
	add	ax, cx						; ax += cx
	sub	[bp+attackSuccessFlag], ax			; attackSuccessFlag -= ax
	cmp	[bp+attackSuccessFlag], 0			; if (attackSuccessFlag > 0)
	jg	l_returnZero					;   attack fails

	; -------------------------------------------
	; Begin damage calculation
	; -------------------------------------------
	CHARINDEX(ax, bx, bx)
	cmp	gs:party.class[bx], class_monster
	jb	short l_calcCharacterDamage

	mov	ax, gs:summonMeleeType
	mov	gs:specialAttackVal, ax
	mov	ax, gs:summonMeleeDamage
	mov	[bp+damageDice], ax
	jmp	short l_hiddenRogueOneAttack

l_calcCharacterDamage:
	cmp	[bp+equippedWeaponSlot], 0
	jl	short l_unarmedMonkDamage

	mov	bx, [bp+equippedWeaponSlot]
	mov	al, itemDamageDice[bx]
	sub	ah, ah
	mov	[bp+damageDice], ax
	jmp	short l_hiddenRogueOneAttack

l_unarmedMonkDamage:
	CHARINDEX(ax, STACKVAR(slotNumber), si)		; Monk damage dice is determined by
	cmp	gs:party.class[si], class_monk		; g_monkDamageDice[MAX(15, level >> 2)]
	jnz	short l_unarmedNonMonkDamage
	mov	ax, gs:party.level[si]
	shr	ax, 1
	shr	ax, 1
	mov	[bp+monkLevel], ax
	cmp	ax, 0Fh
	jle	short l_skipMax
	mov	[bp+monkLevel], 0Fh
l_skipMax:
	mov	bx, [bp+monkLevel]
	mov	al, g_monkDamageDice[bx]
	sub	ah, ah
	mov	[bp+damageDice], ax
	jmp	short l_hiddenRogueOneAttack

l_unarmedNonMonkDamage:
	mov	[bp+damageDice], 20h 

l_hiddenRogueOneAttack:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_rogue
	jnz	short l_notRogue

	mov	bx, [bp+slotNumber]			; Rogue's only get one attack when
	cmp	gs:g_characterMeleeDistance[bx], 0	; they attack from the shadows
	jnz	short l_notRogue
	sub	ax, ax
	jmp	short l_countAttackNumber

l_notRogue:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.numAttacks[bx]
	sub	ah, ah

l_countAttackNumber:
	mov	[bp+loopCounter], ax
	mov	al, gs:songExtraAttack
	sub	ah, ah
	add	[bp+loopCounter], ax
	inc	[bp+loopCounter]
	mov	ax, [bp+loopCounter]
	mov	[bp+numberOfAttacks], ax
	mov	gs:damageAmount, 0

l_calculateDamageLoop:
	push	[bp+damageDice]
	CALL(randomYdX, near)
	mov	bx, [bp+slotNumber]
	mov	cl, gs:g_strengthSpellBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	al, gs:g_divineDamageBonus
	sub	ah, ah
	add	cx, ax
	add	cx, [bp+weaponBonusDamage]
	add	gs:damageAmount, cx

	mov	[bp+vorpalLoopCounter], 0
l_addVorpalPlateBonus:
	mov	bx, [bp+slotNumber]
	mov	al, gs:vorpalPlateBonus[bx]
	sub	ah, ah
	cmp	ax, [bp+vorpalLoopCounter]
	jbe	short l_calculateDamageNext

	CALL(random)
	and	ax, 3					; AND ax with 3 to get 0-3
	inc	ax					; increment result to get 1-4
	add	gs:damageAmount, ax
	inc	[bp+vorpalLoopCounter]
	jmp	short l_addVorpalPlateBonus

l_calculateDamageNext:
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jg	short l_calculateDamageLoop

	mov	bx, [bp+slotNumber]
	cmp	gs:g_characterMeleeDistance[bx], 0
	jz	short l_checkHunterCrit

	CALL(random)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:(party.specAbil+2)[bx], cl
	jbe	short l_failHiddenCrit
	mov	ax, specialAttack_critical
	jmp	short l_saveHiddenCrit
l_failHiddenCrit:
	sub	ax, ax
l_saveHiddenCrit:
	mov	gs:specialAttackVal, ax
	jmp	short l_returnSuccess

l_checkHunterCrit:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_hunter
	jnz	short l_returnSuccess

	CALL(random)
	cmp	gs:party.specAbil[si],	al
	jbe	short l_zeroSpecialAttack
	mov	ax, specialAttack_critical
	jmp	short l_setSpecialAttack

l_zeroSpecialAttack:
	sub	ax, ax

l_setSpecialAttack:
	mov	gs:specialAttackVal, ax

l_returnSuccess:
	mov	ax, [bp+numberOfAttacks]
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_charExecuteMeleeAttack endp
