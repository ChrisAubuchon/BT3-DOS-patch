; Attributes: bp-based frame

stairsPluralHelper proc far

	stringBufP=	dword ptr -54h
	stringBuffer=	word ptr -50h
	arg_0= dword ptr	 6
	arg_4= word ptr	 0Ah

	FUNC_ENTER(54h)

	push	[bp+arg_4]
	PUSH_STACK_ADDRESS(stringBuffer)
	push	[bp+arg_0]
	PLURALIZE(stringBufP)
	lfs	bx, [bp+stringBufP]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING

	FUNC_EXIT
	retf
stairsPluralHelper endp

; Attributes: bp-based frame

