; Attributes: bp-based frame

party_applySpptRegen proc far

	loopCounter= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	test	gs:party.status[si], stat_dead	or stat_stoned
	jnz	short l_next

	mov	ax, gs:party.maxSppt[si]
	cmp	gs:party.currentSppt[si], ax
	jnb	short l_next

	inc	gs:party.currentSppt[si]
	mov	byte ptr g_printPartyFlag,	0

l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loop

l_return:
	pop	si
	FUNC_EXIT
	retf
party_applySpptRegen endp
