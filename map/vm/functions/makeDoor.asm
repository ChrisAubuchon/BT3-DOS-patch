; Attributes: bp-based frame

mfunc_makeDoor proc far

	squareP=	dword ptr -1Ch
	doorData=	word ptr -18h
	squareNumber=	word ptr -14h
	var_12=	dword ptr -12h
	rowNumber= word ptr	-0Eh
	charBufferP= dword ptr -0Ch
	var_8= word ptr	-8
	g_rowOffsetP= dword ptr	-6
	var_2= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(1Ch)

	mov	word ptr [bp+charBufferP], offset	g_rosterCharacterBuffer
	mov	word ptr [bp+charBufferP+2], seg seg022
	mov	ax, word ptr [bp+charBufferP]
	mov	dx, word ptr [bp+charBufferP+2]
	add	ax, 24h					; 24h == g_rowOffset
	mov	word ptr [bp+g_rowOffsetP], ax
	mov	word ptr [bp+g_rowOffsetP+2], dx

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+rowNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+squareNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+doorData], ax

	mov	ax, [bp+rowNumber]
	shl	ax, 1
	add	ax, word ptr [bp+g_rowOffsetP]
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	lfs	bx, [bp+squareP]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	mov	cx, [bp+squareNumber]
	mov	dx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, dx
	add	ax, cx
	add	ax, offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_12], ax
	mov	word ptr [bp+var_12+2],	seg seg022
	mov	ax, [bp+doorData]
	and	ax, 0Fh
	mov	[bp+var_2], ax
	mov	cl, 4
	shr	[bp+doorData], cl
	test	byte ptr [bp+doorData], 2
	jz	short loc_198EC
	inc	word ptr [bp+var_12]
loc_198EC:
	test	byte ptr [bp+doorData], 1
	jz	short loc_1990E
	lfs	bx, [bp+var_12]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 0F0h
	mov	[bp+var_8], ax
	mov	ax, [bp+var_2]
	or	[bp+var_8], ax
	mov	al, byte ptr [bp+var_8]
	mov	fs:[bx], al
	jmp	short loc_1992C
loc_1990E:
	lfs	bx, [bp+var_12]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_8], ax
	mov	ax, [bp+var_2]
	mov	cl, 4
	shl	ax, cl
	or	[bp+var_8], ax
	mov	al, byte ptr [bp+var_8]
	mov	fs:[bx], al
loc_1992C:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_makeDoor endp
