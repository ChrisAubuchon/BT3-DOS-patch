; This function creates a byte array to determine what
; menu items are available in the Camp
;
; a[0] - Add a member
; a[1] - Remove a member
; a[2] - Rename a member
; a[3] - Create a member
; a[4] - Transfer characters
; a[5] - Delete a member
; a[6] - Save the party
; a[7] - Leave the game
; a[8] - Enter wilderness

; Attributes: bp-based frame

camp_configOptionList proc far

	counter= word ptr -2
	arg_0= dword ptr  6

	FUNC_ENTER
	CHKSTK(2)
	push	si

	CALL(party_findEmptySlot, near)
	cmp	ax, 7
	jge	short loc_1387B
	mov	al, 1
	jmp	short l_setElementZero
loc_1387B:
	sub	al, al
l_setElementZero:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.hasEmptySlot], al	; Add a member

	CALL(party_isNotEmpty, near)
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.notEmpty], al		; Remove a member

	cmp	fs:[bx+campStru_t.notEmpty], 1
	sbb	ax, ax
	neg	ax
	mov	fs:[bx+campStru_t.isEmpty], al		; Rename a member

	CALL(roster_countCharacters, near)
	cmp	ax, 75
	jge	short loc_138AB
	mov	al, 1
	jmp	short l_setElementThree
loc_138AB:
	sub	al, al
l_setElementThree:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.canSaveChar],	al	; Create a member

	mov	al, fs:[bx+campStru_t.canSaveChar]
	mov	fs:[bx+campStru_t.canSaveChar_1], al	; Transfer characters

	mov	[bp+counter], campStru_t.field_5	; Set the rest to 1
	jmp	short loc_138C9
loc_138C6:
	inc	[bp+counter]
loc_138C9:
	cmp	[bp+counter], 8
	jge	short loc_138DB
	mov	bx, [bp+counter]
	lfs	si, [bp+arg_0]
	mov	byte ptr fs:[bx+si], 1
	jmp	short loc_138C6
loc_138DB:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+campStru_t.notEmpty]
	mov	fs:[bx+campStru_t.field_6], al		; Save the party
	CALL(party_getLastSlot, near)
	cmp	ax, 7
	jge	short loc_138F3
	mov	al, 1
	jmp	short loc_138F5
loc_138F3:
	sub	al, al
loc_138F5:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+8], al				; Enter Wilderness
	pop	si
	FUNC_EXIT
	retf
camp_configOptionList endp

