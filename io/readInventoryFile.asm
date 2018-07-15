; Attributes: bp-based frame

readInventoryStf proc far

	fd= word ptr	-2

	FUNC_ENTER(2)

	PUSH_OFFSET(a_inventoryStf)
	CALL(openFile, near)
	mov	[bp+fd], ax
	mov	ax, 84
	push	ax
	mov	ax, offset g_storageInventory
	mov	dx, seg	dseg
	push	dx
	push	ax
	push	[bp+fd]
	CALL(read)
	push	[bp+fd]
	CALL(close)

	FUNC_EXIT
	retf
readInventoryStf endp

