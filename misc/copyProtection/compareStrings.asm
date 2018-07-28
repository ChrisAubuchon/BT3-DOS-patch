; Attributes: bp-based frame

cp_compareStrings proc far

	loopCounter= word ptr	-2
	inString= dword ptr  6
	keyString= dword ptr  0Ah
	resultLength= word ptr	 0Eh

	FUNC_ENTER(2)
	push	si

	mov	ax, [bp+resultLength]
	mov	[bp+loopCounter], ax
l_loop:
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	mov	bx, [bp+loopCounter]
	lfs	si, [bp+keyString]
	cmp	fs:[bx+si], al
;	jnz	short l_returnFail		; Uncomment to enable copy protection
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loop
	jmp	short l_returnSuccess

l_returnFail:
	sub	ax, ax
	jmp	short l_return

l_returnSuccess:
	mov	ax, 1

l_return:
	pop	si
	FUNC_EXIT
	retf
cp_compareStrings endp

