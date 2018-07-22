sub_2821E proc far
	cli
	sub	cx, cx
	cmp	g_mousePresentFlag2, 0
	jz	short loc_2824E
	dec	cx
	xor	bx, bx
	mov	dx, 201h
	out	dx, al		; Game I/O port
			; bits 0-3: Coordinates	(resistive, time-dependent inputs)
			; bits 4-7: Buttons/Triggers (digital inputs)
	sub	ax, ax
loc_28231:		; Game I/O port
	in	al, dx		; bits 0-3: Coordinates	(resistive, time-dependent inputs)
			; bits 4-7: Buttons/Triggers (digital inputs)
	mov	bl, al
	and	bl, 1
	sub	cl, bl
	mov	bl, al
	shr	bl, 1
	and	bl, 1
	sub	ch, bl
	test	al, 3
	jz	short loc_2824E
	inc	ah
	jnz	short loc_28231
	mov	g_mousePresentFlag2, ah
loc_2824E:
	mov	ax, cx
	sti
	retf
sub_2821E endp
