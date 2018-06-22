; Attributes: bp-based frame
bat_giveExperience proc	far

	rostSize= word ptr -8
	loopCounter= word ptr	-6
	xpPerCharacter= dword ptr	-4
	totalXp= dword ptr	 6

	FUNC_ENTER(8)
	push	si

	CALL(party_getLastSlot)
	inc	ax
	mov	[bp+rostSize], ax
	cmp	ax, 7
	jg	l_returnZero

	mov	ax, [bp+rostSize]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+totalXp+2]
	push	word ptr [bp+totalXp]
	CALL(__32bitDivide)
	mov	word ptr [bp+xpPerCharacter], ax
	mov	word ptr [bp+xpPerCharacter+2], dx

	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	mov	ax, word ptr [bp+xpPerCharacter]
	mov	dx, word ptr [bp+xpPerCharacter+2]
	add	word ptr gs:party.experience[si], ax
	adc	word ptr gs:(party.experience+2)[si], dx

l_next:
	inc	[bp+loopCounter]
	mov	ax, [bp+rostSize]
	cmp	[bp+loopCounter], ax
	jl	short l_loop

	mov	ax, word ptr [bp+xpPerCharacter]
	mov	dx, word ptr [bp+xpPerCharacter+2]
	jmp	short l_return

l_returnZero:
	sub	ax, ax
	cwd

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_giveExperience endp
