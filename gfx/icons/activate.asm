; Attributes: bp-based frame

icon_activate proc far

	iconIndex= word ptr	 6

	FUNC_ENTER
	CHKSTK
	push	si

	mov	bx, [bp+iconIndex]
	mov	iconCurrentDelay[bx], 1
	mov	bx, [bp+iconIndex]
	mov	si, bx
	sub	al, al
	mov	byte_44718[si],	al
	mov	iconCurrentCell[bx],	al
	sub	ax, ax
	push	ax
	push	[bp+iconIndex]
	NEAR_CALL(icon_draw)

	pop	si
	FUNC_EXIT
	retf
icon_activate endp
