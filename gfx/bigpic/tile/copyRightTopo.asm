_bigpic_copyRightTopo proc near
	assume ds:seg021
	mov	bl, es:[di]
	mov	bl, [bx+0]
	dec	di
	sub	dl, dh
	jge	short loc_27DB6
	add	dl, 64
	mov	al, g_tile_highNibble[bx]

loc_27D9A:
	sub	dl, dh
	jge	short loc_27DC3
	add	dl, 64
	or	al, g_tile_lowNibble[bx]
	mov	bl, al
	xor	al, [si]
	and	al, g_tile_backgroundMask[bx]
	xor	al, bl
	mov	[si], al
	inc	si
	dec	cx
	jns	short _bigpic_copyRightTopo
	retn

loc_27DB6:
	sub	dl, dh
	jge	short _bigpic_copyRightTopo
	add	dl, 64
	shl	ah, 1
	mov	al, g_tile_lowNibbleSwapped[bx]

loc_27DC3:
	mov	bl, es:[di]
	mov	bl, [bx+0]
	dec	di
	sub	dl, dh
	jge	short loc_27D9A
	add	dl, 64
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
	jns	short loc_27DB6
	retn
_bigpic_copyRightTopo endp
