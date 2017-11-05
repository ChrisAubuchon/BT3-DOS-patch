; Attributes: bp-based frame

bat_doBreathAttack proc	far

	var_11A= word ptr -11Ah
	var_118= word ptr -118h
	outputStringP= dword ptr -116h
	counter= word ptr -112h
	var_110= word ptr -110h
	target=	word ptr -10Eh
	var_10C= word ptr -10Ch
	partyAttackRval= word ptr -10Ah
	var_108= word ptr -108h
	stringBuf= word ptr -106h
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber=	word ptr  6
	specialAttackIndex= byte ptr	 8
	arg_3= byte ptr	 9
	arg_4= byte ptr	 0Ah
	arg_5= byte ptr	 0Bh
	arg_6= byte ptr	 0Ch
	breathFlags= byte ptr	 0Dh
	levelMultiplier= byte ptr	 0Eh
	spellRange= word ptr	 10h

	FUNC_ENTER(11Ah)

	cmp	[bp+levelMultiplier], 0
	jnz	short l_allFoesCheck

	; Set levelMultiplier to 1 if source is an enemy
	cmp	[bp+partySlotNumber], 80h 
	jl	short l_partyMultiplier
	mov	[bp+levelMultiplier], 1
	jmp	short l_allFoesCheck

l_partyMultiplier:
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	push	gs:party.level[bx]
	CALL(_returnXor255, near)
	mov	[bp+levelMultiplier], al

l_allFoesCheck:
	mov	[bp+partyAttackRval], 0
	test	[bp+breathFlags], breath_allFoes		; if breathFlags & breathAllFoes
	jz	short l_oneGroupCheck
	cmp	[bp+partySlotNumber], 80h 			;   if source.isEnemy
	jge	short l_stripAllFoesFlag			;     breathFlags &= !breathAllFoes
	mov	gs:bat_curTarget, 80h				;   else
	jmp	short l_oneGroupCheck				;     currentTarget = first enemy group
l_stripAllFoesFlag:
	and	[bp+breathFlags], 7Fh

l_oneGroupCheck:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	or	ax, [bp+partySlotNumber]
	cmp	ax, 80h
	jnb	short loc_201B9
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_201B9
	mov	ax, [bp+partySlotNumber]
	jmp	short loc_201BC
loc_201B9:
	mov	ax, 0FFh
loc_201BC:
	mov	[bp+var_11A], ax

	mov	[bp+var_110], 0
loc_201C6:
	cmp	gs:bat_curTarget, 80h
	jnb	l_targetIsEnemy
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_201E0
	mov	ax, 6
	jmp	short loc_201E6
loc_201E0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
loc_201E6:
	mov	[bp+target], ax
	PUSH_OFFSET(s_atTheParty)
	PUSH_STACK_ADDRESS(stringBuf)
	STRCAT(outputStringP)
	inc	[bp+partyAttackRval]
	push	[bp+spellRange]
	push	[bp+partySlotNumber]
	CALL(bat_isPartyInRange, near)
	or	ax, ax
	jnz	loc_20324
	PUSH_OFFSET(s_partyTooFarAway)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	PRINTSTRING
	mov	byte ptr g_printPartyFlag,	0
	DELAY
	mov	ax, [bp+partyAttackRval]
	dec	ax
	jmp	bat_doBreathAttack_exit

l_targetIsEnemy:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	l_enemyGroupGone
loc_20289:
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_202B1
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	dec	ax
	jmp	short loc_202B3
loc_202B1:
	sub	ax, ax
loc_202B3:
	mov	[bp+target], ax

	; strcat(stringBuf, "at")
	PUSH_OFFSET(s_at)
	PUSH_STACK_ADDRESS(stringBuf)
	STRCAT(outputStringP)

	push	[bp+target]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	CALL(strcatTargetName, near)
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	ax, offset s_elipsisNl
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	STRCAT(outputStringP)
	jmp	short loc_20324
l_enemyGroupGone:
	mov	[bp+target], 0FFFFh
	cmp	[bp+breathFlags], breath_allFoes
	jnb	short loc_20324
	mov	ax, [bp+partyAttackRval]
	jmp	bat_doBreathAttack_exit

loc_20324:
	cmp	[bp+target], 0
	jl	loc_2086F
loc_2032E:
	mov	gs:damageAmount, 0
	mov	[bp+counter], 0
	jmp	short loc_20345
loc_20341:
	inc	[bp+counter]
loc_20345:
	mov	al, [bp+levelMultiplier]
	sub	ah, ah
	cmp	ax, [bp+counter]
	jbe	short loc_20379
	mov	al, [bp+arg_6]
	push	ax
	CALL(dice_doYDX)
	add	gs:damageAmount, ax
	cmp	gs:damageAmount, 20000
	jle	short loc_20377
	mov	gs:damageAmount, 20000
	jmp	short loc_20379
loc_20377:
	jmp	short loc_20341
loc_20379:
	cmp	gs:bat_curTarget, 80h
	jb	short loc_203AA

	PUSH_OFFSET(s_one)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
	mov	[bp+var_2], 1
	jmp	loc_2047F
loc_203AA:
	mov	ax, [bp+target]
	cmp	[bp+var_11A], ax
	jz	loc_2047A
	mov	bx, ax
	cmp	gs:byte_42280[bx], 0
	jnz	loc_2047A
	mov	al, [bp+specialAttackIndex]
	sub	ah, ah
	push	ax
	push	bx
	CALL(_canAttackChar, near)
	or	ax, ax
	jz	loc_2047A
	CHARINDEX(ax, STACKVAR(target), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	STRCAT(outputStringP)
	APPEND_CHAR(STACKVAR(outputStringP), ' ')
	mov	ax, itemEff_breathDefense
	push	ax
	push	[bp+target]
	CALL(hasEffectEquipped)
	or	ax, ax
	jl	short loc_20467
	test	[bp+breathFlags], breath_isBreath
	jz	short loc_20467
	PUSH_OFFSET(s_repelledAttack)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
	mov	byte ptr g_printPartyFlag,	0
	mov	[bp+var_2], 0
	jmp	short loc_20478
loc_20467:
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	mov	[bp+var_2], 1
loc_20478:
	jmp	short loc_2047F
loc_2047A:
	mov	[bp+var_2], 0
loc_2047F:
	cmp	[bp+var_2], 0
	jnz	short loc_20488
	jmp	loc_2050C
loc_20488:
	cmp	[bp+arg_5], 0
	jz	short loc_2050C
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_204B0
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:party.repelFlags[bx]
	sub	ah, ah
	jmp	short loc_204CF
loc_204B0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 7Fh
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.repelFlags[bx]
	sub	ah, ah
loc_204CF:
	mov	[bp+var_10C], ax
	mov	al, [bp+arg_5]
	sub	ah, ah
	test	[bp+var_10C], ax
	jnz	short loc_2050C
	PUSH_OFFSET(s_repelledAttack)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
	mov	[bp+var_2], 0
loc_2050C:
	cmp	[bp+var_2], 0
	jnz	short loc_20515
	jmp	loc_20810
loc_20515:
	push	[bp+spellRange]
	push	[bp+partySlotNumber]
	CALL(bat_isPartyInRange, near)
	mov	[bp+var_4], ax
	or	ax, ax
	jz	loc_207F3
	cmp	ax, 2
	jnz	short loc_2053B
	mov	gs:byte_41E63, 4
loc_2053B:
	mov	al, [bp+breathFlags]
	sub	ah, ah
	and	ax, 2
	push	ax
	push	[bp+partySlotNumber]
	CALL(savingThrowCheck, near)
	mov	[bp+var_118], ax
	or	ax, ax
	jnz	short loc_20559
	jmp	loc_207D4
loc_20559:
	cmp	ax, 1
	jnz	short loc_20567
	sar	gs:damageAmount, 1
loc_20567:
	test	[bp+breathFlags], 3
	jz	short loc_2058E
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_2058E
	cmp	gs:songHalfDamage, 0
	jz	short loc_2058E
	sar	gs:damageAmount, 1
loc_2058E:
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_205B0
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:party.strongElement[bx]
	sub	ah, ah
	jmp	short loc_205CF
loc_205B0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.strongElement[bx]
	sub	ah, ah
loc_205CF:
	mov	[bp+var_108], ax
	mov	al, [bp+arg_3]
	sub	ah, ah
	and	[bp+var_108], ax
	mov	[bp+counter], 0
	jmp	short loc_205E8
loc_205E4:
	inc	[bp+counter]
loc_205E8:
	cmp	[bp+counter], 7
	jge	short loc_2060F
	mov	bx, [bp+counter]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	test	[bp+var_108], ax
	jz	short loc_2060D
	sar	gs:damageAmount, 1
loc_2060D:
	jmp	short loc_205E4
loc_2060F:
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_20631
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:party.weakElement[bx]
	sub	ah, ah
	jmp	short loc_20650
loc_20631:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.weakElement[bx]
	sub	ah, ah
loc_20650:
	mov	[bp+var_6], ax
	mov	al, [bp+arg_3]
	sub	ah, ah
	and	[bp+var_6], ax
	mov	[bp+counter], 0
	jmp	short loc_20667
loc_20663:
	inc	[bp+counter]
loc_20667:
	cmp	[bp+counter], 7
	jge	short loc_2068D
	mov	bx, [bp+counter]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	test	[bp+var_6], ax
	jz	short loc_2068B
	shl	gs:damageAmount, 1
loc_2068B:
	jmp	short loc_20663
loc_2068D:
	mov	ax, gs:damageAmount
	mov	cl, [bp+specialAttackIndex]
	sub	ch, ch
	or	ax, cx
	jnz	short loc_206A1
	jmp	loc_207B5
loc_206A1:
	PUSH_OFFSET(s_is)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
	mov	bl, [bp+arg_4]
	sub	bh, bh
	and	bl, 0FEh
	shl	bx, 1
	push	word ptr (breathEffectStr+2)[bx]
	push	word ptr breathEffectStr[bx]
	push	dx
	push	ax
	STRCAT(outputStringP)
	PUSH_OFFSET(a_for)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
	xor	ax, ax
	push	ax
	mov	ax, gs:damageAmount
	cwd
	push	dx
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	ITOA(outputStringP)
	mov	ax, gs:damageAmount
	dec	ax
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	mov	ax, offset aPointSOfDamage
	push	ds
	push	ax
	PLURALIZE(outputStringP)
	mov	al, [bp+specialAttackIndex]
	sub	ah, ah
	mov	gs:specialAttackVal, ax
	mov	al, gs:bat_curTarget
	push	ax
	CALL(bat_doHPDamage)
	or	ax, ax
	jz	short loc_207A7
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	CALL(bat_getKillString)
	SAVE_PTR_STACK(dx,ax,outputStringP)
	mov	ax, 1
	push	ax
	mov	ax, 3
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	CALL(printCharPronoun)
	SAVE_PTR_STACK(dx,ax,outputStringP)
	jmp	short loc_207D2
loc_207A7:
	PUSH_OFFSET(s_period)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
	jmp	short loc_207D2
loc_207B5:
	PUSH_OFFSET(s_repelledAttack)
	STRCAT(outputStringP)
loc_207D2:
	jmp	short loc_207F1
loc_207D4:
	PUSH_OFFSET(s_repelledAttack)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
loc_207F1:
	jmp	short loc_20810
loc_207F3:
	PUSH_OFFSET(s_wasTooFarAway)
	PUSH_STACK_PTR(outputStringP)
	STRCAT(outputStringP)
loc_20810:
	lfs	bx, [bp+outputStringP]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(stringBuf)
	PRINTSTRING
	mov	byte ptr g_printPartyFlag,	0
	DELAY
	lea	ax, [bp+stringBuf]
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], ss
	lfs	bx, [bp+outputStringP]
	mov	byte ptr fs:[bx], 0
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_20868
	test	[bp+breathFlags], 40h
	jnz	short loc_20868
	mov	[bp+target], 0FFFFh
loc_20868:
	dec	[bp+target]
	jmp	loc_20324
loc_2086F:
	test	[bp+breathFlags], breath_allFoes
	jz	short loc_20896
	test	gs:bat_curTarget, 80h
	jz	short loc_20896
	cmp	gs:bat_curTarget, 83h
	jz	short loc_20896
	mov	[bp+var_110], 1
	inc	gs:bat_curTarget
	jmp	short loc_2089C
loc_20896:
	mov	[bp+var_110], 0
loc_2089C:
	cmp	[bp+var_110], 0
	jnz	loc_201C6
bat_doBreathAttack_exit:
	FUNC_EXIT
	retf
bat_doBreathAttack endp

; Attributes: bp-based frame

_canAttackChar proc far
        partySlotNumber=        word ptr  6
        specialAttackIndex= word ptr  8

	FUNC_ENTER
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)

        cmp     byte ptr gs:party._name[bx], 0			; if partySlot.isEmpty
	jz	l_return_zero					;   return 0
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
        test    gs:party.status[bx], stat_dead or stat_stoned	; if !partySlot.isDead and !partySlot.isStoned
	jz	l_return_one					;   return 1

	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)		; Character is either dead or stoned
        test    gs:party.status[bx], stat_stoned		; if partySlot.isStoned
	jnz	l_return_zero					;   return 0

								; Character is dead
        cmp     [bp+specialAttackIndex], speAtt_possess		; if specialAttackIndex != speAtt_possess
        jnz     short l_return_zero				;   return 0
l_return_one:
	mov	ax, 1
	jmp	l_return
l_return_zero:
        sub     ax, ax
l_return:
	FUNC_EXIT
        retf
_canAttackChar endp
