; Attributes: bp-based frame

bat_charCast proc far

	slotNumber=	word ptr  6

	FUNC_ENTER

	mov	bx, [bp+slotNumber]
	mov	al, gs:g_batCharSpellTarget[bx]
	mov	gs:bat_curTarget, al
	mov	ax, 1
	push	ax
	push	ax
	mov	al, gs:g_batCharActionTarget[bx]
	sub	ah, ah
	push	ax
	push	bx
	CALL(doCastSpell)

	FUNC_EXIT
	retf
bat_charCast endp

