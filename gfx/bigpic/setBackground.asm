; Attributes: bp-based frame

bigpic_setBackground	proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	FUNC_ENTER(4)

	test	g_levelFlags, dunLevel_isOutdoors
	jz	l_inDungeon

	mov	ax, 44h			; Outdoor sky color
	push	ax
	mov	ax, 0BBBBh		; Outdoor ground color
	push	ax
	mov	ax, offset bigpicBuf
	mov	dx, seg seg021
	push	dx
	push	ax
	CALL(bigpic_memcpy)
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
	CALL(memcpy)
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
	CALL(memcpy)
	cmp	lightDistance, 4
	jnb	short l_return
	mov	al, lightDistance
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	push	g_bigpicLightLength[si]
	sub	ax, ax
	push	ax
	mov	bx, g_bigpicLightBase[si]
	lea	ax, bigpicBuf[bx]
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(memset)
	pop	si
l_return:
	FUNC_EXIT
	retf
bigpic_setBackground	endp
