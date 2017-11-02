; Attributes: bp-based frame

writePartyFile proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER
	CHKSTK(2)

	PUSH_OFFSET(s_partiesInf)
	NEAR_CALL(openFile, 4)
	mov	[bp+var_2], ax
	mov	ax, [bp+arg_0]
	mov	cl, 7
	shl	ax, cl
	inc	ax
	push	ax
	mov	ax, offset g_rosterPartyBuffer
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
writePartyFile endp
