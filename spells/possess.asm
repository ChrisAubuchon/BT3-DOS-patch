; Attributes: bp-based frame

sp_possessChar proc far

	var_2= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	[bp+var_2], ax
	CHARINDEX(ax, STACKVAR(var_2), si)
	test	gs:party.status[si], stat_dead
	jz	short l_return
	and	gs:party.status[si], stat_poisoned or stat_old	or stat_stoned or stat_paralyzed or stat_possessed or stat_nuts	or stat_unknown
	or	gs:party.status[si], stat_possessed
	mov	gs:party.currentHP[si], 100
l_return:
	pop	si
	FUNC_EXIT
	retf
sp_possessChar endp
