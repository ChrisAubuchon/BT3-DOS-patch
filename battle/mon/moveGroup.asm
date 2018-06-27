; This function	copies the monster group to a
; different slot and zeroes the	vacated	slot.
; Attributes: bp-based frame

bat_monMoveGroup proc far

	sourceSlotNumber= word ptr	 6
	destinationSlotNumber= word ptr	 8

	FUNC_ENTER

	MONINDEX(ax, STACKVAR(destinationSlotNumber), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	MONINDEX(ax, STACKVAR(sourceSlotNumber), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(bat_monCopyBuffer)

	mov	ax, 40h	
	push	ax
	mov	bx, [bp+sourceSlotNumber]
	mov	cl, 6
	shl	bx, cl
	lea	ax, g_monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	bx, [bp+destinationSlotNumber]
	shl	bx, cl
	lea	ax, g_monHpList[bx]
	push	dx
	push	ax
	CALL(memcpy)

	mov	ax, monStruSize
	push	ax
	sub	ax, ax
	push	ax
	MONINDEX(ax, STACKVAR(sourceSlotNumber), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memset)

	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+sourceSlotNumber]
	mov	cl, 6
	shl	bx, cl
	lea	ax, g_monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memset)

	FUNC_EXIT
	retf
bat_monMoveGroup endp
