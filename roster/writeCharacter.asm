; Attributes: bp-based frame

roster_writeCharacter proc far
	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber= word ptr  6

	FUNC_ENTER(4)

	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(roster_nameExists, near)
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short l_overwrite
	CALL(roster_countCharacters, near)
	mov	[bp+var_2], ax
	CHARINDEX(ax, STACKVAR(var_2), bx)
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	CHARINDEX(ax, STACKVAR(var_2), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(copyCharacterBuf, near)
	jmp	short l_return

l_overwrite:
	CHARINDEX(ax, STACKVAR(var_4), bx)
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(copyCharacterBuf, near)

l_return:
	FUNC_EXIT
	retf
roster_writeCharacter endp
