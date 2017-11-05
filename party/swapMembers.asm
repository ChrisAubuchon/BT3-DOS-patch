; Attributes: bp-based frame

party_swapMembers proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER

	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	CHARINDEX(ax, STACKVAR(arg_0), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(copyCharacterBuf)

	CHARINDEX(ax, STACKVAR(arg_0), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CHARINDEX(ax, STACKVAR(arg_2), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(copyCharacterBuf)

	CHARINDEX(ax, STACKVAR(arg_2), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	push	dx
	push	ax
	CALL(copyCharacterBuf)

	FUNC_EXIT
	retf
party_swapMembers endp
