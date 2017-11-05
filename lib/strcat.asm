; Attributes: bp-based frame

strcat	proc far

	toStr= dword ptr  6
	fromStr= dword ptr  0Ah

	FUNC_ENTER

l_loopEntry:
	lfs	bx, [bp+fromStr]
	inc	word ptr [bp+fromStr]
	mov	al, fs:[bx]
	lfs	bx, [bp+toStr]
	inc	word ptr [bp+toStr]
	mov	fs:[bx], al
	or	al, al
	jnz	short l_loopEntry
	lfs	bx, [bp+toStr]
	mov	byte ptr fs:[bx], 0
	dec	word ptr [bp+toStr]
	mov	ax, word ptr [bp+toStr]
	mov	dx, word ptr [bp+toStr+2]

	FUNC_EXIT
	retf
strcat	endp
