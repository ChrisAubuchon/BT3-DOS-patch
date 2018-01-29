; Attributes: bp-based frame

mfunc_downStairs proc far

	dataP= dword ptr  6

	FUNC_ENTER

	cmp	g_sameSquareFlag, 0
	jnz	short l_return

	mov	g_sameSquareFlag, 1
	CALL(text_clear)
	mov	al, levFlags
	sub	ah, ah
	and	ax, 10h
	push	ax
	PUSH_OFFSET(s_thereAreStairs)
	CALL(stairsPluralHelper)
	CALL(getYesNo)
	or	ax, ax
	jz	short l_return

	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mfunc_setSameSquareFlag, near)
	dec	dunLevelNum
	jns	short l_changeLevel

	CALL(dun_setExitLocation, near)
	jmp	short l_return

l_changeLevel:
	CALL(dun_changeLevels, near)

l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_downStairs endp
