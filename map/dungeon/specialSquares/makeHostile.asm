; Attributes: bp-based frame

dunsq_monHostile proc far

	var_2= word ptr	-2

	FUNC_ENTER(2)

	mov	[bp+var_2], 0
l_checkEffectLoop:
	mov	ax, itemEff_calmMonster
	push	ax
	push	[bp+var_2]
	call	character_isEffectEquipped
	add	sp, 4
	or	ax, ax
	jz	short l_returnOne
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_checkEffectLoop

	mov	[bp+var_2], 0
l_makeHostileLoop:
	CHARINDEX(ax, STACKVAR(var_2), bx)
	cmp	gs:party.class[bx], class_monster

	; FIXED - Was jz. This activated the square when there were no monsters
	; in the party.
	jnz	short l_makeHostileNext

	CALL(random)
	test	al, 3
	jnz	short l_makeHostileNext
	CHARINDEX(ax, STACKVAR(var_2), bx)
	mov	gs:party.hostileFlag[bx], 1
	mov	byte_4EECC, 1

l_makeHostileNext:
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_makeHostileLoop

l_returnOne:
	mov	ax, 1
l_return:
	mov	ax, 7Fh
	push	ax
	mov	ax, 3
	push	ax
	push	g_sqEast
	push	g_sqNorth
	CALL(dun_maskSquare)

	FUNC_EXIT
	retf
dunsq_monHostile endp
