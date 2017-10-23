; Attributes: bp-based frame

camp_saveParty proc far

	savedPartyCount=	word ptr -18h
	partyName=	word ptr -16h
	var_2= word ptr	-2

	FUNC_ENTER
	CHKSTK(18h)
	PUSH_OFFSET(s_askPartyName)
	PRINTSTRING(true)
	mov	ax, 0Eh
	push	ax
	PUSH_STACK_ADDRESS(partyName)
	CALL(_readString, 6)
	or	ax, ax
	jz	short l_return
	NEAR_CALL(roster_countParties)
	mov	[bp+savedPartyCount], ax
	PUSH_STACK_ADDRESS(partyName)
	NEAR_CALL(roster_partyExists, 4)
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_13291
	mov	ax, [bp+savedPartyCount]
	mov	[bp+var_2], ax
loc_13291:
	cmp	[bp+var_2], 9
	jg	short l_return
	PUSH_STACK_ADDRESS(partyName)
	push	[bp+var_2]
	NEAR_CALL(roster_makeParty, 6)
l_return:
	FUNC_EXIT
	retf
camp_saveParty endp

