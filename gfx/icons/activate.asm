; Attributes: bp-based frame

icon_activate proc far

	iconIndex= word ptr	 6

	FUNC_ENTER
	push	si

	mov	bx, [bp+iconIndex]
	mov	g_iconCurrentDelay[bx], 1
	mov	bx, [bp+iconIndex]
	mov	si, bx
	sub	al, al
	mov	g_iconLastDrawnCell[si],	al
	mov	g_iconCurrentCell[bx],	al
	sub	ax, ax
	push	ax
	push	[bp+iconIndex]
	CALL(icon_draw, near)

	pop	si
	FUNC_EXIT
	retf
icon_activate endp
