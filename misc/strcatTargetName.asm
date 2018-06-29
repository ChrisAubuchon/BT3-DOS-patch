; Attributes: bp-based frame

strcatTargetName proc far

	monName=	word ptr -10h
	destString= dword ptr  6
	targetIndexNumber= word ptr	 0Ah
	targetCount= word ptr	 0Ch

	FUNC_ENTER(10h)

	cmp	[bp+targetIndexNumber], 80h
	jge	short l_monTarget
	CHARINDEX(ax, STACKVAR(targetIndexNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_DWORD(destString)
	STRCAT(destString)
	jmp	l_return

l_monTarget:
	and	[bp+targetIndexNumber], 3
	PUSH_STACK_ADDRESS(monName)
	MONINDEX(ax, STACKVAR(targetIndexNumber), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)

	cmp	[bp+targetCount], 0
	jz	short l_monSingular
	PUSH_OFFSET(s_some)
	PUSH_STACK_DWORD(destString)
	STRCAT(destString)
	jmp	short l_pluralize

l_monSingular:
	APPEND_CHAR(STACKVAR(destString), 'a')
	mov	al, byte ptr [bp+monName]
	cbw
	push	ax
	CALL(str_startsWithVowel)
	or	ax, ax
	jz	short l_appendSpace
	APPEND_CHAR(STACKVAR(destString), 'n')

l_appendSpace:
	APPEND_CHAR(STACKVAR(destString), ' ')

l_pluralize:
	push	[bp+targetCount]
	PUSH_STACK_DWORD(destString)
	PUSH_STACK_ADDRESS(monName)
	PLURALIZE(destString)
l_return:
	mov	ax, word ptr [bp+destString]
	mov	dx, word ptr [bp+destString+2]

	FUNC_EXIT
	retf
strcatTargetName endp
