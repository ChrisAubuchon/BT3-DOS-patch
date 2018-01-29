; This function	draws the bigpic image located at *dataP;
; Attributes: bp-based frame

mfunc_drawBigpic proc far

	picNo= word ptr	-2
	dataP=	dword ptr  6

	FUNC_ENTER(2)
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+picNo], ax
	CALL(bigpic_drawPictureNumber)
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_drawBigpic endp
