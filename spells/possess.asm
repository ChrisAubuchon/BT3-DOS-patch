; Attributes: bp-based frame

sp_possessChar proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	[bp+var_2], ax
	getCharP	[bp+var_2], si
	test	gs:roster.status[si], stat_dead
	jz	short loc_200CF
	and	gs:roster.status[si], stat_poisoned or stat_old	or stat_stoned or stat_paralyzed or stat_possessed or stat_nuts	or stat_unknown
	or	gs:roster.status[si], stat_possessed
	mov	gs:roster.currentHP[si], 100
loc_200CF:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_possessChar endp
