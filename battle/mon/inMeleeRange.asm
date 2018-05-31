; This function	returns	0 if there is a	monster
; group	in melee range.	1 otherwise. This is used
; to determine whether the party should	be given
; the "Advance"	option in battle.
; Attributes: bp-based frame

bat_monGroupInMeleeRange proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 3
	jmp	short loc_1D9D9
loc_1D9D6:
	dec	[bp+var_2]
loc_1D9D9:
	cmp	[bp+var_2], 0
	jl	short loc_1DA04
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1DA02
	mov	al, gs:monGroups.distance[si]
	and	al, 0Fh
	cmp	al, 2
	jnb	short loc_1DA02
	sub	ax, ax
	jmp	short loc_1DA09
loc_1DA02:
	jmp	short loc_1D9D6
loc_1DA04:
	mov	ax, 1
	jmp	short $+2
loc_1DA09:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monGroupInMeleeRange endp
