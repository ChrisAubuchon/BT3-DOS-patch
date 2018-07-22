; Attributes: bp-based frame

scroll_checkArrowClick proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER(4)

	mov	[bp+var_2], 0

	; Check if the mouse is in the text window
	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	cmp	g_mouseX, ax
	jl	l_return

	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	cmp	g_mouseX, ax
	jge	short l_return

	mov	ax, mouseBoxes._top[1 * sizeof mouseBox_t]
	cmp	g_mouseY, ax
	jl	short l_return

	mov	ax, mouseBoxes._bottom[1 * sizeof mouseBox_t]
	cmp	g_mouseY, ax
	jge	short l_return

	mov	ax, g_mouseY
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_4], ax
	cmp	ax, 0Bh
	jnz	short l_checkListItem

l_checkUpArrow:
	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	add	ax, 32h	
	cmp	g_mouseX, ax
	jge	short l_checkEsc
	mov	ax, dosKeys_upArrow
	jmp	short l_return

l_checkEsc:
	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	sub	ax, 32h	
	cmp	g_mouseX, ax
	jge	short l_checkDownArrow
	mov	ax, dosKeys_ESC
	jmp	short l_return

l_checkDownArrow:
	mov	ax, dosKeys_downArrow
	jmp	short l_return

l_checkListItem:
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_4]
	shl	bx, 1
	test	g_mouseLineMaskList[bx], ax
	jz	short l_returnZero
	mov	ax, [bp+var_4]
	add	ax, 10Eh
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	FUNC_EXIT
	retf
scroll_checkArrowClick endp
