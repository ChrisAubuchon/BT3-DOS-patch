; Attributes: bp-based frame
storage_enter proc	far

	FUNC_ENTER
	CHKSTK

	mov	ax, 50
	push	ax
	CALL(bigpic_drawPictureNumber, 2)
	PUSH_OFFSET(s_building)
	CALL(setTitle, 4)
	NEAR_CALL(readInventoryStf)
l_ioLoopEntry:
	PUSH_OFFSET(s_storageMenu)
	PRINTSTRING(true)
	NEAR_CALL(readSlotNumber)
	or	ax, ax
	jl	short l_return

	push	ax
	NEAR_CALL(storage_getItem, 2)
	jmp	short l_ioLoopEntry
l_return:
	NEAR_CALL(writeInventoryStf)
	CALL(text_clear)
	mov	buildingRvalMaybe, 2
	sub	ax, ax

	FUNC_EXIT
	retf
storage_enter endp
