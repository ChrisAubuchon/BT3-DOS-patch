; Attributes: bp-based frame

dun_descendPortal proc far

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
	test	byte ptr fs:[bx], 20h			; 20h == portal below
	jz	short loc_258E5
	cmp	levitationDuration, 0
	jnz	short loc_258CF
	CALL(dunsq_drainHp)
loc_258CF:
	test	g_levelFlags, 10h
	jz	short loc_258E1
	CALL(portal_decrementLevel)
	jmp	short loc_258E5
loc_258E1:
	CALL(portal_incrementLevel)
loc_258E5:
	FUNC_EXIT
	retf
dun_descendPortal endp
