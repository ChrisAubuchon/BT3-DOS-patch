; Attributes: bp-based frame

review_questWerra proc far
	FUNC_ENTER

	mov	ax, quest_werraDone
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, quest_werraActive
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, 9Ch	
	push	ax
	CALL(vm_findItem)
	or	ax, ax
	jz	l_returnZero

	mov	ax, 9Dh	
	push	ax
	CALL(vm_findItem)
	or	ax, ax
	jz	short l_returnZero

	mov	ax, 9Ch	
	push	ax
	CALL(vm_removeItem)

	mov	ax, 9Dh	
	push	ax
	CALL(vm_removeItem)

	PUSH_OFFSET(s_questWerra_1)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questWerra_2)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questWerra_3)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questWerra_4)
	PRINTSTRING(wait)

	mov	ax, 0FFh
	push	ax
	mov	ax, QUESTFLAG(questBit_1, questByte_7)
	push	ax
	CALL(_updateFlags)

	mov	ax, quest_werraActive
	push	ax
	CALL(quest_setFlag)

	mov	ax, quest_sceaduActive
	push	ax
	CALL(quest_setFlag)

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
review_questWerra endp
