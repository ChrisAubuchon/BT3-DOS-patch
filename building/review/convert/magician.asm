; Attributes: bp-based frame

mage_convertMagicianCheck proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	mov	ax, 0Eh
	push	ax
	push	[bp+slotNumber]
	CALL(mage_hasBeenClass, near)
	mov	cx, ax
	cmp	cx, 1
	sbb	ax, ax
	neg	ax
	FUNC_EXIT
	retf
mage_convertMagicianCheck endp
