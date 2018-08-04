; Attributes: bp-based frame

bat_monMeleeRoll proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	monNo= word ptr	 6
	target=	word ptr  8
	field_17= word ptr  0Ah
	spAttack = word ptr 0Ch

	FUNC_ENTER(4)
	push	si

	mov	gs:g_specialAttackValue, 0
	mov	gs:g_damageAmount, 0
	mov	bx, [bp+target]
	cmp	gs:g_characterMeleeDistance[bx], 0
	jnz	l_returnZero

	CHARINDEX(ax, bx, bx)
	mov	al, gs:party.ac[bx]
	cbw
	mov	bx, [bp+monNo]
	mov	cl, gs:g_monsterSpellToHitPenalty[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+var_2], ax
	cmp	ax, 3Fh
	jle	short l_underMax
	mov	[bp+var_2], 3Fh

l_underMax:
	MONINDEX(ax, bx, si)
	mov	al, gs:g_monGroups.toHitHi[si]
	sub	ah, ah
	push	ax
	mov	al, gs:g_monGroups.toHitLo[si]
	push	ax
	CALL(randomBetweenXandY, near)
	mov	bx, [bp+monNo]
	mov	cl, gs:monAttackBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	[bp+var_4], cx
	mov	ax, [bp+var_2]
	cmp	cx, ax
	jl	short l_returnZero

	; Add monster special attack
	mov	ax, [bp+spAttack]
	mov	gs:g_specialAttackValue, ax

	push	[bp+field_17]
	CALL(randomYdX, near)
	mov	bx, [bp+monNo]
	mov	cl, gs:monAttackBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	gs:g_damageAmount, cx
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_monMeleeRoll endp
