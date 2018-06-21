; Attributes: bp-based frame
storage_enter proc	far

	FUNC_ENTER

	mov	ax, bigpic_destroyedBuilding
	push	ax
	CALL(bigpic_drawPictureNumber)

	PUSH_OFFSET(s_building)
	CALL(setTitle)

	CALL(readInventoryStf, near)

l_ioLoopEntry:
	PRINTOFFSET(s_storageMenu, clear)
	CALL(readSlotNumber, near)
	or	ax, ax
	jl	short l_return

	push	ax
	CALL(storage_getItem, near)
	jmp	short l_ioLoopEntry

l_return:
	CALL(writeInventoryStf, near)
	CALL(text_clear)
	mov	g_mapRval, gameState_inWilderness
	sub	ax, ax

	FUNC_EXIT
	retf
storage_enter endp
