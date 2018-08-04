; Attributes: bp-based frame

gfx_animate proc far

	iconNumber= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	al, byte ptr g_direction
	mov	g_iconCurrentCell[1], al

	cmp	gs:g_hideMouseInBigpicFlag, 0
	jz	short loc_17A34

	; Only increment the cel number every 3 iterations
	;
	mov	ax, gs:g_bigpicCelTimer
	inc	gs:g_bigpicCelTimer
	test	al, 3
	jnz	short loc_17A34

	inc	gs:g_bigpicAnimationCelNumber
	and	gs:g_bigpicAnimationCelNumber, 3
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	mov	al, gs:g_bigpicAnimationCelNumber
	sub	ah, ah
	mov	cx, 1340h
	mul	cx
	add	ax, gs:bigpicCellData_off
	mov	dx, gs:bigpicCellData_seg
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8
	jmp	short l_drawSpellIcons

loc_17A34:
	cmp	gs:g_bigpicLongerCelDelay, 0
	jz	short l_drawSpellIcons

	mov	ax, gs:g_bigpicCelTimer
	inc	gs:g_bigpicCelTimer
	test	al, 7
	jnz	short l_drawSpellIcons

	inc	gs:g_bigpicAnimationCelNumber
	cmp	gs:g_bigpicAnimationCelNumber, 3
	jnz	short loc_17A6D

	mov	gs:g_bigpicLongerCelDelay, 0

loc_17A6D:
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	mov	al, gs:g_bigpicAnimationCelNumber
	sub	ah, ah
	mov	cx, 1340h
	mul	cx
	add	ax, gs:bigpicCellData_off
	mov	dx, gs:bigpicCellData_seg
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8

l_drawSpellIcons:
	mov	[bp+iconNumber], 0
l_drawIconLoop:
	mov	bx, [bp+iconNumber]
	cmp	lightDuration[bx], 0
	jz	short l_drawIconNext

	; Only draw the icon if the current cell is different than
	; the last drawn cell
	;
	mov	si, bx
	mov	al, g_iconLastDrawnCell[si]
	cmp	g_iconCurrentCell[bx],	al
	jz	short l_skipDrawIcon
	mov	al, g_iconCurrentCell[si]
	mov	g_iconLastDrawnCell[bx],	al
	mov	bx, [bp+iconNumber]
	mov	al, g_iconCurrentCell[bx]
	cbw
	push	ax
	push	bx
	CALL(icon_draw, near)

l_skipDrawIcon:
	mov	bx, [bp+iconNumber]
	cmp	g_iconAnimationDelay[bx], 0
	jz	short l_drawIconNext

	mov	al, g_iconCurrentDelay[bx]
	dec	g_iconCurrentDelay[bx]
	cmp	al, 1
	jnz	short l_drawIconNext

	mov	bx, [bp+iconNumber]
	mov	si, bx
	mov	al, g_iconAnimationDelay[si]
	mov	g_iconCurrentDelay[bx], al		; Set up delay for next cell

	mov	bx, [bp+iconNumber]
	inc	g_iconCurrentCell[bx]
	mov	al, g_iconCurrentCell[bx]
	mov	bx, [bp+iconNumber]
	cmp	al, g_iconClearIndex[bx]
	jnz	short l_drawIconNext
	mov	g_iconCurrentCell[bx],	0

l_drawIconNext:
	inc	[bp+iconNumber]
	cmp	[bp+iconNumber], 5
	jl	short l_drawIconLoop

l_return:
	pop	si
	FUNC_EXIT
	retf
gfx_animate endp
