; This function sets the mouse icon. It is only called from
; text_scrollingWindow
;

; Attributes: bp-based frame

mouse_setScrollingIcon proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER(4)

	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jl	short l_notInTextWindow
	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jge	short l_notInTextWindow
	mov	ax, mouseBoxes._top[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jl	short l_notInTextWindow
	mov	ax, mouseBoxes._bottom[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jge	short l_notInTextWindow
	mov	ax, mouse_y
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_2], ax
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_2]
	shl	bx, 1
	test	bitMask16bit[bx], ax
	jz	short loc_14F2D
	mov	ax, 5
	jmp	short loc_14F30
loc_14F2D:
	mov	ax, 6
loc_14F30:
	mov	[bp+var_4], ax
	jmp	short loc_14F3A
l_notInTextWindow:
	mov	[bp+var_4], 6
loc_14F3A:
	mov	ax, [bp+var_4]
	cmp	gs:g_currentMouseIcon, ax
	jz	short l_return
	mov	gs:g_currentMouseIcon, ax
	push	ax

	call	far ptr	vid_setMouseIcon
	add	sp, 2
l_return:
	mov	sp, bp
	pop	bp
	retf
mouse_setScrollingIcon endp
