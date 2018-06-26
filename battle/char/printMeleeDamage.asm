; Attributes: bp-based frame
bat_charPrintMeleeDamage proc	far

	damageAmount= dword ptr	 6
	multiAttackFlag= word ptr  0Ah

	FUNC_ENTER

	cmp	[bp+multiAttackFlag], 1
	jg	short l_printMultiHit

	PUSH_OFFSET(s_andHitsFor)
	PUSH_STACK_DWORD(damageAmount)
	STRCAT(damageAmount)
	jmp	short l_printDamageAmount

l_printMultiHit:
	PUSH_OFFSET(s_andHits)
	PUSH_STACK_DWORD(damageAmount)
	STRCAT(damageAmount)

	sub	ax, ax
	push	ax
	mov	ax, [bp+multiAttackFlag]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(damageAmount)
	ITOA(damageAmount)

	PUSH_OFFSET(s_timesFor)
	PUSH_STACK_DWORD(damageAmount)
	STRCAT(damageAmount)

l_printDamageAmount:
	sub	ax, ax
	push	ax
	mov	ax, gs:g_damageAmount
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(damageAmount)
	ITOA(damageAmount)

	mov	ax, gs:g_damageAmount
	dec	ax
	push	ax
	PUSH_STACK_DWORD(damageAmount)
	PUSH_OFFSET(s_pointsOfDamage)
	PLURALIZE(damageAmount)

	FUNC_EXIT
	retf
bat_charPrintMeleeDamage endp
