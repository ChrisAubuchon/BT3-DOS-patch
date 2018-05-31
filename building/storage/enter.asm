; Attributes: bp-based frame
storage_enter proc	far

	FUNC_ENTER

	mov	ax, 50
	push	ax
	CALL(bigpic_drawPictureNumber)
	PUSH_OFFSET(s_building)
	CALL(setTitle)
	CALL(readInventoryStf, near)
l_ioLoopEntry:
	PUSH_OFFSET(s_storageMenu)
	PRINTSTRING(true)
	CALL(readSlotNumber, near)
	or	ax, ax
	jl	short l_return

	push	ax
	CALL(storage_getItem, near)
	jmp	short l_ioLoopEntry
l_return:
	CALL(writeInventoryStf, near)
	CALL(text_clear)
	mov	g_mapRval, 2
	sub	ax, ax

	FUNC_EXIT
	retf
storage_enter endp
