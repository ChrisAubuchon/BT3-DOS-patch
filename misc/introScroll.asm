; Attributes: bp-based frame

intro_scrollText proc far

	var_A30= word ptr -0A30h
	var_A2E= word ptr -0A2Eh
	var_25E= word ptr -25Eh
	var_25C= word ptr -25Ch
	var_25A= word ptr -25Ah
	var_258= word ptr -258h
	var_256= word ptr -256h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER(0A30h)
	push	si

	PUSH_STACK_ADDRESS(var_258)
	PUSH_STACK_ADDRESS(var_A2E)
	push	[bp+arg_2]
	push	[bp+arg_0]
	CALL(text_wrapLongString, near)
	mov	[bp+var_A30], ax

	mov	[bp+var_25A], 0FFF8h
	jmp	short loc_16694
loc_16690:
	inc	[bp+var_25A]
loc_16694:
	mov	ax, [bp+var_A30]
	sub	ax, 4
	cmp	ax, [bp+var_25A]
	jle	l_return

	sub	ax, ax
	push	ax
	mov	ax, 5Ch	
	push	ax
	mov	ax, 96h	
	push	ax
	mov	ax, 1Ch
	push	ax
	sub	ax, ax
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	[bp+var_25C], 0

loc_166C6:
	mov	ax, [bp+var_25C]
	add	ax, [bp+var_25A]
	mov	[bp+var_25E], ax
	or	ax, ax
	jl	short loc_16715
	mov	ax, [bp+var_A30]
	cmp	[bp+var_25E], ax
	jge	short loc_16715
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_25C]
	mov	cl, 3
	shl	ax, cl
	add	ax, 1Ch
	push	ax
	mov	ax, 3
	push	ax
	mov	si, [bp+var_25E]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_256]
	push	[bp+si+var_258]
	CALL(writeStringAt, near)

loc_16715:
	inc	[bp+var_25C]
	cmp	[bp+var_25C], 8
	jl	short loc_166C6

loc_16717:
	mov	ax, 2
	push	ax
	CALL(timedGetKey, near)
	cmp	ax, dosKeys_ESC
	jnz	loc_16690
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
intro_scrollText endp
