_bigpic_copyLeftTopo proc near
	assume ds:seg021
	mov	bl, es:[di]
	inc	di
	sub	dl, dh
	jge	short loc_27D5A
	add	dl, 64
	mov	al, g_tile_highNibble[bx]
loc_27D3E:
	sub	dl, dh
	jge	short loc_27D65
	add	dl, 64
	or	al, g_tile_lowNibble[bx]
	mov	bl, al
	xor	al, [si]
	and	al, g_tile_backgroundMask[bx]
	xor	al, bl
	mov	[si], al
	inc	si
	dec	cx
	jns	short _bigpic_copyLeftTopo
	retn
loc_27D5A:
	sub	dl, dh
	jge	short _bigpic_copyLeftTopo
	add	dl, 40h	
	mov	al, g_tile_lowNibbleSwapped[bx]
loc_27D65:
	mov	bl, es:[di]
	inc	di
	sub	dl, dh
	jge	short loc_27D3E
	add	dl, 40h	
	or	al, g_tile_highNibbleSwapped[bx]
	push	bx
	mov	bl, al
	xor	al, [si]
	and	al, g_tile_backgroundMask[bx]
	xor	al, bl
	pop	bx
	mov	[si], al
	inc	si
	dec	cx
	jns	short loc_27D5A
	retn
_bigpic_copyLeftTopo endp
