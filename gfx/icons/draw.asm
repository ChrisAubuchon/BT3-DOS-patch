; Attributes: bp-based frame

icon_draw proc far

	dataP= dword ptr	-4
	iconNumber= byte ptr	 6
	cellNumber= byte ptr	 8

	FUNC_ENTER(4)
	push	si

	mov	bl, [bp+iconNumber]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr g_iconDataPointers[bx]
	mov	dx, word ptr (g_iconDataPointers+2)[bx]
	SAVE_STACK_DWORD(dx, ax, dataP)

l_getCellDataAddress:
	mov	al, [bp+cellNumber]
	dec	[bp+cellNumber]
	or	al, al
	jz	short l_showIcon
	mov	bl, [bp+iconNumber]
	sub	bh, bh
	shl	bx, 1
	mov	ax, g_iconCellDataLength[bx]
	add	word ptr [bp+dataP], ax
	jmp	short l_getCellDataAddress

l_showIcon:
	mov	al, [bp+iconNumber]
	sub	ah, ah
	mov	si, ax
	mov	al, g_iconWidth[si]
	push	ax
	mov	al, g_iconHeight[si]
	push	ax
	mov	al, g_iconXOffset[si]
	push	ax
	PUSH_STACK_DWORD(dataP)
	call	far ptr	gfx_drawMagicIcon
	add	sp, 0Ah

	pop	si
	FUNC_EXIT
	retf
icon_draw endp
