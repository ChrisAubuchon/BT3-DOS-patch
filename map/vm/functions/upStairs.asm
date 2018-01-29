; Attributes: bp-based frame

mfunc_upStairs proc far

	dataP= dword ptr  6

	FUNC_ENTER

	cmp	g_sameSquareFlag, 0
	jnz	short l_return
	mov	g_sameSquareFlag, 1
	CALL(text_clear)
	mov	al, levFlags
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	push	cx
	PUSH_OFFSET(s_thereAreStairs)
	CALL(stairsPluralHelper)
	CALL(getYesNo)
	or	ax, ax
	jz	short l_return
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mfunc_setSameSquareFlag, near)
	inc	dunLevelNum
	CALL(dun_changeLevels, near)
l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_upStairs endp
