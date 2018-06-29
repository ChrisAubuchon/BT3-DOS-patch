; Attributes: bp-based frame

_sp_checkSPPT proc far

	requiredSppt= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(2)

	cmp	[bp+spellCaster], 80h
	jge	short l_returnOne

	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	CALL(getSpptRequired, near)
	mov	[bp+requiredSppt], ax
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	cmp	gs:party.currentSppt[bx], cx
	jb	short l_returnZero

	mov	ax, [bp+requiredSppt]
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	sub	gs:party.currentSppt[bx], cx
l_returnOne:
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	FUNC_EXIT
	retf
_sp_checkSPPT endp
