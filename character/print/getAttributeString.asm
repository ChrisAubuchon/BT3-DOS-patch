; Attributes: bp-based frame
getAttributeString proc	far

	loopCounter= word ptr	-8
	attributeValue= word ptr	-6
	attributeStringP= dword ptr -4
	attributeList= dword ptr  6
	stringBuffer= dword ptr  0Ah
	attributeCount= word ptr	 0Eh

	FUNC_ENTER(8)

	mov	ax, offset s_attributeAbbreviations
	mov	word ptr [bp+attributeStringP], ax
	mov	word ptr [bp+attributeStringP+2], ds
	mov	[bp+loopCounter], 0

l_loop:
	mov	ax, [bp+attributeCount]
	cmp	[bp+loopCounter], ax
	jge	l_return

	lfs	bx, [bp+attributeStringP]
	inc	word ptr [bp+attributeStringP]
	mov	al, fs:[bx]
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	fs:[bx], al

	lfs	bx, [bp+attributeStringP]
	inc	word ptr [bp+attributeStringP]
	mov	al, fs:[bx]
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	fs:[bx], al

	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], ':'

	lfs	bx, [bp+attributeList]
	add	word ptr [bp+attributeList], 2
	mov	ax, fs:[bx]
	mov	[bp+attributeValue], ax
	cmp	ax, 99	
	jle	short l_maxNinetyNine
	mov	[bp+attributeValue], 99

l_maxNinetyNine:
	cmp	[bp+attributeValue], 10
	jge	short l_skipOneDigitCheck

	; Add a space for one digit numbers
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], ' ' 

l_skipOneDigitCheck:
	mov	ax, 2
	push	ax
	mov	ax, [bp+attributeValue]
	cwd
	push	dx
	push	ax
	PUSH_STACK_PTR(stringBuffer)
	ITOA(stringBuffer)

	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], ' '
	inc	[bp+loopCounter]
	jmp	l_loop

l_return:
	lfs	bx, [bp+stringBuffer]
	mov	byte ptr fs:[bx], 0
	FUNC_EXIT
	retf
getAttributeString endp
