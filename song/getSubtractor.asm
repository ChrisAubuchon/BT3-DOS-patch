; This function	returns	the amount of songs that
; should be subtracted from the	bards songsLeft
; field. If an item with itemEff_freeSinging is
; equipped, return 0. If the bard has songs left,
; return 1. Otherwise return -1.
; Attributes: bp-based frame

song_getSubtractor proc far

	partySlotNumber= word ptr	 6

	FUNC_ENTER

	mov	ax, itemEff_freeSinging
	push	ax
	push	[bp+partySlotNumber]
	CALL(character_isEffectEquipped)
	or	ax, ax
	jz	short l_returnZero

	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	cmp	gs:party.specAbil[bx],	0
	jz	short l_returnMinusOne
	mov	ax, 1
	jmp	short l_return

l_returnMinusOne:
	mov	ax, 0FFFFh
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
song_getSubtractor endp
