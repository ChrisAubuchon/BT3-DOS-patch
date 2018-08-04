; Attributes: bp-based frame

bat_monSwapGroups proc far

	tmpBuffer=	word ptr -40h
	sourceBuffer= word ptr	 6
	destinationBuffer= word ptr	 8

	FUNC_ENTER(40h)

	mov	ax, 64
	push	ax
	mov	bx, [bp+sourceBuffer]
	mov	cl, 6
	shl	bx, cl
	lea	ax, g_monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(tmpBuffer)
	CALL(memcpy)

	mov	ax, 64
	push	ax
	mov	bx, [bp+destinationBuffer]
	mov	cl, 6
	shl	bx, cl
	lea	ax, g_monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	bx, [bp+sourceBuffer]
	shl	bx, cl
	lea	ax, g_monHpList[bx]
	push	dx
	push	ax
	CALL(memcpy)

	mov	ax, 64
	push	ax
	PUSH_STACK_ADDRESS(tmpBuffer)
	mov	bx, [bp+destinationBuffer]
	mov	cl, 6
	shl	bx, cl
	lea	ax, g_monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memcpy)

	mov	ax, monStruSize
	push	ax
	MONINDEX(ax, STACKVAR(sourceBuffer), bx)
	lea	ax, g_monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(tmpBuffer)
	CALL(memcpy)

	mov	ax, monStruSize
	push	ax
	MONINDEX(ax, STACKVAR(destinationBuffer), bx)
	lea	ax, g_monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	MONINDEX(ax, STACKVAR(sourceBuffer), bx)
	lea	ax, g_monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memcpy)

	mov	ax, monStruSize
	push	ax
	PUSH_STACK_ADDRESS(tmpBuffer)
	MONINDEX(ax, STACKVAR(destinationBuffer), bx)
	lea	ax, g_monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memcpy)

	FUNC_EXIT
	retf
bat_monSwapGroups endp
