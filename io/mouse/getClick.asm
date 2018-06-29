; Attributes: bp-based frame

mouse_getClick proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER(8)
	push	si

	CALL(checkGamePort)
	or	ax, ax
	jnz	short loc_150AE
	CALL(checkOtherGamePort)
	or	ax, ax
	jz	short loc_150B3
loc_150AE:
	mov	ax, 1
	jmp	short loc_150B5
loc_150B3:
	sub	ax, ax
loc_150B5:
	mov	[bp+var_8], ax
	mov	ax, word_440BC
	cmp	[bp+var_8], ax
	jnz	short loc_150C4
	sub	ax, ax
	jmp	short loc_150C7
loc_150C4:
	mov	ax, [bp+var_8]
loc_150C7:
	mov	[bp+var_2], ax
	mov	ax, [bp+var_8]
	mov	word_440BC, ax
	cmp	[bp+var_2], 0
	jz	l_returnZero

	test	[bp+arg_0], 4000h
	jz	short loc_150E9
	mov	ax, 20h	
	jmp	l_return
loc_150E9:
	mov	[bp+var_4], 0
	jmp	short loc_150F3
loc_150F0:
	inc	[bp+var_4]
loc_150F3:
	cmp	[bp+var_4], 3
	jge	short loc_1512C
	mov	si, [bp+var_4]
	mov	cl, 3
	shl	si, cl
	mov	ax, mouse_x
	cmp	mouseBoxes._left[si],	ax
	jg	short loc_150F0
	cmp	mouseBoxes._right[si],	ax
	jle	short loc_150F0
	mov	ax, mouse_y
	cmp	mouseBoxes._top[si],	ax
	jg	short loc_150F0
	cmp	mouseBoxes._bottom[si],	ax
	jle	short loc_150F0
loc_1512C:
	mov	ax, [bp+var_4]
	jmp	loc_151CE
loc_15132:
	mov	ax, [bp+arg_0]
	test	bitMask16bit+1Eh, ax
	jz	short l_returnZero
	cmp	mouse_y, 2Dh 
	jge	short loc_15154
	mov	ax, dosKeys_upArrow
	jmp	l_return
loc_15154:
	cmp	mouse_y, 4Bh 
	jle	short loc_15164
	mov	ax, dosKeys_downArrow
	jmp	l_return
loc_15164:
	cmp	mouse_x, 4Ah 
	jge	short loc_15177
	mov	ax, dosKeys_leftArrow
	jmp	short l_return
loc_15177:
	mov	ax, dosKeys_rightArrow
	jmp	short l_return
loc_1517E:
	mov	ax, mouse_y
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_6], ax
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_6]
	shl	bx, 1
	test	bitMask16bit[bx], ax
	jz	short l_returnZero
	mov	ax, [bp+var_6]
	add	ax, 10Eh
	jmp	short l_return
loc_151AD:
	test	[bp+arg_0], 2000h
	jz	short l_returnZero
	mov	ax, mouse_y
	sub	ax, 88h	
	mov	cl, 3
	sar	ax, cl
	add	ax, 30h	
	jmp	short l_return
loc_151CE:
	or	ax, ax
	jz	loc_15132
loc_151D5:
	cmp	ax, 1
	jz	short loc_1517E
	cmp	ax, 2
	jz	short loc_151AD
l_returnZero:
	sub	ax, ax
l_return:
	pop	si
	FUNC_EXIT
	retf
mouse_getClick endp
