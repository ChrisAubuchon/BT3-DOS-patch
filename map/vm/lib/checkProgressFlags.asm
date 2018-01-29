; Attributes: bp-based frame

checkProgressFlags proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	flagData= word ptr	 6

	FUNC_ENTER(4)
	mov	ax, [bp+flagData]
	mov	cl, 3
	shr	ax, cl
	mov	[bp+var_4], ax
	mov	ax, [bp+flagData]
	and	ax, 7
	mov	[bp+var_2], ax
	mov	bx, [bp+var_4]
	mov	al, g_gameProgressFlags[bx]
	sub	ah, ah
	mov	bx, [bp+var_2]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	and	ax, cx
	FUNC_EXIT
	retf
checkProgressFlags endp
