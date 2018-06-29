; Attributes: bp-based frame

_canSingSong proc far

	partySlotNumber=	word ptr  6

	FUNC_ENTER

	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short l_returnZero

	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	cmp	gs:party.class[bx], class_bard
	jz	short l_checkInstrument
	PUSH_OFFSET(s_notBard)
	PRINTSTRING(true)
	jmp	short l_returnZero

l_checkInstrument:
	mov	ax, itType_instrument
	push	ax
	push	[bp+partySlotNumber]
	CALL(character_hasTypeEquipped)
	or	ax, ax
	jz	short l_noInstrument

	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	cmp	gs:party.specAbil[bx],	0
	jnz	l_returnOne
	PUSH_OFFSET(s_dryThroat)
	PRINTSTRING(true)
	jmp	short l_returnZero

l_noInstrument:
	PUSH_OFFSET(s_notUsingInstrument)
	PRINTSTRING(true)

l_returnZero:
	sub	ax, ax
	jmp	l_return

l_returnOne:
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
_canSingSong endp
