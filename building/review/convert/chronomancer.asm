; Attributes: bp-based frame

mage_convertChronomancerCheck proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	mov	ax, 46h	
	push	ax
	push	[bp+slotNumber]
	CALL(character_hasBeenClass)
	or	ax, ax
	jnz	short l_returnZero

	push	[bp+slotNumber]
	CALL(character_countClassesGained, near)
	cmp	ax, 2
	jl	short l_returnZero

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
mage_convertChronomancerCheck endp
