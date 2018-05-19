; Attributes: bp-based frame

bat_getAttackerName proc far

	unmaskedName=	word ptr -10h
	stringBufferP= dword ptr  6
	slotNumber= word ptr	 0Ah

	FUNC_ENTER(10h)

	cmp	[bp+slotNumber], 80h
	jge	short l_enemyAttacker
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+stringBufferP]
	STRCAT(stringBufferP)
	jmp	short l_return

l_enemyAttacker:
	and	[bp+slotNumber], 3
	APPEND_CHAR(STACKVAR(stringBufferP), 'a')
	PUSH_STACK_ADDRESS(unmaskedName)
	MONINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)
	mov	al, byte ptr [bp+unmaskedName]
	cbw
	push	ax
	CALL(str_startsWithVowel)
	or	ax, ax
	jz	short l_singular
	APPEND_CHAR(STACKVAR(stringBufferP), 'n')

l_singular:
	APPEND_CHAR(STACKVAR(stringBufferP), ' ')
	sub	ax, ax
	push	ax
	PUSH_STACK_PTR(stringBufferP)
	PUSH_STACK_ADDRESS(unmaskedName)
	PLURALIZE(stringBufferP)

l_return:
	mov	ax, word ptr [bp+stringBufferP]
	mov	dx, word ptr [bp+stringBufferP+2]

	FUNC_EXIT
	retf
bat_getAttackerName endp
