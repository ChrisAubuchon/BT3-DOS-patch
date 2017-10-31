; Attributes: bp-based frame

bigpic_setBackground	proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	FUNC_ENTER
	CHKSTK(4)

	test	levFlags, 20h
	jz	l_inDungeon

	mov	ax, 44h			; Outdoor sky color
	push	ax
	mov	ax, 0BBBBh		; Outdoor ground color
	push	ax
	mov	ax, offset bigpicBuf
	mov	dx, seg seg021
	push	dx
	push	ax
	CALL(bigpic_memcpy, 8)
	jmp	l_return

l_inDungeon:
	push	si
	lfs	bx, [bp+arg_0]
	mov	ah, fs:(graphicsBuf+11h)[bx]
	sub	al, al
	mov	cl, fs:(graphicsBuf+10h)[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, bx
	mov	dx, fs
	add	ax, 0Dh
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, 9A0h
	push	ax
	push	dx
	push	[bp+var_4]
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(_memcpy, 0Ah)
	lfs	bx, [bp+arg_0]
	mov	ah, fs:(graphicsBuf+13h)[bx]
	sub	al, al
	mov	cl, fs:(graphicsBuf+12h)[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, bx
	mov	dx, fs
	add	ax, 0Dh
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, 9A0h
	push	ax
	push	dx
	push	[bp+var_4]
	mov	ax, (offset bigpicBuf+9A0h)
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(_memcpy, 0Ah)
	cmp	lightDistance, 4
	jnb	short l_return
	mov	al, lightDistance
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	push	bigpicLightSize[si]
	sub	ax, ax
	push	ax
	mov	bx, bigpicLightOffset[si]
	lea	ax, bigpicBuf[bx]
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(_memset, 8)
	pop	si
l_return:
	FUNC_EXIT
	retf
bigpic_setBackground	endp
