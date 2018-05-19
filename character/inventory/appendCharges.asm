; Attributes: bp-based frame

inventory_appendCharges proc far

	stringBuffer= dword ptr  6
	itemCount= word ptr	 0Ah

	FUNC_ENTER

	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], ' '

	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], '#'

	mov	ax, 2
	push	ax
	mov	ax, [bp+itemCount]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+stringBuffer+2]
	push	word ptr [bp+stringBuffer]
	ITOA

	FUNC_EXIT
	retf
inventory_appendCharges endp
