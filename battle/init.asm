; Entry	point for a battle
; Attributes: bp-based frame

bat_init proc far

	var_8= word ptr	-8
	currentSinger= word ptr	-6
	var_4= word ptr	-4
	currentSong= word ptr	-2

	FUNC_ENTER(8)

	mov	al, gs:g_currentSongPlusOne
	mov	gs:bat_curSong,	al
	mov	al, gs:g_currentSong
	sub	ah, ah
	mov	[bp+currentSong], ax

	mov	al, gs:g_currentSinger
	mov	[bp+currentSinger], ax
	call	endNoncombatSong

	CALL(bat_setOpponents, near)

	mov	[bp+var_8], 0
	sub	al, al
	mov	gs:partyFrozenFlag, al
	mov	gs:runAwayFlag,	al

l_roundStart:
	CALL(bat_monSortGroups, near)
	CALL(bat_setBigpic, near)
	push	[bp+var_8]
	inc	[bp+var_8]
	CALL(bat_printOpponents, near)

	cmp	gs:partyFrozenFlag, 0
	jnz	short l_doRound

	CALL(bat_partyGetActions, near)
	cmp	gs:runAwayFlag,	0
	jz	short l_doRound

partyRan:
	push	[bp+currentSong]
	push	[bp+currentSinger]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	CALL(bat_end)
	sub	ax, ax
	jmp	l_return

l_doRound:
	mov	gs:txt_numLines, 0Bh
	CALL(bat_doRound)
	CALL(bat_partyDisbelieves)
	cmp	gs:monDisbelieveFlag, 0
	jnz	short l_noDisbelieve
	CALL(bat_isAMonGroupActive)
	or	ax, ax
	jz	short l_noDisbelieve
	CALL(bat_monDisbelieve)

l_noDisbelieve:
	CALL(bat_partyApplyPoison)
	CALL(party_applyEquipmentEffects)
	mov	al, gs:songRegenHP
	sub	ah, ah
	push	ax
	CALL(bat_partyApplyHpRegen)
	mov	al, gs:monDisbelieveFlag
	sub	ah, ah
	push	ax
	CALL(bat_postRound)
	CALL(bat_endCombatSong, near)
	mov	byte ptr g_printPartyFlag,	0
	CALL(party_getLastSlot)
	cmp	ax, 7
	jle	short l_partyAlive

party_died:
	push	[bp+currentSong]
	push	[bp+currentSinger]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	CALL(bat_end)
	mov	ax, 1
	jmp	short l_return

l_partyAlive:
	CALL(bat_isAMonGroupActive)
	or	ax, ax
	jz	short l_noMoreEnemies
	CALL(_return_zero)
	or	ax, ax
	jz	l_roundStart

l_noMoreEnemies:
	cmp	g_partyAttackFlag, 0
	jz	short partyWon
	PRINTOFFSET(s_continueQuestion, clear)
	CALL(getYesNo)
	or	ax, ax
	jnz	l_roundStart
	push	[bp+currentSong]
	push	[bp+currentSinger]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	CALL(bat_end)
	sub	ax, ax
	jmp	short l_return

partyWon:
	CALL(bat_getReward)
	mov	[bp+var_4], ax
	push	[bp+currentSong]
	push	[bp+currentSinger]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	CALL(bat_end)
	mov	ax, [bp+var_4]
	jmp	short l_return

l_return:
	FUNC_EXIT
	retf
bat_init endp
