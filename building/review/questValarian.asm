; Attributes: bp-based frame

review_questValarian proc far
	FUNC_ENTER
	sub	ax, ax
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, quest_valarianDone
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, quest_brilhastDone
	push	ax
	CALL(quest_partyHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	PUSH_OFFSET(s_questValarian_1)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questValarian_2)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questValarian_3)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questValarian_4)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questValarian_5)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questValarian_6)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questValarian_7)
	PRINTSTRING(wait)

	mov	ax, 0FFh
	push	ax
	mov	ax, QUESTFLAG(questBit_1, questByte_7)
	push	ax
	CALL(_updateFlags)

	mov	ax, quest_brilhastActive
	push	ax
	CALL(quest_setFlag)

	mov	ax, quest_brilhastDone
	push	ax
	CALL(quest_setFlag)

	sub	ax, ax
	push	ax
	CALL(quest_setFlag)
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
review_questValarian endp
