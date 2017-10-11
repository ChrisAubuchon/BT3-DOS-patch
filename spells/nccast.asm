noncombatCast proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	cmp	[bp+arg_0], 0
	jz	short loc_1FCAA
	mov	ax, [bp+arg_0]
	sub	ax, 3B00h
	mov	cl, 8
	sar	ax, cl
	mov	[bp+var_6], ax
	jmp	short loc_1FCBF
loc_1FCAA:
	mov	ax, offset aWhoWillCastASp
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getCharNumber
	mov	[bp+var_6], ax
loc_1FCBF:
	cmp	[bp+var_6], 0
	jge	short loc_1FCC8
	jmp	loc_1FD85
loc_1FCC8:
	getCharP	[bp+var_6], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_1FCE1
	sub	ax, ax
	jmp	loc_1FD8A
loc_1FCE1:
	getCharP	[bp+var_6], bx
	mov	bl, gs:roster.class[bx]
	sub	bh, bh
	cmp	mageSpellIndex[bx], 0FFh
	jnz	short loc_1FD14
	mov	ax, offset aThouArtNotAS_0
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	sub	ax, ax
	jmp	short loc_1FD8A
loc_1FD14:
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	cs
	call	near ptr getSpellNumber
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_1FD2C
	sub	ax, ax
	jmp	short loc_1FD8A
loc_1FD2C:
	cmp	[bp+var_4], 4
	jge	short loc_1FD5A
	mov	ax, offset aCastAt
	push	ds
	push	ax
	push	[bp+var_4]
	call	getTarget
	add	sp, 6
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1FD4F
	sub	ax, ax
	jmp	short loc_1FD8A
loc_1FD4F:
	mov	al, byte ptr [bp+var_2]
	mov	gs:bat_curTarget, al
loc_1FD5A:
	call	clearTextWindow
	mov	ax, 1
	push	ax
	sub	ax, ax
	push	ax
	push	g_curSpellNumber
	push	[bp+var_6]
	push	cs
	call	near ptr doCastSpell
	add	sp, 8
	delayNoTable	2
loc_1FD85:
	mov	ax, 1
	jmp	short $+2
loc_1FD8A:
	mov	sp, bp
	pop	bp
	retf
noncombatCast endp
