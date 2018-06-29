; Attributes: bp-based frame

temple_getStatusAilment proc far

	counter= word ptr -4
	status=	word ptr -2
	targetSlotNumber= word ptr	 6

	FUNC_ENTER(4)

	CHARINDEX(ax, STACKVAR(targetSlotNumber), bx)
	mov	al, gs:party.status[bx]
	sub	ah, ah
	mov	[bp+status], ax
	or	ax, ax
	jz	short l_returnZero
	mov	[bp+counter], 6

l_loopEntry:
	mov	bx, [bp+counter]
	mov	al, templeStatusBitmasks[bx]
	sub	ah, ah
	test	[bp+status], ax
	jnz	l_returnValue
	dec	[bp+counter]
	cmp	[bp+counter], 0
	jge	short l_loopEntry

l_returnValue:
	mov	al, templeHealPriceIndex[bx]
	jmp	l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
temple_getStatusAilment endp
