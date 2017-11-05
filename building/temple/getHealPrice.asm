; Attributes: bp-based frame

temple_getHealPrice proc far

	targetLevel= word ptr	-2
	targetSlotNumber= word ptr	 6
	ailmentIndex= word ptr	 8

	FUNC_ENTER

	CHARINDEX(ax, STACKVAR(targetSlotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jb	short loc_14656
	mov	[bp+targetLevel], 1
	jmp	short loc_14670
loc_14656:
	CHARINDEX(ax, STACKVAR(targetSlotNumber), bx)
	mov	ax, gs:party.level[bx]
	RANGE_WITH_MAX(13, ax, cx)
	mov	[bp+targetLevel], ax
loc_14670:
	mov	bx, [bp+ailmentIndex]
	shl	bx, 1
	mov	ax, temple_healPrice[bx]
	imul	[bp+targetLevel]

	FUNC_EXIT
	retf
temple_getHealPrice endp
