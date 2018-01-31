; Attributes: bp-based frame

review_questAwardXp proc far

	slotNumber= word ptr	-2

	FUNC_ENTER(2)
	push	si

	PUSH_OFFSET(s_questAwardXp_1)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_questAwardXp_2)
	PRINTSTRING(wait)

	mov	[bp+slotNumber], 0
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	test	gs:party.status[si], 4
	jnz	short l_next
	mov	ax, word ptr gs:party.experience[si]
	mov	dx, word ptr gs:(party.experience+2)[si]
	add	ax, 27C0h
	adc	dx, 9

	; Comment out the maximum check for Xp. It sets Xp
	; to 16 million which is too low for a maximum.
;	push	dx
;	push	ax
;	push	cs
;	call	near ptr lib_maxFFFFFF
;	add	sp, 4

	mov	word ptr gs:party.experience[si], ax
	mov	word ptr gs:(party.experience+2)[si], dx
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	ax, gs:party.maxSppt[si]
	mov	gs:party.currentSppt[si], ax

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	mov	byte ptr g_printPartyFlag,	0
	pop	si
	FUNC_EXIT
	retf
review_questAwardXp endp
