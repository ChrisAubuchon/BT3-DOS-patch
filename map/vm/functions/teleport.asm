; Attributes: bp-based frame

mfunc_teleport proc far

	destinationDungeon= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(2)
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mfunc_setSameSquareFlag)

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]

	; Set new g_sqNorth
	mov	al, fs:[bx]
	sub	ah, ah
	mov	g_sqNorth, ax

	; Set new g_sqEast
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	g_sqEast, ax

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+destinationDungeon], ax

	cmp	inDungeonMaybe, 0
	jz	short loc_19557

	cmp	ax, 80h
	jb	short loc_19531
	mov	g_mapRval, gameState_inWilderness
	and	ax, 7Fh
	mov	g_locationNumber, ax
	jmp	short loc_19555
loc_19531:
	mov	ax, [bp+destinationDungeon]
	cmp	dunLevelIndex, ax
	jz	short loc_1954A
	mov	g_mapRval, gameState_inDungeon
loc_1954A:
	mov	ax, [bp+destinationDungeon]
	mov	dunLevelIndex, ax
loc_19555:
	jmp	short l_return

loc_19557:
	cmp	[bp+destinationDungeon], 80h
	jb	short loc_19579
	mov	g_mapRval, gameState_inDungeon
	mov	ax, [bp+destinationDungeon]
	and	ax, 7Fh
	mov	dunLevelIndex, ax
	jmp	short l_return

loc_19579:
	mov	ax, [bp+destinationDungeon]
	cmp	g_locationNumber, ax
	jz	short loc_19592
	mov	g_mapRval, gameState_inWilderness
loc_19592:
	mov	ax, [bp+destinationDungeon]
	mov	g_locationNumber, ax

l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_teleport endp
