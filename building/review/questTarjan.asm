; Attributes: bp-based frame

review_questTarjan proc far

	loopCounter= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	ax, 0FFh
	push	ax
	mov	ax, QUESTFLAG(questBit_2, questByte_7)
	push	ax
	CALL(_updateFlags)

	mov	ax, quest_tarjanDone
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	mov	ax, quest_tarjanActive
	push	ax
	CALL(quest_partyNotHasFlagSet)
	or	ax, ax
	jz	l_returnZero

	sub	ax, ax
	push	ax
	mov	ax, 3Eh	
	push	ax
	CALL(_updateFlags)

	mov	ax, 0A0h 
	push	ax
	CALL(vm_findItem)
	or	ax, ax
	jz	l_returnZero

	mov	ax, 0FFh
	push	ax
	mov	ax, 3Eh	
	push	ax
	CALL(_updateFlags)

	PUSH_OFFSET(s_questTarjan_1)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questTarjan_2)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questTarjan_3)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questTarjan_4)
	PRINTSTRING(wait)

	mov	ax, bigpic_deadOldMan
	push	ax
	CALL(bigpic_drawPictureNumber)

	PUSH_OFFSET(s_questTarjan_5)
	PRINTSTRING(wait)

	mov	ax, quest_werraActive
	push	ax
	CALL(quest_setFlag)

	mov	ax, quest_tarjanActive
	push	ax
	CALL(quest_setFlag)

	mov	ax, 0FFh
	push	ax
	mov	ax, 46h	
	push	ax
	CALL(_updateFlags)

	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	cmp	gs:party.class[si], class_chronomancer
	jnz	short l_next
	mov	ax, 68h	
	push	ax
	push	[bp+loopCounter]
	CALL(character_learnSpell)

	mov	ax, 69h	
	push	ax
	push	[bp+loopCounter]
	CALL(character_learnSpell)

l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jge	short l_returnOne

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
review_questTarjan endp
