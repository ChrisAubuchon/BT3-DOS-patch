; This function	returns	the amount of songs that
; should be subtracted from the	bards songsLeft
; field. If an item with itemEff_freeSinging is
; equipped, return 0. If the bard has songs left,
; return 1. Otherwise return -1.
; Attributes: bp-based frame

sing_getSongSubtractor proc far

	partySlotNumber= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, itemEff_freeSinging
	push	ax
	push	[bp+partySlotNumber]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jz	short l_returnZero

	getCharP	[bp+partySlotNumber], bx
	cmp	gs:roster.specAbil[bx],	0
	jz	short l_returnMinusOne
	mov	ax, 1
	jmp	short l_return

l_returnMinusOne:
	mov	ax, 0FFFFh
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
sing_getSongSubtractor endp
