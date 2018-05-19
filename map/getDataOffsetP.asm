; This function	returns	the memory address of the
; map data at *membuf.
; Attributes: bp-based frame
map_getDataOffsetP proc	far

	memBuf=	dword ptr  6

	FUNC_ENTER
	push	si

	lfs	bx, [bp+memBuf]
	mov	bl, fs:[bx]
	sub	bh, bh
	mov	si, word ptr [bp+memBuf]
	mov	si, fs:[si+1]
	and	si, 0FFh
	mov	cl, 8
	shl	si, cl
	lea	ax, g_rosterCharacterBuffer[bx+si]
	mov	dx, seg	seg022
	pop	si
	FUNC_EXIT
	retf
map_getDataOffsetP endp
