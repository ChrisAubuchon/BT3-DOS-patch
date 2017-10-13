noncombatCast proc far

	castSlotNumber= word ptr	-6
	spellTargetFlag= word ptr	-4
	var_2= word ptr	-2
	inFunctionKey= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	cmp	[bp+inFunctionKey], 0
	jz	short l_askForCaster
	mov	ax, [bp+inFunctionKey]
	sub	ax, dosKeys_F1
	mov	cl, 8
	sar	ax, cl
	mov	[bp+castSlotNumber], ax
	jmp	short l_checkCaster
l_askForCaster:
	push_ds_string	aWhoWillCastASp
	std_call	printStringWClear,4
	call	getCharNumber
	mov	[bp+castSlotNumber], ax
l_checkCaster:
	cmp	[bp+castSlotNumber], 0
	jl	l_returnOne

	getCharP	[bp+castSlotNumber], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_returnZero

	getCharP	[bp+castSlotNumber], bx
	mov	bl, gs:roster.class[bx]
	sub	bh, bh
	cmp	mageSpellIndex[bx], 0FFh
	jnz	short l_isSpellCaster

	push_ds_string	aThouArtNotAS_0
	std_call	printStringWClear,4
	wait4IO
	jmp	short l_returnZero
l_isSpellCaster:
	sub	ax, ax
	push	ax
	push	[bp+castSlotNumber]
	near_call	getSpellNumber,4
	mov	[bp+spellTargetFlag], ax
	or	ax, ax
	jl	l_returnZero

	cmp	[bp+spellTargetFlag], 4
	jge	short l_doCast
	push_ds_string	aCastAt
	push	[bp+spellTargetFlag]
	std_call	getTarget,6
	mov	[bp+var_2], ax
	or	ax, ax
	jl	l_returnZero
	mov	al, byte ptr [bp+var_2]
	mov	gs:bat_curTarget, al
l_doCast:
	call	clearTextWindow
	mov	ax, 1
	push	ax
	sub	ax, ax
	push	ax
	push	g_curSpellNumber
	push	[bp+castSlotNumber]
	near_call	doCastSpell,8
	delayNoTable	2
l_returnOne:
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
noncombatCast endp
