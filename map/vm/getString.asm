; Attributes: bp-based frame

_mfunc_getString proc far

	memOffset= word	ptr  6
	memSegment= word ptr  8
	rbuf= dword ptr	 0Ah

	FUNC_ENTER

	mov	ax, [bp+memOffset]
	mov	dx, [bp+memSegment]
	mov	dataBufOff, ax
	mov	dataBufSeg, dx
	mov	bitsLeft, 0
	mov	_str_capFlag, 0
loc_157E6:
	CALL(_mfunc_unpackChar, near)
	lfs	bx, [bp+rbuf]
	inc	word ptr [bp+rbuf]
	mov	fs:[bx], al
	or	al, al
	jnz	short loc_157E6
	mov	ax, dataBufOff
	mov	dx, dataBufSeg
	jmp	short $+2

	FUNC_EXIT
	retf
_mfunc_getString endp
