; Attributes: bp-based frame
bat_charPartyAttackAction proc	far

	arg_0= word ptr	 6

	FUNC_ENTER
	PUSH_OFFSET(s_attack)
	mov	ax, 1
	push	ax
	CALL(bat_charGetActionOptionsTarget, near)
	cmp	ax, 0
	jl	l_returnZero

	mov	bx, [bp+arg_0]
	mov	gs:g_batCharActionTarget[bx], al
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_charPartyAttackAction endp
