; Attributes: bp-based frame

bat_setOpponents proc far

	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= dword ptr -0Ah
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Eh
	call	someStackOperation
	push	si
	push	cs
	call	near ptr bat_resetData
	mov	gs:byte_422A4, 1
	cmp	gs:bat_curSong,	0
	jz	short loc_1C7D3
	mov	al, gs:g_currentSong
	sub	ah, ah
	push	ax
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	push	gs:party.level[bx]
	push	cs
	call	near ptr bat_convertSongToCombat
	add	sp, 4
loc_1C7D3:
	cmp	g_partyAttackFlag, 0
	jz	short loc_1C7EC
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr bat_zeroMonGroups
	add	sp, 2
	jmp	loc_1C992
loc_1C7EC:
	cmp	gs:g_nonRandomBattleFlag, 0
	jnz	short loc_1C81D
loc_1C7F8:
	call	random
	and	al, 3
	mov	g_monsterGroupCount, al
	cmp	al, g_levelNumber
	jbe	short loc_1C814
	jmp	short loc_1C7F8
loc_1C814:
	inc	g_monsterGroupCount
loc_1C81D:
	mov	[bp+var_4], 0
	jmp	short loc_1C827
loc_1C824:
	inc	[bp+var_4]
loc_1C827:
	mov	al, g_monsterGroupCount
	sub	ah, ah
	cmp	ax, [bp+var_4]
	ja	short loc_1C839
	jmp	loc_1C978
loc_1C839:
	cmp	gs:g_nonRandomBattleFlag, ah
	jz	short loc_1C889
	getMonP	[bp+var_4], si
	mov	al, byte ptr gs:monGroups._name[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	getMonIndex	ax, [bp+var_2]
	add	ax, offset monsterBuf
	mov	word ptr [bp+var_A], ax
	mov	word ptr [bp+var_A+2], seg seg023
	mov	al, gs:monGroups.groupSize[si]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_C], ax
	lfs	bx, [bp+var_A]
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 0E0h
	mov	[bp+var_E], ax
	jmp	short loc_1C8EB
loc_1C889:
	mov	ax, 23
	push	ax
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	[bp+var_2], ax
	getMonIndex	ax, [bp+var_2]
	add	ax, offset monsterBuf
	mov	word ptr [bp+var_A], ax
	mov	word ptr [bp+var_A+2], seg seg023
	lfs	bx, [bp+var_A]
	test	fs:[bx+mon_t.flags], mon_noSummon
	jnz	short loc_1C889
	cmp	byte ptr fs:[bx], 0
	jz	short loc_1C889
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 0E0h
	mov	[bp+var_E], ax
	test	fs:[bx+mon_t.groupSize], 1Fh
	jz	short loc_1C8E5
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 1Fh
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	jmp	short loc_1C8E8
loc_1C8E5:
	mov	ax, 1
loc_1C8E8:
	mov	[bp+var_C], ax
loc_1C8EB:
	getMonP	[bp+var_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+var_A+2]
	push	word ptr [bp+var_A]
	push	cs
	call	near ptr mon_copyBuffer
	add	sp, 8
	mov	al, byte ptr [bp+var_E]
	or	al, byte ptr [bp+var_C]
	mov	cx, ax
	getMonP	[bp+var_4], bx
	mov	gs:monGroups.groupSize[bx], cl
	mov	[bp+var_6], 0
	jmp	short loc_1C92C
loc_1C929:
	inc	[bp+var_6]
loc_1C92C:
	mov	ax, [bp+var_C]
	cmp	[bp+var_6], ax
	jge	short loc_1C975
	getMonP	[bp+var_4], si
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bx, [bp+var_4]
	mov	ax, cx
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+var_6]
	shl	cx, 1
	add	bx, cx
	mov	gs:monHpList[bx], ax
	jmp	short loc_1C929
loc_1C975:
	jmp	loc_1C824
loc_1C978:
	cmp	g_monsterGroupCount, 4
	jnb	short loc_1C992
	mov	al, g_monsterGroupCount
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr bat_zeroMonGroups
	add	sp, 2
loc_1C992:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_setOpponents endp
