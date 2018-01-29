; Attributes: bp-based frame

convertSpellLevel proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	spLevel= word ptr  8

	FUNC_ENTER(4)

	cmp	[bp+spLevel], 0
	jz	short l_return
	mov	bx, [bp+arg_0]
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	cmp	ax, 0FFh
	jz	short l_return
	mov	[bp+var_4], 0
loc_26AB8:
	mov	ax, [bp+spLevel]
	cmp	[bp+var_4], ax
	jge	short l_return
	push	[bp+var_2]
	push	[bp+var_4]
	mov	ax, 7
	push	ax
	CALL(mage_learnSpellLevel)
	inc	[bp+var_4]
	jmp	short loc_26AB8
l_return:
	FUNC_EXIT
	retf
convertSpellLevel endp
