; Attributes: bp-based frame
define(`slotNumber', `di')dnl
chest_open proc	far

	FUNC_ENTER(2)
	push	si
	push	di

	PRINTOFFSET(s_whoWillOpen, clear)
	CALL(readSlotNumber)
	mov	slotNumber, ax
	or	ax, ax
	jl	l_returnZero

	CHARINDEX(ax, slotNumber, si)
	test	gs:party.status[si], 7Ch
	jnz	l_returnZero

	cmp	gs:party.class[si], class_monster
	jnb	l_returnZero

	CALL(random)
	test	al, 80h
	jz	short l_noTrap

	push	slotNumber
	CALL(chest_setOffTrap, near)
	jmp	short l_returnOne

l_noTrap:
	mov	gs:g_trapIndex, 0
	mov	gs:g_bigpicLongerCelDelay, 1

l_returnOne:
	DELAY(5)
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	di
	pop	si
	FUNC_EXIT
	retf
chest_open endp
undefine(`slotNumber')dnl
