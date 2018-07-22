sub_28115 proc far
	mov	byte_4EF5D, 0
	cmp	g_mousePresentFlag2, 0
	jz	short loc_28183
	cmp	g_mousePresentFlag1, 0
	jnz	short loc_28183
	call	sub_2821E
	mov	bl, ah
	sub	ah, ah
	sub	bh, bh
	mov	cx, word_4EF59
	sub	cx, ax
	mov	ax, cx
	sar	ax, 1
	sar	ax, 1
	or	ax, ax
	jz	short loc_2815A
	add	g_mouseX, ax
	mov	byte_4EF5D, 1
	test	g_mouseX, 8000h
	jz	short loc_2815A
	mov	g_mouseX, 0
loc_2815A:
	mov	ax, bx
	mov	cx, word_4EF5B
	sub	cx, ax
	mov	ax, cx
	sar	ax, 1
	sar	ax, 1
	or	ax, ax
	jz	short loc_28183
	add	g_mouseY, ax
	mov	byte_4EF5D, 1
	test	g_mouseY, 8000h
	jz	short loc_28183
	mov	g_mouseY, 0
loc_28183:
	mov	al, byte_4EF5D
	sub	ah, ah
	retf
sub_28115 endp

