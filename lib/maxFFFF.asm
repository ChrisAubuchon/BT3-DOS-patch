; Attributes: bp-based frame
;
; This function sets the maximum value of the dword
; to 0xFFFF. The function is always called with the high
; word as 0 so this doesn't really have any use.

lib_maxFFFF proc	far

	value= dword ptr	 6

	FUNC_ENTER
	cmp	word ptr [bp+value+2], 0
	jnz	short l_setToMax
	cmp	word ptr [bp+value], 0FFFFh
	jbe	short l_return
l_setToMax:
	mov	word ptr [bp+value], 0FFFFh
	mov	word ptr [bp+value+2], 0
l_return:
	mov	ax, word ptr [bp+value]
	FUNC_EXIT
	retf
lib_maxFFFF endp
