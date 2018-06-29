; This function extracts a number of bits from the data buffer
; 
; Attributes: bp-based frame

_mfunc_extractCh proc far

	var_2= word ptr	-2
	bitCount= word ptr	 6

	FUNC_ENTER(2)

	mov	[bp+var_2], 0
loc_158BC:
	mov	ax, [bp+bitCount]
	dec	[bp+bitCount]
	or	ax, ax
	jz	short l_return
	dec	bitsLeft
	jns	short loc_158E4
	mov	bx, dataBufOff
	inc	dataBufOff
	mov	fs, dataBufSeg
	mov	al, fs:[bx]
	mov	curStrByte, al
	mov	bitsLeft, 7
loc_158E4:
	shl	[bp+var_2], 1
	cmp	curStrByte, 80h
	jb	short loc_158F3
	mov	ax, 1
	jmp	short loc_158F5
loc_158F3:
	sub	ax, ax
loc_158F5:
	or	[bp+var_2], ax
	shl	curStrByte, 1
	jmp	short loc_158BC
l_return:
	mov	ax, [bp+var_2]
	FUNC_EXIT
	retf
_mfunc_extractCh endp

