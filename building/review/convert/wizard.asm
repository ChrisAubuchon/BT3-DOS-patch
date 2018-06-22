; Attributes: bp-based frame

mage_convertWizardCheck proc far

	slotNumber= word ptr	 6

	FUNC_ENTER

	mov	ax, 2Ah
	push	ax
	push	[bp+slotNumber]
	CALL(mage_hasBeenClass, near)
	or	ax, ax
	jnz	short l_returnZero

	push	[bp+slotNumber]
	CALL(mage_countClassesGained, near)
	cmp	ax, 2
	jl	short l_returnZero

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
mage_convertWizardCheck endp
