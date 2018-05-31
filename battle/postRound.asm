; Attributes: bp-based frame

bat_postRound proc far

	var_6= word ptr	-6
	counter= word ptr -4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	cmp	[bp+arg_0], 0
	jz	short loc_1EE5D
	mov	[bp+counter], 0
	jmp	short loc_1EE3B
loc_1EE38:
	inc	[bp+counter]
loc_1EE3B:
	cmp	[bp+counter], 7
	jge	short loc_1EE5D
	getCharP	[bp+counter], si
	cmp	gs:party.class[si], class_illusion
	jnz	short loc_1EE5B
	or	gs:party.status[si], stat_dead
loc_1EE5B:
	jmp	short loc_1EE38
loc_1EE5D:
	call	party_getLastSlot
	mov	[bp+var_2], ax
	cmp	ax, 7
	jl	short loc_1EE6D
	jmp	loc_1EF62
loc_1EE6D:
	mov	[bp+counter], 0
loc_1EE72:
	call	party_getLastSlot
	cmp	ax, [bp+counter]
	jge	short loc_1EE7F
	jmp	loc_1EF62
loc_1EE7F:
	getCharP	[bp+counter], bx
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short loc_1EE96
	jmp	loc_1EF5C
loc_1EE96:
	mov	al, gs:byte_4255E
	sub	ah, ah
	cmp	ax, [bp+counter]
	jnz	short loc_1EEAE
	mov	gs:bat_curSong,	ah
loc_1EEAE:
	mov	al, gs:byte_4255E
	sub	ah, ah
	cmp	ax, [bp+counter]
	jbe	short loc_1EEC2
	dec	gs:byte_4255E
loc_1EEC2:
	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+counter]
	jnz	short loc_1EED6
	call	bat_endCombatSong
loc_1EED6:
	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+counter]
	jbe	short loc_1EEEA
	dec	gs:g_currentSinger
loc_1EEEA:
	push	[bp+counter]
	push	cs
	call	near ptr bat_partyPackBonuses
	add	sp, 2
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	getCharP	[bp+counter], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	copyCharacterBuf
	add	sp, 8
	push	[bp+counter]
	call	party_pack
	add	sp, 2
	cmp	gs:newCharBuffer.class,	class_illusion
	jz	short loc_1EF5A
	cmp	gs:newCharBuffer.specAbil+3, 0
	jnz	short loc_1EF5A
	call	party_findEmptySlot
	mov	[bp+var_6], ax
	getCharP	[bp+var_6], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	push	dx
	push	ax
	call	copyCharacterBuf
	add	sp, 8
loc_1EF5A:
	jmp	short loc_1EF5F
loc_1EF5C:
	inc	[bp+counter]
loc_1EF5F:
	jmp	loc_1EE72
loc_1EF62:
	push	cs
	call	near ptr bat_monCountGroups
	or	ax, ax
	jle	short loc_1EF6F
	mov	[bp+counter], 0
loc_1EF6F:
	push	cs
	call	near ptr bat_monCountGroups
	cmp	ax, [bp+counter]
	jl	short loc_1EFB5
	getMonP	[bp+counter], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jnz	short loc_1EFB0
	mov	ax, [bp+counter]
	mov	[bp+var_2], ax
	jmp	short loc_1EF97
loc_1EF94:
	inc	[bp+var_2]
loc_1EF97:
	cmp	[bp+var_2], 3
	jge	short loc_1EFAE
	push	[bp+var_2]
	mov	ax, [bp+var_2]
	inc	ax
	push	ax
	push	cs
	call	near ptr bat_monMoveGroup
	add	sp, 4
	jmp	short loc_1EF94
loc_1EFAE:
	jmp	short loc_1EFB3
loc_1EFB0:
	inc	[bp+counter]
loc_1EFB3:
	jmp	short loc_1EF6F
loc_1EFB5:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_postRound endp
