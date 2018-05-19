; Attributes: bp-based frame

dun_setExitLocation proc far

	dungeonDataP= dword ptr -4

	FUNC_ENTER(4)
	mov	word ptr [bp+dungeonDataP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+dungeonDataP+2], seg seg022
	lfs	bx, [bp+dungeonDataP]
	mov	al, fs:[bx+dun_t.exitSqN]
	sub	ah, ah
	mov	sq_north, ax
	mov	al, fs:[bx+dun_t.exitSqE]
	mov	sq_east, ax
	mov	al, fs:[bx+dun_t.exitLocation]
	mov	g_locationNumber, ax
	mov	g_mapRval, 2
	FUNC_EXIT
	retf
dun_setExitLocation endp
