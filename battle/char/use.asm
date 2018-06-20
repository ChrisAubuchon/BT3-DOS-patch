; Attributes: bp-based frame

bat_charUse proc far

	slotNumber=	word ptr  6

	FUNC_ENTER

	mov	ax, 1
	push	ax
	mov	bx, [bp+slotNumber]
	mov	al, gs:g_batCharActionTarget[bx]
	sub	ah, ah
	push	ax
	mov	al, gs:byte_42276[bx]
	push	ax
	mov	al, gs:byte_42334[bx]
	push	ax
	push	bx
	CALL(item_doSpell)

	FUNC_EXIT
	retf
bat_charUse endp
