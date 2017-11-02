; This function takes arg_0, multiplies it by 100, shifts the lower
; 16 bits (ax) 8 bits to the right and prints that number. Weird.
;
; Attributes: bp-based frame

printThiefAbilValues proc far

	arg_0= dword ptr 6
	arg_4= word ptr	 0Ah

	FUNC_ENTER
	CHKSTK

	mov	ax, 64h	
	imul	[bp+arg_4]
	mov	cl, 8
	sar	ax, cl
	push	ax
	push	[bp+arg_0]
	CALL(printStringAndThreeDigits, near)

	FUNC_EXIT
	retf
printThiefAbilValues endp
