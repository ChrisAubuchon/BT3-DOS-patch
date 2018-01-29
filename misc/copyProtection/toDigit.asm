; Attributes: bp-based frame

cp_toDigit proc far

	inValue= word ptr	 6

	FUNC_ENTER

	mov	ax, [bp+inValue]
	and	ax, 7
	or	al, 30h
	FUNC_EXIT
	retf
cp_toDigit endp
