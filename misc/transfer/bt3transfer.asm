; Attributes: bp-based frame

transfer_bt3Character proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER(4)

	push	[bp+arg_2]
	push	[bp+arg_0]
	CALL(roster_nameExists)
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_26868
	CALL(roster_countCharacters)
	mov	[bp+var_2], ax
	CHARINDEX(ax, STACKVAR(var_2), bx)
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	CALL(copyCharacterBuf)
	jmp	short loc_26881
loc_26868:
	PUSH_OFFSET(s_characterAlreadyExists)
	PRINTSTRING(true)
	IOWAIT
loc_26881:
	mov	sp, bp
	pop	bp
	retf
transfer_bt3Character endp
