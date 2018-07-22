; Attributes: bp-based frame

; Return 0 if the mouse is in the bigpic window
mouse_inBigpic proc far
	FUNC_ENTER

	mov	ax, mouseBoxes._left
	cmp	g_mouseX, ax
	jl	short l_returnOne
	mov	ax, mouseBoxes._right
	cmp	g_mouseX, ax
	jge	short l_returnOne
	mov	ax, mouseBoxes._top
	cmp	g_mouseY, ax
	jl	short l_returnOne
	mov	ax, mouseBoxes._bottom
	cmp	g_mouseY, ax
	jl	short l_returnZero

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
mouse_inBigpic endp
