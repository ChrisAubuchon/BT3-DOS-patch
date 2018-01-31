; Attributes: bp-based frame

review_questFerofist proc far
	FUNC_ENTER

	mov	ax, quest_ferofistDone
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, quest_ferofistActive
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, 87h	
	push	ax
	CALL(vm_findItem)
	or	ax, ax
	jz	l_returnZero

	mov	ax, 88h	
	push	ax
	CALL(vm_findItem)
	or	ax, ax
	jz	short l_returnZero

	mov	ax, 87h	
	push	ax
	CALL(vm_removeItem)

	mov	ax, 88h	
	push	ax
	CALL(vm_removeItem)

	PUSH_OFFSET(s_questFerofist_1)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questFerofist_2)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questFerofist_3)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questFerofist_4)
	PRINTSTRING(wait)

	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	CALL(_updateFlags)

	mov	ax, quest_ferofistActive
	push	ax
	CALL(quest_setFlag)

	mov	ax, quest_alliriaActive
	push	ax
	CALL(quest_setFlag)
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
review_questFerofist endp
