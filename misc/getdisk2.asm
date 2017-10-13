; Attributes: bp-based frame

getDisk2 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
loc_14D40:
	mov	ax, 2
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	openFile
	add	sp, 6
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_14D81
	mov	ax, offset aPleaseInsertDi
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aDisk2
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
loc_14D81:
	cmp	[bp+var_2], 0FFFFh
	jz	short loc_14D40
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
getDisk2 endp
