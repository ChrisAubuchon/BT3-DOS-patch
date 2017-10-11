; Attributes: bp-based frame

sp_healSpell proc far

	partySlotNumber=	word ptr  6
	spellNo= word ptr  8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
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
	near_call	_doHeal,6
	jmp	short l_return
l_healAll:
	mov	gs:bat_curTarget, 0
l_healAllLoop:
	push	[bp+spellNo]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	[bp+partySlotNumber]
	near_call	_doHeal,6
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

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
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
	near_call	rnd_Xd4,2
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
	getCharP	[bp+partySlotNumber], bx
	mov	ax, gs:roster.level[bx]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	push	ax
	near_call	rnd_Xd4,2
	mov	[bp+hpToHeal], ax

l_healHp:
	getCharP	[bp+target], si
	mov	ax, [bp+hpToHeal]
	add	gs:roster.currentHP[si], ax
	mov	ax, gs:roster.maxHP[si]
	cmp	gs:roster.currentHP[si], ax
	ja	short l_setToMaxHp
	cmp	[bp+effectFlag], heal_fullHeal
	jnz	short l_cureStatus
l_setToMaxHp:
	getCharP	[bp+target], si
	mov	ax, gs:roster.maxHP[si]
	mov	gs:roster.currentHP[si], ax
l_cureStatus:
	mov	bx, [bp+spellNo]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	and	ax, 7Fh
	jmp	l_switchStatus
	; jmp	l_return			; Unreachable

l_fleshrestore:
	; Clears stat_poisoned, state_paralyzed, and stat_nuts
	getCharP	[bp+target], bx
	and	gs:roster.status[bx], 0AEh
	jmp	l_return

l_cureStoned:
	; Clears stat_dead and stat_stoned if not stoned
	getCharP	[bp+target], bx
	test	gs:roster.status[bx], stat_stoned
	jz	short l_stonedReturn
	getCharP	[bp+target], bx
	and	gs:roster.status[bx], 0F3h
	push	[bp+target]
	near_call	_sp_postHeal,2
l_stonedReturn:
	jmp	l_return

l_curePossession:
	; Clears stat_possessed
	getCharP	[bp+target], bx
	test	gs:roster.status[bx], stat_possessed
	jz	short l_curePossessionReturn
	mov	ax, gs:roster.maxHP[si]
	mov	gs:roster.currentHP[si], ax
	getCharP	[bp+target], bx
	and	gs:roster.status[bx], 0DFh
	push	[bp+target]
	near_call _sp_postHeal,2
l_curePossessionReturn:
	jmp	l_return

l_cureDeath:
	; Clears stat_dead if dead
	getCharP	[bp+target], bx
	test	gs:roster.status[bx], stat_dead
	jz	short l_cureDeathReturn
	getCharP	[bp+target], bx
	and	gs:roster.status[bx], 0FBh
	push	[bp+target]
	near_call _sp_postHeal,2
l_cureDeathReturn:
	jmp	short l_return

l_cureOld:
	; Clears stat_old if old
	getCharP	[bp+target], si
	test	gs:roster.status[si], stat_old
	jz	short l_cureOldReturn
	and	gs:roster.status[si], 0FDh
	mov	ax, 5
	push	ax
	lea	ax, roster.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, roster.savedST[si]
	push	dx
	push	ax
	call	_doAgeStatus
	add	sp, 0Ah
l_cureOldReturn:
	jmp	short l_return

l_healall:
	; Clears stat_nuts, stat_paralyzed, stat_dead and stat_poisoned
	getCharP	[bp+target], si
	and	gs:roster.status[si], 0AAh
	mov	gs:roster.hostileFlag[si], 0
	jmp	short l_return

	; Following two lines were unreachable. 
	;mov	byte ptr word_44166,	0
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

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+partySlotNumber], bx
	cmp	gs:roster.currentHP[bx], 0
	jnz	short l_notDead
	getCharP	[bp+partySlotNumber], bx
	mov	gs:roster.currentHP[bx], 1
l_notDead:
	getCharP	[bp+partySlotNumber], bx
	mov	gs:roster.hostileFlag[bx], 0
	mov	bx, [bp+partySlotNumber]
	mov	gs:charActionList[bx], 0
	mov	sp, bp
	pop	bp
	retf
_sp_postHeal endp

