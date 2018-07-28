; Attributes: bp-based frame

character_learnedSpell proc far

	slotNumber=	word ptr  6
	spellNumber= word ptr	 8

	FUNC_ENTER

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, [bp+spellNumber]
	mov	cl, 3
	sar	ax, cl
	add	bx, ax
	mov	al, gs:party.spells[bx]
	sub	ah, ah
	mov	bx, [bp+spellNumber]
	and	bx, 7
	mov	cl, g_byteMaskList[bx]
	sub	ch, ch
	and	ax, cx

	FUNC_EXIT
	retf
character_learnedSpell endp
