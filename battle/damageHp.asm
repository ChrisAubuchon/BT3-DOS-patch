; Attributes: bp-based frame

bat_damageHp proc far

	targetNumber= word ptr	 6

	FUNC_ENTER

	cmp	[bp+targetNumber], 80h
	jge	short l_monsterTarget

	push	[bp+targetNumber]
	CALL(bat_charDamageHp, near)
	jmp	short l_return

l_monsterTarget:
	mov	ax, [bp+targetNumber]
	and	ax, 7Fh
	push	ax
	CALL(bat_monDamageHp, near)

l_return:
	FUNC_EXIT
	retf
bat_damageHp endp

