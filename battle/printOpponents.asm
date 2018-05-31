; Attributes: bp-based frame
bat_printOpponents proc	far

	var_10C= word ptr -10Ch
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 10Ch
	call	someStackOperation
	cmp	gs:byte_4228B, 0
	jnz	short loc_1CB98
	mov	gs:byte_4228B, 0
	cmp	[bp+arg_0], 0
	jnz	short loc_1CB89
	call	bat_isAMonGroupActive
	or	ax, ax
	jz	short loc_1CB63
	mov	ax, 6
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	jmp	short loc_1CB65
loc_1CB63:
	sub	ax, ax
loc_1CB65:
	mov	[bp+var_C], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (battleCryString+2)[bx]
	push	word ptr battleCryString[bx]
	call	printStringWClear
	add	sp, 4
	cmp	[bp+var_C], 0
	jnz	short loc_1CB87
	jmp	loc_1CC83
loc_1CB87:
	jmp	short loc_1CB96
loc_1CB89:
	mov	ax, offset aYouStillFace
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_1CB96:
	jmp	short loc_1CBA2
loc_1CB98:
	mov	gs:byte_4228B, 0
loc_1CBA2:
	lea	ax, [bp+var_10C]
	mov	[bp+var_8], ax
	mov	[bp+var_6], ss
	test	gs:monGroups.groupSize,	1Fh
	jnz	short loc_1CBCA
	mov	ax, offset aHostilePartyMembers
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1CC83
	jmp	short loc_1CBE0
loc_1CBCA:
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	push	cs
	call	near ptr bat_monPrintGroup
	add	sp, 6
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
loc_1CBE0:
	mov	[bp+var_A], 1
	jmp	short loc_1CBEA
loc_1CBE7:
	inc	[bp+var_A]
loc_1CBEA:
	cmp	[bp+var_A], 4
	jle	short loc_1CBF3
	jmp	loc_1CC83
loc_1CBF3:
	getMonP	[bp+var_A], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short loc_1CC0D
	cmp	[bp+var_A], 4
	jnz	short loc_1CC30
loc_1CC0D:
	mov	ax, offset a__1
	push	ds
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	call	strcat
	add	sp, 8
	lea	ax, [bp+var_10C]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_1CC83
loc_1CC30:
	getMonP	[bp+var_A], bx
	test	gs:stru_42372.groupSize[bx], 1Fh
	jz	short loc_1CC4A
	cmp	[bp+var_A], 2
	jnz	short loc_1CC4F
loc_1CC4A:
	mov	ax, offset aAnd_1
	jmp	short loc_1CC52
loc_1CC4F:
	mov	ax, offset asc_473AE
loc_1CC52:
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	push	ds
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	call	strcat
	add	sp, 8
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	push	[bp+var_A]
	push	dx
	push	ax
	push	cs
	call	near ptr bat_monPrintGroup
	add	sp, 6
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	jmp	loc_1CBE7
loc_1CC83:
	mov	sp, bp
	pop	bp
	retf
bat_printOpponents endp
