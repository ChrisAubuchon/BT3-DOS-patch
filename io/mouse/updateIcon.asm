; Attributes: bp-based frame

mouse_updateIcon proc far

	var_6= word ptr	-6
	loopCounter= word ptr	-4
	iconNumber= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER(6)
	push	si

	test	[bp+arg_0], 4000h
	jnz	l_setIconFive

	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	si, [bp+loopCounter]
	mov	cl, 3
	shl	si, cl
	mov	ax, mouse_x
	cmp	mouseBoxes._left[si],	ax
	jg	short l_loopIncrement
	cmp	mouseBoxes._right[si],	ax
	jle	short l_loopIncrement
	mov	ax, mouse_y
	cmp	mouseBoxes._top[si],	ax
	jg	short l_loopIncrement
	cmp	mouseBoxes._bottom[si],	ax
	jg	short l_loopExit

l_loopIncrement:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short l_loopEntry

l_loopExit:
	mov	ax, [bp+loopCounter]
	or	ax, ax
	jnz	short loc_15064

	; Bitmask 8000h sets the mouse icon when the mouse is in the
	; bigpic area. This is where the direction arrow icons are
	; set
	mov	ax, [bp+arg_0]
	test	bitMask16bit+1Eh, ax		; 8000h
	jz	short l_setIconSix
	cmp	mouse_y, 2Dh 
	jge	short loc_14FDE
	jmp	l_setIconOne

loc_14FDE:
	cmp	mouse_y, 4Bh 
	jle	short loc_14FED
	jmp	short l_setIconTwo

loc_14FED:
	cmp	mouse_x, 4Ah 
	jge	short l_setIconFour
	jmp	short l_setIconThree

loc_1500E:
	mov	ax, mouse_y
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_6], ax
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_6]
	shl	bx, 1
	test	bitMask16bit[bx], ax
	jz	short l_setIconSix
	jmp	short l_setIconFive

loc_15040:
	test	[bp+arg_0], 2000h
	jz	short l_setIconSix
	jmp	short l_setIconFive


loc_15064:
	cmp	ax, 1				; Mouse in text window
	jz	short loc_1500E
	cmp	ax, 2				; Mouse in party area
	jz	short loc_15040
	jmp	short l_setIconSix

l_setIconOne:
	mov	[bp+iconNumber], 1
	jmp	short l_setIconAndReturn

l_setIconTwo:
	mov	[bp+iconNumber], 2
	jmp	short l_setIconAndReturn

l_setIconThree:
	mov	[bp+iconNumber], 3
	jmp	short l_setIconAndReturn

l_setIconFour:
	mov	[bp+iconNumber], 4
	jmp	short l_setIconAndReturn

l_setIconFive:
	mov	[bp+iconNumber], 5
	jmp	short l_setIconAndReturn

l_setIconSix:
	mov	[bp+iconNumber], 6

l_setIconAndReturn:
	mov	ax, [bp+iconNumber]
	cmp	gs:g_currentMouseIcon, ax
	jz	short l_return
	mov	gs:g_currentMouseIcon, ax
	push	ax
	call	far ptr	vid_setMouseIcon
	add	sp, 2

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
mouse_updateIcon endp
