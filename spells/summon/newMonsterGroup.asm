; Attributes: bp-based frame

summon_newMonGroup proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER

	and	[bp+arg_0], 1Fh
	MONINDEX(ax, STACKVAR(arg_0))
	add	ax, offset summonData
	push	ds
	push	ax
	MONINDEX(ax, STACKVAR(arg_2), bx)
	lea	ax, g_monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(summon_maskSummonName, near)
	mov	ax, 20h
	push	ax
	MONINDEX(ax, STACKVAR(arg_0))
	add	ax, offset summonData+16
	push	ds
	push	ax
	MONINDEX(ax, STACKVAR(arg_2), bx)
	lea	ax, g_monGroups.hpDice[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memcpy)

	; FIXED: Set the group size to 0. 
	MONINDEX(ax, STACKVAR(arg_2), bx)
	mov	g_monGroups.groupSize[bx], 0

	FUNC_EXIT
	retf
summon_newMonGroup endp
