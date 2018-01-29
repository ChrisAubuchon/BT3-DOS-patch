; This function	reads an 0x80AND'd string from *membuf
; and sets the title. The string is 0xff terminated.
; Attributes: bp-based frame

mfunc_setTitle proc far

	stringBufferP= word ptr -102h
	stringBuffer= word ptr -100h
	dataP= dword ptr  6

	FUNC_ENTER(102h)
	push	si

	mov	[bp+stringBufferP], 0
l_unmaskLoop:
	lfs	bx, [bp+dataP]
	cmp	byte ptr fs:[bx], 0FFh
	jz	short l_setTitle
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	and	al, 7Fh
	mov	si, [bp+stringBufferP]
	inc	[bp+stringBufferP]
	mov	byte ptr [bp+si+stringBuffer], al
	jmp	short l_unmaskLoop

l_setTitle:
	mov	si, [bp+stringBufferP]
	mov	byte ptr [bp+si+stringBuffer], 0
	inc	word ptr [bp+dataP]
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(setTitle)
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	FUNC_EXIT
	retf
mfunc_setTitle endp
