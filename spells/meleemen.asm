; Attributes: bp-based frame

sp_meleeMen proc far

	stringBuffer=	word ptr -56h
	var_4= word ptr	-4
	var_2= word ptr	-2
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 56h	
	call	someStackOperation

	push	[bp+spellCaster]
	near_call spellSavingThrowHelper,2
	or	ax, ax
	jz	short l_return

	test	byte ptr [bp+spellCaster], 80h
	jz	short l_partyCaster
	mov	ax, 1
	push	ax
	mov	ax, [bp+spellCaster]
	and	ax, 3
	push	ax
	near_call	_sp_setMonDistance,4
	jmp	short l_printMessage
l_partyCaster:
	mov	ax, 1
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	push	ax
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
l_printMessage:
	mov	ax, offset aAndTheFoesAre
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	std_call	_strcat,8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, offset aCloser
	push	ds
	push	ax
	push	dx
	push	[bp+var_4]
	std_call	_strcat,8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	func_printString
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_meleeMen endp
