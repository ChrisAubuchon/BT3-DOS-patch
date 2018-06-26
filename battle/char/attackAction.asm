; Attributes: bp-based frame

bat_charAttackAction proc far

	targetNumber= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)
	PUSH_OFFSET(s_attack)
	mov	ax, 2
	push	ax
	CALL(bat_charGetActionOptionsTarget, near)
	cmp	ax, 0
	jl	l_returnZero

	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharActionTarget[bx], al
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_charAttackAction endp
