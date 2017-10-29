; This is a convenience function for printing a string and a three digit
; number. It has a maximum size of 32 bytes for string+number
;
; Attributes: bp-based frame

printStringAndThreeDigits proc far

	var_24=	word ptr -24h
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	FUNC_ENTER
	CHKSTK(24h)

	push	[bp+arg_2]
	push	[bp+arg_0]
	PUSH_STACK_ADDRESS(var_24)
	STRCAT(var_4)

	mov	ax, 3
	push	ax
	mov	ax, [bp+arg_4]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+var_4+2]
	push	word ptr [bp+var_4]
	ITOA(var_4)

	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(var_24)
	PRINTSTRING
	mov	sp, bp
	pop	bp
	retf
printStringAndThreeDigits endp

