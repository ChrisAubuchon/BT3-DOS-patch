; Attributes: bp-based frame

gfx_animate proc far

	iconNumber= word ptr	-2

	FUNC_ENTER
	CHKSTK(2)
	push	si

	mov	al, byte ptr dirFacing
	mov	iconCurrentCell[1], al

	cmp	gs:byte_422A0, 0
	jz	short loc_17A34

	mov	ax, gs:word_4245A
	inc	gs:word_4245A
	test	al, 3
	jnz	short loc_17A34

	inc	gs:bigpicCellNumber
	and	gs:bigpicCellNumber, 3
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	mov	al, gs:bigpicCellNumber
	sub	ah, ah
	mov	cx, 1340h
	mul	cx
	add	ax, gs:bigpicCellData_off
	mov	dx, gs:bigpicCellData_seg
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8
	jmp	short loc_17A9C

loc_17A34:
	cmp	gs:word_42560, 0
	jz	short loc_17A9C

	mov	ax, gs:word_4245A
	inc	gs:word_4245A
	test	al, 7
	jnz	short loc_17A9C
	inc	gs:bigpicCellNumber
	cmp	gs:bigpicCellNumber, 3
	jnz	short loc_17A6D
	mov	gs:word_42560, 0

loc_17A6D:
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	mov	al, gs:bigpicCellNumber
	sub	ah, ah
	mov	cx, 1340h
	mul	cx
	add	ax, gs:bigpicCellData_off
	mov	dx, gs:bigpicCellData_seg
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8

loc_17A9C:
	mov	[bp+iconNumber], 0
loc_17AA3:
	mov	bx, [bp+iconNumber]
	cmp	lightDuration[bx], 0
	jz	short l_increment

	; Unsure what this block does because byte_44718 and iconCurrentCell shouldn't
	; ever be different.
	mov	si, bx
	mov	al, byte_44718[si]
	cmp	iconCurrentCell[bx],	al
	jz	short loc_17AE0
	mov	al, iconCurrentCell[si]
	mov	byte_44718[bx],	al
	mov	bx, [bp+iconNumber]
	mov	al, iconCurrentCell[bx]
	cbw
	push	ax
	push	bx
	CALL(icon_draw, near)

loc_17AE0:
	mov	bx, [bp+iconNumber]
	cmp	iconAnimationDelay[bx],	0
	jz	short l_increment

	mov	al, iconCurrentDelay[bx]
	dec	iconCurrentDelay[bx]
	cmp	al, 1
	jnz	short l_increment

	mov	bx, [bp+iconNumber]
	mov	si, bx
	mov	al, iconAnimationDelay[si]
	mov	iconCurrentDelay[bx], al		; Set up delay for next cell

	mov	bx, [bp+iconNumber]
	inc	iconCurrentCell[bx]
	mov	al, iconCurrentCell[bx]
	mov	bx, [bp+iconNumber]
	cmp	al, iconClearIndex[bx]
	jnz	short l_increment
	mov	iconCurrentCell[bx],	0

l_increment:
	inc	[bp+iconNumber]
	cmp	[bp+iconNumber], 5
	jl	short loc_17AA3

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
gfx_animate endp
