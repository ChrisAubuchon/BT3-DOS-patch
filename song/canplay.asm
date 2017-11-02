
; This function	returns	1 if the character is active,
; a bard and has an instrument equipped. 0 otherwise.
; Attributes: bp-based frame

_charCanPlaySong proc far

	partySlotNumber=	word ptr  6

	FUNC_ENTER
	CHKSTK
	push	si
	CHARINDEX(ax, STACKVAR(partySlotNumber), si)

	test	gs:party.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short l_returnZero

	cmp	gs:party.class[si], class_bard
	jnz	short l_returnZero

	mov	ax, itType_instrument
	push	ax
	push	[bp+partySlotNumber]
	CALL(inven_hasTypeEquipped)
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	pop	si
	FUNC_EXIT
	retf
_charCanPlaySong endp

