; Attributes: bp-based frame

bat_getRandomChar proc far

	currentSlot= word ptr	-4
	counter= word ptr -2
	_mask= word ptr	 6

	FUNC_ENTER(4)

	mov	[bp+counter], 0
l_loop:
	CALL(random)
	and	ax, [bp+_mask]
	mov	[bp+currentSlot], ax
	push	ax
	CALL(bat_charIsAttackable, near)
	or	ax, ax
	jz	short l_next

	mov	ax, [bp+currentSlot]
	jmp	short l_return

l_next:
	inc	[bp+counter]
	cmp	[bp+counter], 7
	jl	short l_loop

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_getRandomChar endp

