; 1. Calculate the pixel width of the passed in string
; 2. Subtract half the pixel width from the width
;
; Attributes: bp-based frame

centerString proc far

	var_2= word ptr	-2
	inString= dword ptr  6
	width= word ptr	 0Ah

	FUNC_ENTER
	CHKSTK(2)

	mov	[bp+var_2], 0
l_loop:
	lfs	bx, [bp+inString]
	cmp	byte ptr fs:[bx], 0
	jz	short l_return
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	cbw
	push	ax
	NEAR_CALL(txt_charSpacing, 2)
	add	[bp+var_2], ax
	jmp	short l_loop

l_return:
	mov	ax, [bp+width]
	sub	ax, [bp+var_2]
	cwd
	sub	ax, dx
	sar	ax, 1

	FUNC_EXIT
	retf
centerString endp
