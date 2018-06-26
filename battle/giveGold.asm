; Attributes: bp-based frame

bat_giveGold proc far

	partySize= word ptr	-8
	loopCounter= word ptr	-6
	goldAmount= dword ptr	-4
	totalGoldAmount= dword ptr	 6

	FUNC_ENTER(8)
	push	si

	CALL(party_getLastSlot)
	inc	ax
	mov	[bp+partySize], ax
	cmp	ax, 7
	jle	short loc_1EA5F

	sub	ax, ax
	cwd
	jmp	short l_return

loc_1EA5F:
	mov	ax, [bp+partySize]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(totalGoldAmount)
	CALL(__32bitDivide)
	mov	word ptr [bp+goldAmount], ax
	mov	word ptr [bp+goldAmount+2], dx

	mov	[bp+loopCounter], 0
l_giveLoop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	gs:party.class[si], class_illusion
	jnb	short l_giveNext

	mov	ax, word ptr [bp+goldAmount]
	mov	dx, word ptr [bp+goldAmount+2]
	add	word ptr gs:party.gold[si], ax
	adc	word ptr gs:(party.gold+2)[si], dx

l_giveNext:
	inc	[bp+loopCounter]
	mov	ax, [bp+partySize]
	cmp	[bp+loopCounter], ax
	jl	short l_giveLoop

loc_1EAAE:
	mov	ax, word ptr [bp+goldAmount]
	mov	dx, word ptr [bp+goldAmount+2]

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_giveGold endp
