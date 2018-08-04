; Attributes: bp-based frame
;
; Returns:
;   0 - Party out of range
;   1 - Party in range
;   2 - Some spells have diminishing effects at double the range. Returned
;       if the party is in range of the diminishing effect
;

define(`DIMINISHING_EFFECT_FLAG', `80h')dnl
bat_isPartyInRange proc	far

	fullEffectRange= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	maxEffectRange= word ptr	-2
	source=	word ptr  6
	range= word ptr  8

	FUNC_ENTER(8)

	; Return success if party attack
	cmp	gs:bat_curTarget, 80h
	jnb	short l_notPartyAttack

	cmp	[bp+source], 80h
	jl	l_returnOne

l_notPartyAttack:
	test	byte ptr [bp+range], DIMINISHING_EFFECT_FLAG
	jz	short loc_22744

	mov	ax, [bp+range]
	and	ax, 7Fh
	mov	[bp+fullEffectRange], ax
	shl	ax, 1
	mov	[bp+maxEffectRange], ax
	jmp	short loc_2274F

loc_22744:
	mov	ax, [bp+range]
	mov	[bp+fullEffectRange], ax
	mov	[bp+maxEffectRange], 0

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
	mov	al, gs:g_monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_4], ax
	mov	ax, [bp+fullEffectRange]
	cmp	[bp+var_4], ax
	jle	l_returnOne

	mov	ax, [bp+maxEffectRange]
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
	FUNC_EXIT
	retf
bat_isPartyInRange endp
undefine(`DIMINISHING_EFFECT_FLAG')dnl
