; Attributes: bp-based frame

writeCharacterFile proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER
	CHKSTK(2)

	PUSH_OFFSET(s_thievesInf)
	CALL(openFile, near)
	mov	[bp+var_2], ax
	CHARINDEX(ax, STACKVAR(arg_0))
	inc	ax
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_2]
	CALL(write)
	push	[bp+var_2]
	CALL(close)
	mov	sp, bp
	pop	bp
	retf
writeCharacterFile endp
