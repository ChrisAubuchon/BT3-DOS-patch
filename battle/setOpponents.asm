; Attributes: bp-based frame

bat_setOpponents proc far

	var_E= word ptr	-0Eh
	currentGroupSize= word ptr	-0Ch
	monsterDataP= dword ptr -0Ah
	currentMonsterIndex= word ptr	-6
	currentGroupIndex= word ptr	-4
	monsterTypeIndex= word ptr	-2

	FUNC_ENTER(0Eh)
	push	si

	CALL(bat_reset, near)
	mov	gs:byte_422A4, 1

	cmp	gs:bat_curSong,	0
	jz	short l_skipSongConversion

	mov	al, gs:g_currentSong
	sub	ah, ah
	push	ax
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	push	gs:party.level[bx]
	CALL(bat_convertSongToCombat, near)

l_skipSongConversion:
	cmp	g_partyAttackFlag, 0
	jz	short l_notPartyAttack

	sub	ax, ax
	push	ax
	CALL(bat_monResetGroups, near)
	jmp	l_return

l_notPartyAttack:
	cmp	gs:g_nonRandomBattleFlag, 0
	jnz	short l_getGroup

l_getGroupCount:
	CALL(random)
	and	al, 3
	mov	g_monsterGroupCount, al
	cmp	al, g_levelNumber
	ja	short l_getGroupCount
	inc	g_monsterGroupCount

l_getGroup:
	mov	[bp+currentGroupIndex], 0

l_setGroupLoop:
	cmp	gs:g_nonRandomBattleFlag, 0
	jz	short l_selectRandomMonsterGroup

	MONINDEX(ax, STACKVAR(currentGroupIndex), si)
	mov	al, byte ptr gs:monGroups._name[si]	; Monster type index is stored in the
	sub	ah, ah					; first byte of the _name field for
	mov	[bp+monsterTypeIndex], ax		; hardcoded encounters
	MONINDEX(ax, STACKVAR(monsterTypeIndex))
	add	ax, offset monsterBuf
	mov	word ptr [bp+monsterDataP], ax
	mov	word ptr [bp+monsterDataP+2], seg seg023
	mov	al, gs:monGroups.groupSize[si]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+currentGroupSize], ax
	lfs	bx, [bp+monsterDataP]
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 0E0h
	mov	[bp+var_E], ax
	jmp	short l_copyMonsterData

l_selectRandomMonsterGroup:
	mov	ax, 23
	push	ax
	sub	ax, ax
	push	ax
	CALL(randomBetweenXandY, near)
	mov	[bp+monsterTypeIndex], ax
	MONINDEX(ax, STACKVAR(monsterTypeIndex))
	add	ax, offset monsterBuf
	mov	word ptr [bp+monsterDataP], ax
	mov	word ptr [bp+monsterDataP+2], seg seg023
	lfs	bx, [bp+monsterDataP]
	test	fs:[bx+mon_t.flags], mon_noSummon
	jnz	short l_selectRandomMonsterGroup

	cmp	byte ptr fs:[bx], 0
	jz	short l_selectRandomMonsterGroup

	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 0E0h
	mov	[bp+var_E], ax
	test	fs:[bx+mon_t.groupSize], 1Fh
	jz	short l_setMinimumGroupSize

	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 1Fh
	push	ax
	mov	ax, 1
	push	ax
	CALL(randomBetweenXandY, near)
	jmp	short l_setGroupSize

l_setMinimumGroupSize:
	mov	ax, 1

l_setGroupSize:
	mov	[bp+currentGroupSize], ax

l_copyMonsterData:
	MONINDEX(ax, STACKVAR(currentGroupIndex), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+monsterDataP+2]
	push	word ptr [bp+monsterDataP]
	CALL(bat_monCopyBuffer)
	mov	al, byte ptr [bp+var_E]
	or	al, byte ptr [bp+currentGroupSize]
	mov	cx, ax
	MONINDEX(ax, STACKVAR(currentGroupIndex), bx)
	mov	gs:monGroups.groupSize[bx], cl

	mov	[bp+currentMonsterIndex], 0
l_setGroupHpLoop:
	MONINDEX(ax, STACKVAR(currentGroupIndex), si)
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	CALL(randomYdX, near)
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bx, [bp+currentGroupIndex]
	mov	ax, cx
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+currentMonsterIndex]
	shl	cx, 1
	add	bx, cx
	mov	gs:monHpList[bx], ax
	inc	[bp+currentMonsterIndex]
	mov	ax, [bp+currentGroupSize]
	cmp	[bp+currentMonsterIndex], ax
	jl	short l_setGroupHpLoop

	inc	[bp+currentGroupIndex]
	mov	al, g_monsterGroupCount
	sub	ah, ah
	cmp	ax, [bp+currentGroupIndex]
	ja	l_setGroupLoop

	cmp	g_monsterGroupCount, 4
	jnb	short l_return

	mov	al, g_monsterGroupCount
	sub	ah, ah
	push	ax
	CALL(bat_monResetGroups, near)

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_setOpponents endp
