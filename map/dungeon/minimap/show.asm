; Attributes: bp-based frame

minimap_show proc far

	rowP=	dword ptr -16h
	squareFlags=	word ptr -12h
	nsCounter=	word ptr -10h
	ewCounter=	word ptr -0Eh
	nsValue= word ptr	-0Ch
	ewValue= word ptr	-0Ah
	screenY= word ptr	-08h
	screenX= word ptr	-6
	upDownValue= word ptr	-4
	rightLeftValue= word ptr	-2
	rowPList= dword ptr  6			; Array of points to the dungeon rows
	squareEW= word ptr	 0Ah
	squareNS= word ptr	 0Ch
	leftLimit= word ptr	 0Eh
	downLimit= word ptr	 10h

	FUNC_ENTER(16h)
	push	si

	mov	[bp+rightLeftValue], 8
	mov	[bp+upDownValue], 6
l_loopEntry:
	mov	gs:g_text_clearFlag, 1
	CALL(text_clear, near)
	mov	gs:g_text_clearFlag, 1

	mov	[bp+ewCounter], 0
	jmp	short loc_1555E
loc_1555B:
	inc	[bp+ewCounter]
loc_1555E:
	cmp	[bp+ewCounter], 11h
	jge	l_getInput
	mov	ax, [bp+squareEW]
	sub	ax, [bp+rightLeftValue]
	add	ax, [bp+ewCounter]
	mov	[bp+ewValue], ax
	mov	[bp+nsCounter], 0
	jmp	short loc_1557D
loc_1557A:
	inc	[bp+nsCounter]
loc_1557D:
	cmp	[bp+nsCounter], 0Ch
	jge	loc_1555B
loc_15586:
	mov	ax, [bp+squareNS]
	sub	ax, [bp+upDownValue]
	add	ax, [bp+nsCounter]
	mov	[bp+nsValue], ax
	or	ax, ax
	jl	loc_156F6
loc_15599:
	mov	ax, [bp+downLimit]
	cmp	[bp+nsValue], ax
	jge	loc_156F6
loc_155A4:
	cmp	[bp+ewValue], 0
	jl	short loc_155AF
	mov	ax, 1
	jmp	short loc_155B1
loc_155AF:
	sub	ax, ax
loc_155B1:
	mov	cx, [bp+leftLimit]
	mov	si, ax
	cmp	[bp+ewValue], cx
	jge	short loc_155C0
	mov	ax, 1
	jmp	short loc_155C2
loc_155C0:
	sub	ax, ax
loc_155C2:
	test	ax, si
	jz	loc_156F6
loc_155C9:
	mov	ax, [bp+nsCounter]
	mov	cl, 3
	shl	ax, cl
	sub	ax, 5Eh	
	neg	ax
	mov	[bp+screenY], ax
	mov	ax, [bp+ewCounter]
	shl	ax, cl
	add	ax, 0A9h 
	mov	[bp+screenX], ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(minimap_clearSquare)
	mov	bx, [bp+ewValue]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	ax, bx
	mov	bx, [bp+nsValue]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowPList]
	lfs	si, fs:[bx+si]
	mov	bx, ax
	mov	al, fs:[bx+si+4]
	sub	ah, ah
	mov	[bp+squareFlags], ax
	test	byte ptr [bp+squareFlags], 2
	jnz	l_squareUndiscovered
loc_15621:
	test	byte ptr [bp+squareFlags], 1
	jz	l_squareUndiscovered
loc_1562A:
	mov	ax, [bp+rightLeftValue]
	cmp	[bp+ewCounter], ax
	jnz	short loc_1564E
	mov	ax, [bp+upDownValue]
	cmp	[bp+nsCounter], ax
	jnz	short loc_1564E
	mov	ax, minimap_X
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(minimap_setSquare)
loc_1564E:
	cmp	word_43F12, 0
	jz	short loc_15671
	test	byte ptr [bp+squareFlags], 8
	jz	short loc_1566F
	mov	ax, minimap_dot
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(minimap_setSquare)
loc_1566F:
	jmp	short loc_1568B
loc_15671:
	test	byte ptr [bp+squareFlags], 4
	jz	short loc_1568B
	mov	ax, minimap_dot
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(minimap_setSquare)

loc_1568B:
	mov	bx, [bp+nsValue]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowPList]
	mov	ax, fs:[bx+si]
	mov	dx, fs:[bx+si+2]
	mov	cx, [bp+ewValue]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+rowP], ax
	mov	word ptr [bp+rowP+2],	dx
	lfs	bx, [bp+rowP]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	push	ax
	CALL(minimap_getWalls, near)
	jmp	short l_drawSquare

l_squareUndiscovered:
	mov	ax, minimap_undiscovered
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(minimap_setSquare)

l_drawSquare:
	mov	ax, 1
	push	ax
	mov	ax, 63h	
	push	ax
	push	[bp+screenX]
	push	[bp+screenY]
	call	far ptr	gfx_writeCharacter
	add	sp, 8
loc_156F6:
	jmp	loc_1557A

l_getInput:
	CALL(getKey, near)
	cmp	ax, dosKeys_ESC
	jz	short l_clearAndReturn
	cmp	ax, dosKeys_upArrow
	jz	short l_upArrow
	cmp	ax, dosKeys_leftArrow
	jz	short l_leftArrow
	cmp	ax, dosKeys_rightArrow
	jz	short l_rightArrow
	cmp	ax, dosKeys_downArrow
	jz	short l_downArrow
	jmp	l_loopEntry

l_downArrow:
	mov	ax, [bp+downLimit]
	cmp	[bp+upDownValue], ax
	jge	short l_afterDownLoop
	inc	[bp+upDownValue]
l_afterDownLoop:
	jmp	l_loopEntry

l_upArrow:
	cmp	[bp+upDownValue], 0
	jz	short l_afterUpLoop
	dec	[bp+upDownValue]
l_afterUpLoop:
	jmp	l_loopEntry

l_rightArrow:
	cmp	[bp+rightLeftValue], 0
	jz	short l_afterRightLoop
	dec	[bp+rightLeftValue]
l_afterRightLoop:
	jmp	l_loopEntry

l_leftArrow:
	mov	ax, [bp+leftLimit]
	cmp	[bp+rightLeftValue], ax
	jge	short l_afterLeftLoop
	inc	[bp+rightLeftValue]
l_afterLeftLoop:
	jmp	l_loopEntry

l_clearAndReturn:
	CALL(text_clear, near)

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
minimap_show endp
