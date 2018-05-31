; Attributes: bp-based frame

bat_charIsAttackable proc far

	slotNumber= word ptr	 6

	FUNC_ENTER

	cmp	[bp+slotNumber], 7
	jz	l_returnZero
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_returnZero

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_illusion
	jnz	short l_notIllusion
	cmp	gs:monDisbelieveFlag, 0
	jz	l_returnZero

l_notIllusion:
	mov	bx, [bp+slotNumber]
	cmp	gs:g_characterMeleeDistance[bx], 0
	jnz	l_returnZero

	CHARINDEX(ax, bx, bx)
	mov	al, gs:party.status[bx]
	and	al, 0Ch
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
bat_charIsAttackable endp
