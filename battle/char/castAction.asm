; Attributes: bp-based frame

bat_charCastAction proc far

	spellFlags= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)

	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	CALL(getSpellNumber)

	mov	[bp+spellFlags], ax
	or	ax, ax
	jl	l_returnZero

	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharActionTarget[bx], al
	cmp	[bp+spellFlags], 4
	jg	short l_untargettedSpell

	PUSH_OFFSET(s_castAt)
	push	[bp+spellFlags]
	CALL(bat_charGetActionOptionsTarget, near)
	or	ax,ax
	jl	l_returnZero

	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharSpellTarget[bx], al
	jmp	short l_returnOne

l_untargettedSpell:				; An untargetted spell has the spell flags
	mov	al, byte ptr [bp+spellFlags]	; in the target
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharSpellTarget[bx], al

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:	
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_charCastAction endp
