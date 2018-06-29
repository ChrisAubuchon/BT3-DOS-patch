; Attributes: bp-based frame

minimap_getWalls proc far

	directionLoopCounter= word ptr	-2
	squareWalls= word ptr	 6

	FUNC_ENTER(2)

	; Loop through all of the directions getting the value
	; of the walls in each direction
	;
	mov	[bp+directionLoopCounter], 0
l_loopEntry:
	mov	ax, [bp+directionLoopCounter]
	dec	ax
	push	ax
	push	[bp+squareWalls]
	CALL(dungeon_getWallInDirection)
	and	ax, 0Fh
	mov	bx, ax
	cmp	minimap_bitmaskOffsetList[bx],	80h
	jnb	short l_loopIncrement
	mov	al, minimap_bitmaskOffsetList[bx]
	sub	ah, ah
	or	ax, [bp+directionLoopCounter]
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(minimap_setSquare)
l_loopIncrement:
	inc	[bp+directionLoopCounter]
	cmp	[bp+directionLoopCounter], 4
	jl	short l_loopEntry
l_return:
	FUNC_EXIT
	retf
minimap_getWalls endp
