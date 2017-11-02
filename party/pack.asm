; This function	moves all of the roster	slots below
; partySlotNumber up one slot. It then zeroes the tail of the
; party. This effectively removes the character from
; the party.
; Attributes: bp-based frame

party_pack proc far

	partySlotNumber=	word ptr  6

	FUNC_ENTER
	CHKSTK
	push	si
loc_127AE:
	cmp	[bp+partySlotNumber], 6
	jge	short l_return
	CHARINDEX(ax, STACKVAR(partySlotNumber), si)
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, partySecondSlot._name[si]
	push	dx
	push	ax
	CALL(copyCharacterBuf, near)
	inc	[bp+partySlotNumber]
	jmp	short loc_127AE
l_return:
	mov	gs:partyTail._name, 0
	pop	si
	FUNC_EXIT
	retf
party_pack endp
