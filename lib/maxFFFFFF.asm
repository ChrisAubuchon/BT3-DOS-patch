; Attributes: bp-based frame

lib_maxFFFFFF proc far

	value= dword ptr	 6

	FUNC_ENTER
	cmp	word ptr [bp+value+2], 0FFh
	jb	short l_return
	ja	short l_setToMAx
	cmp	word ptr [bp+value], 0FFFFh
	jbe	short l_return
l_setToMax:
	mov	word ptr [bp+value], 0FFFFh
	mov	word ptr [bp+value+2], 0FFh
l_return:
	mov	ax, word ptr [bp+value]
	mov	dx, word ptr [bp+value+2]
	FUNC_EXIT
	retf
lib_maxFFFFFF endp
