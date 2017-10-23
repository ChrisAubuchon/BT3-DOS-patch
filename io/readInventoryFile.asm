; Attributes: bp-based frame

readInventoryStf proc far

	fd= word ptr	-2

	FUNC_ENTER
	CHKSTK(2)

	PUSH_OFFSET(a_inventoryStf)
	NEAR_CALL(openFile, 4)
	mov	[bp+fd], ax
	mov	ax, 84
	push	ax
	mov	ax, offset strg_inventory
	mov	dx, seg	dseg
	push	dx
	push	ax
	push	[bp+fd]
	CALL(_read, 8)
	push	[bp+fd]
	CALL(_close, 2)

	FUNC_EXIT
	retf
readInventoryStf endp

