; Attributes: bp-based frame

bat_monResetGroups proc far

	loopCounter= word ptr	-2
	groupCount= word ptr	 6

	FUNC_ENTER(2)

	mov	ax, [bp+groupCount]
	mov	[bp+loopCounter], ax
loc_1C9AA:
	mov	ax, monStruSize
	push	ax
	sub	ax, ax
	push	ax
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	lea	ax, g_monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memset)
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short loc_1C9AA

	FUNC_EXIT
	retf
bat_monResetGroups endp
