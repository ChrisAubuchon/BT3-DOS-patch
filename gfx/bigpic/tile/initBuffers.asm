; Attributes: bp-based frame
bigpic_initBuffers proc	far

	backgroundValue= word ptr	 6

	FUNC_ENTER
	push	ds
	mov	ax, seg	seg021
	mov	ds, ax
	assume ds:seg021
	mov	dx, [bp+backgroundValue]
	mov	dh, dl
	and	dx, 0F00Fh
	mov	cl, 4
	mov	bx, 0FFh

loc_27C7F:
	xor	ah, ah
	mov	al, bl
	and	al, 0Fh
	mov	g_tile_lowNibble[bx],	al
	cmp	dl, al
	jnz	short loc_27C8F
	mov	ah, 0Fh

loc_27C8F:
	shl	al, cl
	mov	g_tile_lowNibbleSwapped[bx],	al
	mov	al, bl
	and	al, 0F0h
	mov	g_tile_highNibble[bx],	al
	cmp	dh, al
	jnz	short loc_27CA4
	or	ah, 0F0h

loc_27CA4:
	shr	al, cl
	mov	g_tile_highNibbleSwapped[bx],	al
	mov	g_tile_backgroundMask[bx],	ah
	dec	bx
	jns	short loc_27C7F
	pop	ds
	assume ds:dseg
	FUNC_EXIT
	retf
bigpic_initBuffers endp
