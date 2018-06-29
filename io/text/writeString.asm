; This function actually writes each character to the text window.
;
; Note that there is no bounds checking in this function. All bounds
; checking is assumed to have been done by the caller.
;
; Attributes: bp-based frame

text_writeString proc far

	currentCharacter= byte ptr	-2
	inString= dword ptr  6

	FUNC_ENTER(2)

l_loop:
	lfs	bx, [bp+inString]
	mov	al, fs:[bx]
	mov	[bp+currentCharacter], al
	or	al, al
	jz	short l_return

	mov	ax, 1
	push	ax

	mov	al, [bp+currentCharacter]	; Get current character
	cbw
	sub	ax, 32				; Subtract ' '
	push	ax

	mov	al, gs:g_currentCharPosition	; Push horizontal position
	sub	ah, ah
	add	ax, 168
	push	ax

	mov	al, gs:txt_numLines		; Push vertical position
	sub	ah, ah
	mov	cl, 3
	shl	ax, cl
	add	ax, 6
	push	ax

	call	far ptr	gfx_writeCharacter
	add	sp, 8
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	cbw
	push	ax
	CALL(text_characterWidth, near)
	add	gs:g_currentCharPosition, al
	jmp	short l_loop
l_return:
	FUNC_EXIT
	retf
text_writeString endp
