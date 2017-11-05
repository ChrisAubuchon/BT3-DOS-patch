; Attributes: bp-based frame

; DWORD - arg_0 & arg_2, arg_4 & arg_6

copyCharacterBuf proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	FUNC_ENTER

	mov	ax, 78h	
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+arg_6]
	push	[bp+arg_4]
	CALL(memcpy)
	mov	sp, bp
	pop	bp
	retf
copyCharacterBuf endp

