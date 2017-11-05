; Attributes: bp-based frame

printString proc far

	lineBuffer=	word ptr -62h
	inStringP=	dword ptr -12h
	characterCount= word ptr	-0Eh
	linesPrinted= word ptr	-0Ch
	pixelsUsed= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	currentCharacter= word ptr	-4
	var_2= word ptr	-2
	inString= dword ptr  6

	FUNC_ENTER(62h)
	push	si

	mov	ax, word ptr [bp+inString]
	mov	dx, word ptr [bp+inString+2]
	mov	word ptr [bp+inStringP], ax
	mov	word ptr [bp+inStringP+2],	dx
	mov	[bp+characterCount], 0
	mov	[bp+pixelsUsed], 0
	mov	[bp+linesPrinted], 0

l_nextCharacter:
	lfs	bx, [bp+inString]
	cmp	byte ptr fs:[bx], 0
	jz	l_return
	lfs	bx, [bp+inStringP]
	inc	word ptr [bp+inStringP]
	mov	al, fs:[bx]
	cbw
	mov	[bp+currentCharacter], ax
	or	ax, ax
	jz	l_stringEnd
	cmp	ax, 0Ah
	jz	l_newline
	cmp	ax, 20h	
	jz	l_space
	jmp	l_otherCharacter

l_stringEnd:
	mov	si, [bp+characterCount]
	mov	byte ptr [bp+si+lineBuffer], 0
	cmp	[bp+characterCount], 0
	jz	l_return
	PUSH_STACK_ADDRESS(lineBuffer)
	CALL(text_nlWriteString, near)
	jmp	l_return

l_newline:
	mov	si, [bp+characterCount]
	mov	byte ptr [bp+si+lineBuffer], 0
	cmp	[bp+characterCount], 0
	jz	short loc_16441
	PUSH_STACK_ADDRESS(lineBuffer)
	CALL(text_nlWriteString, near)

loc_16441:
	CALL(txt_newLine, near)

loc_16445:
	mov	ax, [bp+linesPrinted]
	inc	[bp+linesPrinted]
	cmp	ax, 50
	jle	short loc_16457
	mov	ax, 3
	jmp	l_return

loc_16457:
	mov	ax, word ptr [bp+inStringP]
	mov	dx, word ptr [bp+inStringP+2]
	mov	word ptr [bp+inString], ax
	mov	word ptr [bp+inString+2], dx
	mov	[bp+pixelsUsed], 0
	mov	[bp+characterCount], 0
	jmp	l_nextCharacter

l_space:
	cmp	[bp+pixelsUsed], 0			; Skip space if it's the first character
	jz	l_nextCharacter				; on the line

l_otherCharacter:
	mov	si, [bp+characterCount]
	inc	[bp+characterCount]
	mov	al, byte ptr [bp+currentCharacter]
	mov	byte ptr [bp+si+lineBuffer], al
	push	[bp+currentCharacter]
	CALL(text_characterWidth, near)
	add	[bp+pixelsUsed], ax
	cmp	[bp+pixelsUsed], 138
	jl	l_nextCharacter

	mov	ax, [bp+linesPrinted]
	inc	[bp+linesPrinted]
	cmp	ax, 50
	jle	short l_wrapText
	mov	ax, 3
	jmp	l_return

l_wrapText:
	mov	ax, [bp+characterCount]
	mov	[bp+var_2], ax
	mov	ax, word ptr [bp+inStringP]
	mov	dx, word ptr [bp+inStringP+2]
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx

l_backtrackForSpace:					; Backtrack through the string looking for
	dec	[bp+characterCount]			; a space (or 0) to avoid splitting the
	mov	si, [bp+characterCount]			; last word over two lines
	cmp	byte ptr [bp+si+lineBuffer], ' '
	jz	short l_spaceFound
	or	si, si
	jl	short l_spaceFound
	dec	word ptr [bp+inStringP]
	jmp	short l_backtrackForSpace

l_spaceFound:
	cmp	[bp+characterCount], 0
	jz	short loc_16506
	mov	si, [bp+characterCount]
	mov	byte ptr [bp+si+lineBuffer], 0
	PUSH_STACK_ADDRESS(lineBuffer)
	CALL(text_nlWriteString, near)
	mov	[bp+pixelsUsed], 0
	mov	[bp+characterCount], 0
	mov	ax, word ptr [bp+inStringP]
	mov	dx, word ptr [bp+inStringP+2]
	mov	word ptr [bp+inString], ax
	mov	word ptr [bp+inString+2], dx
	jmp	l_nextCharacter

loc_16506:
	mov	si, [bp+var_2]
	mov	byte ptr [bp+si+lineBuffer], 6Fh 
	mov	ax, [bp+var_8]
	mov	dx, [bp+var_6]
	dec	ax
	mov	word ptr [bp+inStringP], ax
	mov	word ptr [bp+inStringP+2],	dx
	PUSH_STACK_ADDRESS(lineBuffer)
	CALL(text_nlWriteString, near)
	mov	[bp+pixelsUsed], 0
	mov	[bp+characterCount], 0
	mov	ax, word ptr [bp+inStringP]
	mov	dx, word ptr [bp+inStringP+2]
	mov	word ptr [bp+inString], ax
	mov	word ptr [bp+inString+2], dx
	jmp	l_nextCharacter

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printString endp
