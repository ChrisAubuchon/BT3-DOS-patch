; Attributes: bp-based frame

bat_monCast proc far

	slotNumber= word ptr	 6
	spellNumber= word ptr	 0Ah

	FUNC_ENTER

	mov	ax, 7
	push	ax
	CALL(bat_getRandomChar, near)
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	mov	ax, 1
	push	ax
	push	[bp+spellNumber]
	mov	ax, [bp+slotNumber]
	or	al, 80h
	push	ax
	CALL(doCastSpell)

	FUNC_EXIT
	retf
bat_monCast endp
