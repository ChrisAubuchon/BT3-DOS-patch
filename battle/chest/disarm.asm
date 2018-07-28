; Attributes: bp-based frame

chest_disarm proc far

	stringBuffer=	word ptr -28h

	FUNC_ENTER(28h)
	push	si
	push	di

define(`slotNumber', `di')
	PRINTOFFSET(s_whoWillDisarm, clear)
	CALL(readSlotNumber)
	mov	slotNumber, ax
	or	ax, ax
	jl	l_returnZero

	CHARINDEX(ax, slotNumber, bx)
	test	gs:party.status[bx], 1Ch
	jnz	l_returnZero

	PRINTOFFSET(s_enterTrapName, clear)
	mov	ax, 28h	
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(readString)
	mov	bx, gs:g_trapIndex
	mov	al, g_chestTrapIndexToName[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_chestTrapName+2)[bx]
	push	word ptr g_chestTrapName[bx]
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(chest_trapStrcmp, near)
	or	ax, ax
	jz	short l_setOffTrap

	CHARINDEX(ax, slotNumber, si)
	cmp	gs:party.class[si], class_rogue
	jnz	short l_disarmFailed

	CALL(random)
	cmp	gs:party.specAbil[si],	al
	jb	short l_disarmFailed

	PRINTOFFSET(s_youDisarmedIt, clear)
	mov	gs:g_trapIndex, 0
	jmp	short l_returnOne

l_disarmFailed:
	PRINTOFFSET(s_disarmFailed, clear)
	jmp	short l_returnZero

l_setOffTrap:
	push	slotNumber
	CALL(chest_setOffTrap, near)

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	di
	pop	si
	FUNC_EXIT
	retf
chest_disarm endp

undefine(`slotNumber')
