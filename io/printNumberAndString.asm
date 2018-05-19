; Attributes: bp-based frame
;
; DWORD - arg_0 & arg_2, arg_8 & arg_A

printNumberAndString proc far

	stringBufferP= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh
	arg_A= word ptr	 10h

	FUNC_ENTER(4)

	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+arg_A]
	push	[bp+arg_8]
	STRCAT(stringBufferP)

	sub	ax, ax
	push	ax
	push	[bp+arg_6]
	push	[bp+arg_4]
	push	dx
	push	word ptr [bp+stringBufferP]
	ITOA(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	push	[bp+arg_A]
	push	[bp+arg_8]
	PRINTSTRING

	FUNC_EXIT
	retf
printNumberAndString endp
