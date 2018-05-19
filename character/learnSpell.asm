; Attributes: bp-based frame

character_learnSpell	proc far

	slotNumber=	word ptr  6
	spellNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellNumber]
	and	bx, 7
	mov	al, byteMaskList[bx]
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, [bp+spellNumber]
	mov	dx, cx
	mov	cl, 3
	sar	ax, cl
	add	bx, ax
	or	gs:party.spells[bx], dl

	FUNC_EXIT
	retf
character_learnSpell	endp
