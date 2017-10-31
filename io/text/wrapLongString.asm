; Attributes: bp-based frame

text_wrapLongString proc far

	var_10=	word ptr -10h
	currentLineNumber= word ptr	-0Eh
	var_C= dword ptr -0Ch
	var_8= word ptr	-8
	currenCharacter= word ptr	-6
	var_2= word ptr	-2
	message= dword ptr  6
	stringBuffer= dword ptr  0Ah
	linePList= dword ptr  0Eh		; A list of pointers to each line after wrapping

	FUNC_ENTER
	CHKSTK(10h)
	push	si

	mov	[bp+var_8], 0
	mov	[bp+currentLineNumber], 0
	mov	bx, [bp+currentLineNumber]
	inc	[bp+currentLineNumber]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+linePList]
	mov	ax, word ptr [bp+stringBuffer]
	mov	dx, word ptr [bp+stringBuffer+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
loc_16A04:
	lfs	bx, [bp+message]
	cmp	byte ptr fs:[bx], 0
	jz	l_nullTerminateAndReturn
loc_16A10:
	inc	word ptr [bp+message]
	mov	al, fs:[bx]
	cbw
	mov	[bp+currenCharacter], ax
	or	ax, ax
	jz	l_endingNull
	cmp	ax, 0Ah
	jz	l_newLine
	jmp	l_copyCharacter

l_endingNull:
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], 0
	mov	ax, [bp+currentLineNumber]
	jmp	l_return

l_newLine:
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], 0
	mov	bx, [bp+currentLineNumber]
	inc	[bp+currentLineNumber]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+linePList]
	mov	ax, word ptr [bp+stringBuffer]
	mov	dx, word ptr [bp+stringBuffer+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	[bp+var_8], 0
	lfs	bx, [bp+message]
	cmp	byte ptr fs:[bx], ' '
	jnz	short loc_16A62
	inc	word ptr [bp+message]
loc_16A62:
	jmp	loc_16A04

l_copyCharacter:
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	al, byte ptr [bp+currenCharacter]
	mov	fs:[bx], al
	push	[bp+currenCharacter]
	NEAR_CALL(text_characterWidth, 2)
	add	[bp+var_8], ax
	cmp	[bp+var_8], 96h	
	jl	short loc_16AEA
	mov	ax, word ptr [bp+stringBuffer]
	mov	dx, word ptr [bp+stringBuffer+2]
	dec	ax
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	mov	[bp+var_2], 0
loc_16A97:
	lfs	bx, [bp+var_C]
	cmp	byte ptr fs:[bx], ' '
	jz	short loc_16AC0
	cmp	[bp+var_8], 0
	jle	short loc_16AC0
	dec	word ptr [bp+var_C]
	mov	al, fs:[bx]
	cbw
	push	ax
	NEAR_CALL(text_characterWidth, 2)
	mov	[bp+var_10], ax
	add	[bp+var_2], ax
	sub	[bp+var_8], ax
	jmp	short loc_16A97
loc_16AC0:
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 0
	mov	bx, [bp+currentLineNumber]
	inc	[bp+currentLineNumber]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+linePList]
	mov	ax, word ptr [bp+var_C]
	mov	dx, word ptr [bp+var_C+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	ax, [bp+var_2]
	mov	[bp+var_8], ax
loc_16AEA:
	jmp	loc_16A04

l_nullTerminateAndReturn:
	NULL_TERMINATE(STACKVAR(stringBuffer))
	mov	ax, [bp+currentLineNumber]
	jmp	short $+2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
text_wrapLongString endp
