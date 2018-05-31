noncombatCast proc far

	castSlotNumber= word ptr	-6
	spellTargetFlag= word ptr	-4
	var_2= word ptr	-2
	inFunctionKey= word ptr	 6

	FUNC_ENTER(6)

	cmp	[bp+inFunctionKey], 0
	jz	short l_askForCaster
	mov	ax, [bp+inFunctionKey]
	sub	ax, dosKeys_F1
	mov	cl, 8
	sar	ax, cl
	mov	[bp+castSlotNumber], ax
	jmp	short l_checkCaster
l_askForCaster:
	PUSH_OFFSET(s_whoWillCast)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+castSlotNumber], ax
l_checkCaster:
	cmp	[bp+castSlotNumber], 0
	jl	l_returnOne

	CHARINDEX(ax, STACKVAR(castSlotNumber), bx)
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_returnZero

	CHARINDEX(ax, STACKVAR(castSlotNumber), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	cmp	mageSpellIndex[bx], 0FFh
	jnz	short l_isSpellCaster

	PUSH_OFFSET(s_notSpellcaster)
	PRINTSTRING(4)
	IOWAIT
	jmp	short l_returnZero
l_isSpellCaster:
	sub	ax, ax
	push	ax
	push	[bp+castSlotNumber]
	CALL(getSpellNumber, near)
	mov	[bp+spellTargetFlag], ax
	or	ax, ax
	jl	l_returnZero

	cmp	[bp+spellTargetFlag], 4
	jge	short l_doCast
	PUSH_OFFSET(s_castAt)
	push	[bp+spellTargetFlag]
	CALL(bat_charGetActionTarget)
	mov	[bp+var_2], ax
	or	ax, ax
	jl	l_returnZero
	mov	al, byte ptr [bp+var_2]
	mov	gs:bat_curTarget, al
l_doCast:
	CALL(text_clear)
	mov	ax, 1
	push	ax
	sub	ax, ax
	push	ax
	push	g_curSpellNumber
	push	[bp+castSlotNumber]
	CALL(doCastSpell, near)
	DELAY(2)
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
