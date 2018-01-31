; Attributes: bp-based frame

review_questBrilhasti proc far
	FUNC_ENTER

	mov	ax, 35
	push	ax
	CALL(vm_partyUnderLevel)
	or	ax, ax
	jnz	short loc_24250

	mov	ax, quest_brilhastDone
	push	ax
	CALL(quest_partyHasFlagSet)
	or	ax, ax
	jnz	short loc_24250

	mov	ax, quest_brilhastActive
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	short l_returnZero

	PUSH_OFFSET(s_questBrilhasti_1)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questBrilhasti_2)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questBrilhasti_3)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questBrilhasti_4)
	PRINTSTRING(wait)

	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	CALL(_updateFlags)

	mov	ax, quest_brilhastActive
	push	ax
	CALL(quest_setFlag)
	mov	ax, 1
	jmp	short l_return

loc_24250:
	mov	ax, quest_brilhastActive
	push	ax
	CALL(quest_setFlag)

	mov	ax, quest_brilhastDone
	push	ax
	CALL(quest_setFlag)

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
review_questBrilhasti endp
