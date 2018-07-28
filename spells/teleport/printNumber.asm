; Attributes: bp-based frame

teleport_printNumber proc far

	stringBufferP=	dword ptr -24h
	stringBuffer=	word ptr -20h
	inNumber= word ptr	 6
	activeLineFlag= word ptr	 8

	FUNC_ENTER(24h)

	sub	ax, ax
	push	ax
	mov	ax, [bp+inNumber]
	cwd
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	ITOA(stringBufferP)
	cmp	[bp+activeLineFlag], 0
	jz	short l_writeString

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], '<'

l_writeString:
	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	mov	gs:g_currentCharPosition, 30h 
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(text_writeString)

	FUNC_EXIT
	retf
teleport_printNumber endp
