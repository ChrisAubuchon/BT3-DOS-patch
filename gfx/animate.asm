; Attributes: bp-based frame

gfx_animate proc far

	iconNumber= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	al, byte ptr g_direction
	mov	g_iconCurrentCell[1], al

	cmp	gs:g_hideMouseInBigpicFlag, 0
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

	; Only draw the icon if the current cell is different than
	; the last drawn cell
	;
	mov	si, bx
	mov	al, g_iconLastDrawnCell[si]
	cmp	g_iconCurrentCell[bx],	al
	jz	short loc_17AE0
	mov	al, g_iconCurrentCell[si]
	mov	g_iconLastDrawnCell[bx],	al
	mov	bx, [bp+iconNumber]
	mov	al, g_iconCurrentCell[bx]
	cbw
	push	ax
	push	bx
	CALL(icon_draw, near)

loc_17AE0:
	mov	bx, [bp+iconNumber]
	cmp	g_iconAnimationDelay[bx], 0
	jz	short l_increment

	mov	al, g_iconCurrentDelay[bx]
	dec	g_iconCurrentDelay[bx]
	cmp	al, 1
	jnz	short l_increment

	mov	bx, [bp+iconNumber]
	mov	si, bx
	mov	al, g_iconAnimationDelay[si]
	mov	g_iconCurrentDelay[bx], al		; Set up delay for next cell

	mov	bx, [bp+iconNumber]
	inc	g_iconCurrentCell[bx]
	mov	al, g_iconCurrentCell[bx]
	mov	bx, [bp+iconNumber]
	cmp	al, g_iconClearIndex[bx]
	jnz	short l_increment
	mov	g_iconCurrentCell[bx],	0

l_increment:
	inc	[bp+iconNumber]
	cmp	[bp+iconNumber], 5
	jl	short loc_17AA3

l_return:
	pop	si
	FUNC_EXIT
	retf
gfx_animate endp
