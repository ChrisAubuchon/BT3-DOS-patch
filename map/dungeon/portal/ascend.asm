; Attributes: bp-based frame

dun_ascendPortal proc far

	var_4= dword ptr -4
	sqE= word ptr	 6
	sqN= word ptr	 8

	FUNC_ENTER(4)

	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+sqE]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	test	byte ptr fs:[bx], 40h		; 40h == portal above
	jz	short l_return
	cmp	levitationDuration, 0
	jz	short l_return
	test	levFlags, 10h
	jz	short loc_25878
	CALL(portal_incrementLevel, near)
	jmp	short l_return
loc_25878:
	CALL(portal_decrementLevel, near)
l_return:
	FUNC_EXIT
	retf
dun_ascendPortal endp
