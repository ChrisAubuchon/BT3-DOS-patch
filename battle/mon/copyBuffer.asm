; Attributes: bp-based frame

bat_monCopyBuffer proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, monStruSize
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+arg_6]
	push	[bp+arg_4]
	call	memcpy
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
bat_monCopyBuffer endp
