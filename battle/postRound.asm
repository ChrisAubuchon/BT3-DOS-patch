; Attributes: bp-based frame

bat_postRound proc far

	var_6= word ptr	-6
	loopCounter= word ptr -4
	lastSlotNumber= word ptr	-2
	monsterDisbelieveFlag= word ptr	 6

	FUNC_ENTER(6)
	push	si

	cmp	[bp+monsterDisbelieveFlag], 0
	jz	short l_skipDisbelieve

	mov	[bp+loopCounter], 0
l_disbelieveLoop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	gs:party.class[si], class_illusion
	jnz	short l_disbelieveLoopNext
	or	gs:party.status[si], stat_dead

l_disbelieveLoopNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_disbelieveLoop

l_skipDisbelieve:
	CALL(party_getLastSlot)
	mov	[bp+lastSlotNumber], ax
	cmp	ax, 7
	jge	l_monsterGroupHandler

	mov	[bp+loopCounter], 0
l_characterLoop:
	CALL(party_getLastSlot)
	cmp	ax, [bp+loopCounter]
	jl	l_monsterGroupHandler

	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jz	l_characterNext

	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+loopCounter]
	jnz	short loc_1EED6
	CALL(bat_endCombatSong)

loc_1EED6:
	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+loopCounter]
	jbe	short loc_1EEEA
	dec	gs:g_currentSinger

loc_1EEEA:
	push	[bp+loopCounter]
	CALL(bat_partyPackBonuses, near)

	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(copyCharacterBuf)

	push	[bp+loopCounter]
	CALL(party_pack)

	cmp	gs:newCharBuffer.class,	class_illusion
	jz	short l_characterLoop

	; BUG - I think this is supposed to be hostileFlag.
	; specAbil+3 is offset 103, hostileFlag is offset 104.
	cmp	gs:newCharBuffer.specAbil+3, 0
	jnz	l_characterLoop

	CALL(party_findEmptySlot)
	mov	[bp+var_6], ax
	CHARINDEX(ax, STACKVAR(var_6), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	push	dx
	push	ax
	CALL(copyCharacterBuf)
	jmp	l_characterLoop

l_characterNext:
	inc	[bp+loopCounter]
	jmp	l_characterLoop

l_monsterGroupHandler:
	CALL(bat_monCountGroups, near)
	or	ax, ax
	jle	short l_monsterGroupLoop

	mov	[bp+loopCounter], 0
l_monsterGroupLoop:
	CALL(bat_monCountGroups, near)
	cmp	ax, [bp+loopCounter]
	jl	short l_return

	MONINDEX(ax, STACKVAR(loopCounter), bx)
	test	gs:g_monGroups.groupSize[bx], 1Fh
	jnz	short l_monsterGroupNext

	mov	ax, [bp+loopCounter]
	mov	[bp+lastSlotNumber], ax
l_packMonsterGroups:
	cmp	[bp+lastSlotNumber], 3
	jge	short l_monsterGroupLoop
	push	[bp+lastSlotNumber]
	mov	ax, [bp+lastSlotNumber]
	inc	ax
	push	ax
	CALL(bat_monMoveGroup, near)
	inc	[bp+lastSlotNumber]
	jmp	short l_packMonsterGroups

l_monsterGroupNext:
	inc	[bp+loopCounter]
	jmp	short l_monsterGroupLoop

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_postRound endp
