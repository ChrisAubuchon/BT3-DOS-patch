; This function	moves all of the roster	slots below
; partySlotNumber up one slot. It then zeroes the tail of the
; roster. This effectively removes the character from
; the roster.
; Attributes: bp-based frame

part_pack proc far

	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
loc_127AE:
	cmp	[bp+partySlotNumber], 6
	jge	short l_return
	getCharP	[bp+partySlotNumber], si
	lea	ax, roster._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, partySecondSlot._name[si]
	push	dx
	push	ax
	near_call	copyCharacterBuf,8
	inc	[bp+partySlotNumber]
	jmp	short loc_127AE
l_return:
	mov	gs:rosterTail._name, 0
	pop	si
	mov	sp, bp
	pop	bp
	retf
part_pack endp
