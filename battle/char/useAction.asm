; Attributes: bp-based frame

bat_charUseAction proc far

	var_F8=	word ptr -0F8h
	var_36=	word ptr -36h
	var_34=	word ptr -34h
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0F8h 
	call	someStackOperation
	lea	ax, [bp+var_34]
	push	ss
	push	ax
	lea	ax, [bp+var_F8]
	push	ss
	push	ax
	push	[bp+arg_0]
	call	inventory_getItemList
	add	sp, 0Ah
	mov	[bp+var_36], ax
	or	ax, ax
	jnz	short loc_1D570
	jmp	loc_1D643
loc_1D570:
	push	ax
	lea	ax, [bp+var_34]
	push	ss
	push	ax
	mov	ax, offset s_whichItem
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_1D58F
	sub	ax, ax
	jmp	loc_1D663
loc_1D58F:
	push	[bp+var_4]
	push	[bp+arg_0]
	call	inventory_canBeUsed
	add	sp, 4
	or	ax, ax
	jz	short loc_1D61F
	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+arg_0]
	mov	gs:g_batCharActionTarget[bx], al
	mov	al, byte ptr [bp+var_4]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42334[bx], al
	mov	bx, g_curSpellNumber
	mov	al, spellCastFlags[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+var_2], ax
	cmp	ax, 4
	jge	short loc_1D609
	mov	ax, offset s_nlUseOn
	push	ds
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr bat_charGetActionTarget
	add	sp, 6

	or	ax, ax
	jl	l_bat_useItem_opt_return_zero

	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
	mov	ax, 1
	jmp	short loc_1D605
	sub	ax, ax
loc_1D605:
	jmp	short loc_1D663
	jmp	short loc_1D618
loc_1D609:
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
loc_1D618:
	mov	ax, 1
	jmp	short loc_1D663
loc_1D61F:
	mov	ax, offset aYouCanTUseThatItem_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	IOWAIT
	call	text_clear
	sub	ax, ax
	jmp	short loc_1D663
loc_1D641:
	jmp	short loc_1D663
loc_1D643:
	mov	ax, offset s_pocketsAreEmpty
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printStringWClear
	add	sp, 4
	IOWAIT
l_bat_useItem_opt_return_zero:
	sub	ax, ax
	jmp	short $+2
loc_1D663:
	mov	sp, bp
	pop	bp
	retf
bat_charUseAction endp
