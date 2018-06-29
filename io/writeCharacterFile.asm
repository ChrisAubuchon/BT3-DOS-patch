; Attributes: bp-based frame

writeCharacterFile proc far

	fd= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)

	PUSH_OFFSET(s_thievesInf)
	CALL(openFile, near)
	mov	[bp+fd], ax
	CHARINDEX(ax, STACKVAR(slotNumber))
	inc	ax
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+fd]
	CALL(write)
	push	[bp+fd]
	CALL(close)

	FUNC_EXIT
	retf
writeCharacterFile endp
