
; This function	returns	1 if the character is active,
; a bard and has an instrument equipped. 0 otherwise.
; Attributes: bp-based frame

_charCanPlaySong proc far

	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+partySlotNumber], si

	test	gs:roster.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short l_returnZero

	cmp	gs:roster.class[si], class_bard
	jnz	short l_returnZero

	mov	ax, itType_instrument
	push	ax
	push	[bp+partySlotNumber]
	call	inven_hasTypeEquipped
	add	sp, 4
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_charCanPlaySong endp

