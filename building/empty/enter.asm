; Attributes: bp-based frame

empty_enter proc	far
	FUNC_ENTER
	CHKSTK

	CALL(random)
	test	al, 3
	jnz	short l_noBattle

	mov	partyAttackFlag, 0
	CALL(bat_init)

l_noBattle:
	cmp	currentLocationMaybe, 1
	jnz	short loc_14956
	mov	ax, 50
	jmp	short loc_14959
loc_14956:
	mov	ax, 69

loc_14959:
	push	ax
	CALL(bigpic_drawPictureNumber, 2)
	PUSH_OFFSET(s_building)
	CALL(setTitle, 4)
	PUSH_OFFSET(s_emptyBuilding)
	PRINTSTRING(true)
	IOWAIT
	sub	ax, ax

	FUNC_EXIT
	retf
empty_enter endp
