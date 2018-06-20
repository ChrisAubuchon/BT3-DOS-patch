; Attributes: bp-based frame

bat_charCastAction proc far

	var_2= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)

	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	CALL(getSpellNumber)

	mov	[bp+var_2], ax
	or	ax, ax
	jl	l_returnZero

	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharActionTarget[bx], al
	cmp	[bp+var_2], 4
	jg	short loc_1D52D

	mov	ax, offset s_castAt
	push	ds
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr bat_charGetActionTarget
	add	sp, 6
	or	ax,ax
	jge	l_bat_charCastAction_gotTarget

	mov	ax, 0				; Return 0 if no target selected.
	jmp	l_return

l_bat_charCastAction_gotTarget:
	mov	bx, [bp+slotNumber]
	mov	gs:byte_42276[bx], al
	mov	ax, 1
	jmp	short l_return

loc_1D52D:
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+slotNumber]
	mov	gs:byte_42276[bx], al

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:	
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_charCastAction endp
