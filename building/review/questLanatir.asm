; Attributes: bp-based frame
review_questLanatir proc	far
	FUNC_ENTER

	mov	ax, 2
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, quest_lanatirDone
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, 7Bh	
	push	ax
	CALL(vm_findItem)
	or	ax, ax
	jz	l_returnZero

	mov	ax, 7Ch	
	push	ax
	CALL(vm_findItem)
	or	ax, ax
	jz	short l_returnZero

	mov	ax, 7Bh	
	push	ax
	CALL(vm_removeItem)

	mov	ax, 7Ch	
	push	ax
	CALL(vm_removeItem)

	PUSH_OFFSET(s_questLanatir_1)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questLanatir_2)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questLanatir_3)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questLanatir_4)
	PRINTSTRING(wait)

	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	CALL(_updateFlags)

	mov	ax, quest_lanatirActive
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
review_questLanatir endp
