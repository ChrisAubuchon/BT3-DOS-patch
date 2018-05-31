; Attributes: bp-based frame
bat_partyApplyPoison proc	far

	charNo=	word ptr -4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	bl, g_levelNumber
	sub	bh, bh
	mov	al, poisonDmg[bx]
	cbw
	mov	[bp+var_2], ax
	mov	[bp+charNo], 0
	jmp	short loc_1EC19
loc_1EC16:
	inc	[bp+charNo]
loc_1EC19:
	cmp	[bp+charNo], 7
	jge	short loc_1EC66
	getCharP	[bp+charNo], si
	test	gs:party.status[si], stat_poisoned
	jz	short loc_1EC64
	mov	ax, [bp+var_2]
	cmp	gs:party.currentHP[si], ax
	ja	short loc_1EC52
	and	gs:party.status[si], 0FEh
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	jmp	short loc_1EC64
loc_1EC52:
	mov	ax, [bp+var_2]
	mov	cx, ax
	getCharP	[bp+charNo], bx
	sub	gs:party.currentHP[bx], cx
loc_1EC64:
	jmp	short loc_1EC16
loc_1EC66:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_partyApplyPoison endp
