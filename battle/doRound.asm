; Attributes: bp-based frame

bat_doRound proc far

	charNo=	word ptr -0Ch
	charPri= word ptr -0Ah
	monPri=	word ptr -8
	groupNo= word ptr -4
	monNo= word ptr	-2

	FUNC_ENTER(0Ch)
	CALL(bat_setPriorities)

l_loop:
	PUSH_STACK_ADDRESS(charNo)
	CALL(bat_charGetNextPriority, near)
	mov	[bp+charPri], ax
	PUSH_STACK_ADDRESS(groupNo)
	PUSH_STACK_ADDRESS(monNo)
	CALL(bat_monGetNextPriority)
	mov	[bp+monPri], ax

	cmp	[bp+charPri], 0
	jnz	short l_comparePriority
	cmp	[bp+monPri], 0
	jz	l_return

l_comparePriority:
	cmp	[bp+charPri], ax
	jl	short l_monsterFirst
	push	[bp+charNo]
	CALL(bat_charAction, near)
	jmp	short l_afterAttack

l_monsterFirst:
	push	[bp+groupNo]
	push	[bp+monNo]
	CALL(bat_monAction)

l_afterAttack:
	cmp	gs:g_currentCharPosition, 0
	jz	short loc_1B2FC
	CALL(txt_newLine)

loc_1B2FC:
	CALL(txt_newLine)
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_loop

l_return:
	FUNC_EXIT
	retf
bat_doRound endp
