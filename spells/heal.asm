; Attributes: bp-based frame

sp_healSpell proc far

	partySlotNumber=	word ptr  6
	spellNo= word ptr  8

	FUNC_ENTER
	CHKSTK

	cmp	[bp+partySlotNumber], 80h
	jge	short l_return
	mov	bx, [bp+spellNo]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	cmp	ax, heal_allFlag
	jge	short l_healAll
	push	bx
	mov	al, gs:bat_curTarget
	push	ax
	push	[bp+partySlotNumber]
	CALL(_doHeal, near)
	jmp	short l_return
l_healAll:
	mov	gs:bat_curTarget, 0
l_healAllLoop:
	push	[bp+spellNo]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	[bp+partySlotNumber]
	CALL(_doHeal, near)
	inc	gs:bat_curTarget
	cmp	gs:bat_curTarget, 7
	jb	short l_healAllLoop
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_healSpell endp

; Attributes: bp-based frame

_doHeal	proc far

	hpToHeal= word ptr -4
	effectFlag= word ptr -2
	partySlotNumber=	word ptr  6
	target=	word ptr  8
	spellNo= word ptr  0Ah

	FUNC_ENTER
	CHKSTK(6)
	push	si

	mov	bx, [bp+spellNo]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+effectFlag], ax
	mov	[bp+hpToHeal], 0

	cmp	ax, heal_fullHeal	; effectFlag < 0xfd means to heal effectFlagd4
					; hit points.
	jge	short l_quickFixCheck
	push	ax
	CALL(rnd_Xd4, near)
	mov	[bp+hpToHeal], ax
	jmp	short l_healHp

l_quickFixCheck:
	; Heal 8 points of damage. This is the magician spell
	; quick fix
	cmp	[bp+effectFlag], 0FEh 
	jnz	short l_healTimesLevel
	mov	[bp+hpToHeal], 8
	jmp	short l_healHp

l_healTimesLevel:
	; Heal Xd4 where X is the casters level
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	mov	ax, gs:party.level[bx]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	push	ax
	CALL(rnd_Xd4, near)
	mov	[bp+hpToHeal], ax

l_healHp:
	CHARINDEX(ax, STACKVAR(target), si)
	mov	ax, [bp+hpToHeal]
	add	gs:party.currentHP[si], ax
	mov	ax, gs:party.maxHP[si]
	cmp	gs:party.currentHP[si], ax
	ja	short l_setToMaxHp
	cmp	[bp+effectFlag], heal_fullHeal
	jnz	short l_cureStatus
l_setToMaxHp:
	CHARINDEX(ax, STACKVAR(target), si)
	mov	ax, gs:party.maxHP[si]
	mov	gs:party.currentHP[si], ax
l_cureStatus:
	mov	bx, [bp+spellNo]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	and	ax, 7Fh
	jmp	l_switchStatus

l_fleshrestore:
	; Clears stat_poisoned, state_paralyzed, and stat_nuts
	CHARINDEX(ax, STACKVAR(target), bx)
	and	gs:party.status[bx], 0AEh
	jmp	l_return

l_cureStoned:
	; Clears stat_dead and stat_stoned if not stoned
	CHARINDEX(ax, STACKVAR(target), bx)
	test	gs:party.status[bx], stat_stoned
	jz	short l_stonedReturn
	CHARINDEX(ax, STACKVAR(target), bx)
	and	gs:party.status[bx], 0F3h
	push	[bp+target]
	CALL(_sp_postHeal, near)
l_stonedReturn:
	jmp	l_return

l_curePossession:
	; Clears stat_possessed
	CHARINDEX(ax, STACKVAR(target), bx)
	test	gs:party.status[bx], stat_possessed
	jz	short l_curePossessionReturn
	CHARINDEX(ax, STACKVAR(target), bx)
	and	gs:party.status[bx], 0DFh
	push	[bp+target]
	CALL(_sp_postHeal, near)
l_curePossessionReturn:
	jmp	l_return

l_cureDeath:
	; Clears stat_dead if dead
	CHARINDEX(ax, STACKVAR(target), bx)
	test	gs:party.status[bx], stat_dead
	jz	short l_cureDeathReturn
	CHARINDEX(ax, STACKVAR(target), bx)
	and	gs:party.status[bx], 0FBh
	push	[bp+target]
	CALL(_sp_postHeal, near)
l_cureDeathReturn:
	jmp	short l_return

l_cureOld:
	; Clears stat_old if old
	CHARINDEX(ax, STACKVAR(target), si)
	test	gs:party.status[si], stat_old
	jz	short l_cureOldReturn
	and	gs:party.status[si], 0FDh
	mov	ax, 5
	push	ax
	lea	ax, party.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.savedST[si]
	push	dx
	push	ax
	CALL(_doAgeStatus)
l_cureOldReturn:
	jmp	short l_return

l_healall:
	; Clears stat_nuts, stat_paralyzed, stat_dead and stat_poisoned
	CHARINDEX(ax, STACKVAR(target), si)
	and	gs:party.status[si], 0AAh
	mov	gs:party.hostileFlag[si], 0
	jmp	short l_return

	; Following two lines were unreachable. 
	;mov	byte ptr g_printPartyFlag,	0
	;jmp	short l_return
l_switchStatus:
	cmp	ax, 6
	ja	short l_return
	add	ax, ax
	xchg	ax, bx
	jmp	cs:statusJumpTable[bx]
statusJumpTable	dw offset l_return
		dw offset l_fleshrestore
		dw offset l_cureStoned
		dw offset l_curePossession
		dw offset l_cureDeath
		dw offset l_cureOld
		dw offset l_healall
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_doHeal	endp

; This function	does some standard cleanup after
; healing. If currentHP	is zero	then it	sets it
; to one like after a Beyond Death spell. It
; calms	summoned members and sets the attack priority
; for the round	to zero.
; Attributes: bp-based frame

_sp_postHeal proc far

	partySlotNumber=	word ptr  6

	FUNC_ENTER
	CHKSTK

	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	cmp	gs:party.currentHP[bx], 0
	jnz	short l_notDead
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	mov	gs:party.currentHP[bx], 1
l_notDead:
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	mov	gs:party.hostileFlag[bx], 0
	mov	bx, [bp+partySlotNumber]
	mov	gs:charActionList[bx], 0
	mov	sp, bp
	pop	bp
	retf
_sp_postHeal endp

