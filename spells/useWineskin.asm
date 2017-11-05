; Attributes: bp-based frame

; DWORD - var_102 & var_104

_sp_useWineskin	proc far

	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	spellCaster= word ptr	 6

	FUNC_ENTER(106h)
	push	si

	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemFlags[bx]
	shr	ax, 1
	shr	ax, 1
	and	ax, 7
	mov	[bp+var_106], ax
	PUSH_OFFSET(s_drinksAndFeels)
	PUSH_STACK_ADDRESS(var_100)
	STRCAT
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	bx, [bp+var_106]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (drinkStringList+2)[bx]
	push	word ptr drinkStringList[bx]
	push	dx
	push	ax
	STRCAT
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	PUSH_STACK_ADDRESS(var_100)
	PRINTSTRING
	cmp	[bp+var_106], 1
	jnz	short loc_2252F

	CHARINDEX(ax, STACKVAR(spellCaster), si)
	cmp	gs:party.class[si], class_bard
	jnz	short loc_2252F
	push	gs:party.level[si]
	CALL(_returnXor255, near)
	mov	gs:party.specAbil[si],	al
	jmp	short l_return
loc_2252F:
	mov	al, byte ptr [bp+spellCaster]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	[bp+spellCaster]
	CALL(_batchSpellCast, near)
l_return:
	pop	si
	FUNC_EXIT
	retf
_sp_useWineskin	endp
