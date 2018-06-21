; Attributes: bp-based frame

empty_enter proc	far
	FUNC_ENTER

	CALL(random)
	test	al, 3
	jnz	short l_noBattle

	mov	g_partyAttackFlag, 0
	CALL(bat_init)

l_noBattle:
	cmp	g_locationNumber, location_skara
	jnz	short l_useEmptyPicture
	mov	ax, bigpic_destroyedBuilding
	jmp	short l_showPicture

l_useEmptyPicture:
	mov	ax, bigpic_emptyBuilding

l_showPicture:
	push	ax
	CALL(bigpic_drawPictureNumber)
	PUSH_OFFSET(s_building)
	CALL(setTitle)
	PRINTOFFSET(s_emptyBuilding, clear)
	IOWAIT
	sub	ax, ax

	FUNC_EXIT
	retf
empty_enter endp
