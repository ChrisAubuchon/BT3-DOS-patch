; This function	prints a string	based on a structure
; that is passed to it.	The optional lines are prefaced
; with a '@'
; Attributes: bp-based frame

printVarString proc far

	stringBuffer= word ptr -10Ah
	mouseBitmask= word ptr	-0Ah
	currentOptionIndex= word ptr	-8
	currentChar= word ptr	-6
	stringBufferP= dword ptr -4
	inString= dword	ptr  6
	optionList= dword ptr  0Ah
	validOptionCharacters= dword ptr  0Eh
	validOptionMouse= dword ptr  12h

	FUNC_ENTER(10Ah)
	push	si

	sub	ax, ax
	mov	[bp+currentOptionIndex], ax
	mov	[bp+mouseBitmask], ax
	lea	ax, [bp+stringBuffer]
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], ss
l_stringCopyLoopEntry:
	lfs	bx, [bp+inString]			; Get next char from inString
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+currentChar], ax

	lfs	bx, [bp+stringBufferP]			; Write it to stringBuffer
	inc	word ptr [bp+stringBufferP]
	mov	al, byte ptr [bp+currentChar]
	mov	fs:[bx], al

	cmp	[bp+currentChar], 0
	jz	short l_nullOrAt
	cmp	[bp+currentChar], '@'
	jnz	short l_stringCopyLoopEntry
l_nullOrAt:
	dec	word ptr [bp+stringBufferP]
	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0			; Replace '@' with 0
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(printString)				; and print the strint

	lea	ax, [bp+stringBuffer]			; Reset the buffer pointer to the
	mov	word ptr [bp+stringBufferP], ax		; beginning of the string buffer
	mov	word ptr [bp+stringBufferP+2], ss

	cmp	[bp+currentChar], 0
	jnz	short l_notNull
	mov	bx, [bp+currentOptionIndex]
	lfs	si, [bp+validOptionCharacters]
	mov	byte ptr fs:[bx+si], 0
	mov	ax, [bp+mouseBitmask]
	jmp	l_return
l_notNull:
	cmp	[bp+currentChar], '@'
	jnz	short l_nullOrAt

	mov	bx, [bp+currentOptionIndex]
	lfs	si, [bp+optionList]
	cmp	byte ptr fs:[bx+si], 0		; Check the current option
	jz	short loc_1204B

	lfs	bx, [bp+inString]		; Save the first character after '@'
	mov	al, fs:[bx]			; as the key the player can type to
	mov	bx, [bp+currentOptionIndex]	; activate the option
	lfs	si, [bp+validOptionCharacters]
	mov	fs:[bx+si], al

	cmp	gs:g_currentCharPosition, 0
	jz	short l_noNewline
	CALL(txt_newLine)
l_noNewline:
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Eh
	mov	bx, [bp+currentOptionIndex]
	inc	[bp+currentOptionIndex]
	shl	bx, 1
	lfs	si, [bp+validOptionMouse]
	mov	fs:[bx+si], ax			; Add the option to the list of mouse
	mov	bl, gs:txt_numLines		; menu items
	sub	bh, bh
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+mouseBitmask], ax

l_copyStringAfterAt:
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+currentChar], ax
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	al, byte ptr [bp+currentChar]
	mov	fs:[bx], al
	cmp	[bp+currentChar], 0
	jz	l_nullOrAt
	cmp	[bp+currentChar], '@'
	jnz	short l_copyStringAfterAt
	jmp	l_nullOrAt

loc_1204B:
	mov	bx, [bp+currentOptionIndex]
	lfs	si, [bp+validOptionCharacters]
	mov	byte ptr fs:[bx+si], 0FFh		; Mark option as invalid
	mov	bx, [bp+currentOptionIndex]
	inc	[bp+currentOptionIndex]
	shl	bx, 1
	lfs	si, [bp+validOptionMouse]		; Mark mouse option as invalid
	mov	word ptr fs:[bx+si], 0
l_skipString:
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+currentChar], ax
	or	ax, ax
	jz	short loc_1207C
	cmp	ax, 40h	
	jnz	short l_skipString
loc_1207C:
	inc	word ptr [bp+stringBufferP]
loc_1207F:
	jmp	l_nullOrAt
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printVarString endp
