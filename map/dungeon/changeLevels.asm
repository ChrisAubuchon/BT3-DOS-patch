; Attributes: bp-based frame

dun_changeLevels proc far

	dungeonDataP= dword ptr -4

	FUNC_ENTER(4)
	push	si

	mov	word ptr [bp+dungeonDataP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+dungeonDataP+2], seg seg022
	mov	si, g_dunLevelNum
	lfs	bx, [bp+dungeonDataP]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	mov	dunLevelIndex, ax
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	g_sqNorth, ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	g_sqEast, ax
	mov	gs:levelChangedFlag, 1
	mov	g_mapRval, 4

	pop	si
	FUNC_EXIT
	retf
dun_changeLevels endp
