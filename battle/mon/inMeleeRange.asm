; This function	returns	0 if there is a	monster
; group	in melee range.	1 otherwise. This is used
; to determine whether the party should	be given
; the "Advance"	option in battle.
; Attributes: bp-based frame

bat_monGroupInMeleeRange proc far

	loopCounter= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	[bp+loopCounter], 3

l_loop:
	MONINDEX(ax, STACKVAR(loopCounter), si)
	test	gs:g_monGroups.groupSize[si], 1Fh
	jz	short l_next
	mov	al, gs:g_monGroups.distance[si]
	and	al, 0Fh
	cmp	al, 2
	jnb	short l_next
	sub	ax, ax
	jmp	short l_return

l_next:
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jge	short l_loop

	mov	ax, 1

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_monGroupInMeleeRange endp
