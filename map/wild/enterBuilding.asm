; Attributes: bp-based frame

wild_enterBuilding proc far

	square=	word ptr  6

	FUNC_ENTER

	mov	ax, [bp+square]
	mov	cl, 4
	sar	ax, cl
	and	ax, 0Fh

	sub	ax, 1
	cmp	ax, 8
	ja	l_returnZero
	add	ax, ax
	xchg	ax, bx
	jmp	cs:buildingOffsets[bx]

buildingOffsets dw offset l_camp ; 0x10
		dw offset l_tavern	; 0x20
		dw offset l_temple	; 0x30
		dw offset l_normalBuilding ; 0x40
		dw offset l_returnZero	; 0x50
		dw offset l_storageBuilding ; 0x60
		dw offset l_reviewBoard	; 0x70
		dw offset l_hallOfWizards	; 0x80
		dw offset l_bards		; 0x90

l_camp:
	CALL(camp_enter)
	jmp	l_turnAround

l_tavern:
	CALL(tavern_enter)
	jmp	l_turnAround

l_temple:
	CALL(temple_enter)
	jmp	l_turnAround

l_normalBuilding:
	CALL(empty_enter)
	jmp	l_turnAround

l_storageBuilding:
	CALL(storage_enter)
	jmp	l_turnAround

l_reviewBoard:
	CALL(review_enter)
	jmp	l_turnAround

l_hallOfWizards:
	CALL(wizardHall_enter)
	jmp	l_turnAround

l_bards:
	CALL(bards_enter)
	jmp	l_turnAround

l_returnZero:
	sub	ax, ax
	jmp	short l_return

l_turnAround:
	mov	g_mapRval, ax
	CALL(map_turnAround)
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
wild_enterBuilding endp

