; This function	returns	the passed value or 255
; depending on which is	lower. This is equivalent
; to the C statement:
; (val)	<= 255 ? (val) : 255
; Attributes: bp-based frame

lib_maxFF proc far

	val= word ptr  6

	FUNC_ENTER

	mov	ax, [bp+val]
	cmp	ax, 255
	jle	short l_return
	mov	ax, 255

l_return:
	FUNC_EXIT
	retf
lib_maxFF endp
