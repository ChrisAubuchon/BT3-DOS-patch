; Attributes: bp-based frame

_sp_useWineskin	proc far

	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 106h
	call	someStackOperation
	push	si
	getCharP	[bp+spellCaster], bx
	mov	al, gs:byte_4227E
	sub	ah, ah
	add	bx, ax
	mov	al, gs:roster.inventory.itemFlags[bx]
	shr	ax, 1
	shr	ax, 1
	and	ax, 7
	mov	[bp+var_106], ax
	mov	ax, offset aDrinksAndFeels
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	bx, [bp+var_106]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (drinkStringList+2)[bx]
	push	word ptr drinkStringList[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	cmp	[bp+var_106], 1
	jnz	short loc_2252F
	getCharP	[bp+spellCaster], si
	cmp	gs:roster.class[si], class_bard
	jnz	short loc_2252F
	push	gs:roster.level[si]
	near_call	_returnXor255,2
	mov	gs:roster.specAbil[si],	al
	jmp	short l_return
loc_2252F:
	mov	al, byte ptr [bp+spellCaster]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	[bp+spellCaster]
	near_call	_batchSpellCast,4
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_useWineskin	endp
