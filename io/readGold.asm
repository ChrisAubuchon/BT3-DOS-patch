; Attributes: bp-based frame

readGold proc far

	stringBuffer=	word ptr -14h
	gold= dword ptr	-4

	FUNC_ENTER
	CHKSTK(14h)

	mov	ax, 10h
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(readString, near)
	or	dx, ax
	jz	short l_returnZero
	PUSH_STACK_ADDRESS(gold)
	PUSH_OFFSET(s_u)
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(sscanf)
	mov	ax, word ptr [bp+gold]
	mov	dx, word ptr [bp+gold+2]
	jmp	short l_return
l_returnZero:
	sub	ax, ax
	cwd
	jmp	short $+2
l_return:
	FUNC_EXIT
	retf
readGold endp
