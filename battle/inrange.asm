; Attributes: bp-based frame
bat_isPartyInRange proc	far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	source=	word ptr  6
	range= word ptr  8

	FUNC_ENTER(8)

	; Return success if party attack
	cmp	gs:bat_curTarget, 80h
	jnb	short l_notPartyAttack
	cmp	[bp+source], 80h
	jl	l_returnOne

l_notPartyAttack:
	test	byte ptr [bp+range], 80h
	jz	short loc_22744
	mov	ax, [bp+range]
	and	ax, 7Fh
	mov	[bp+var_8], ax
	shl	ax, 1
	mov	[bp+var_2], ax
	jmp	short loc_2274F
loc_22744:
	mov	ax, [bp+range]
	mov	[bp+var_8], ax
	mov	[bp+var_2], 0

loc_2274F:
	cmp	gs:bat_curTarget, 80h
	jb	short l_monSource
	mov	al, gs:bat_curTarget
	sub	ah, ah
	jmp	short l_checkDistance
l_monSource:
	mov	ax, [bp+source]
l_checkDistance:
	mov	[bp+var_6], ax
	and	ax, 3
	MONINDEX(cx, cx)
	mov	bx, ax
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_4], ax
	mov	ax, [bp+var_8]
	cmp	[bp+var_4], ax
	jle	l_returnOne

	mov	ax, [bp+var_2]
	cmp	[bp+var_4], ax
	jg	short loc_returnZero
	mov	ax, 2
	jmp	short l_return 
loc_returnZero:
	sub	ax, ax
	jmp	l_return
l_returnOne:
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
bat_isPartyInRange endp
