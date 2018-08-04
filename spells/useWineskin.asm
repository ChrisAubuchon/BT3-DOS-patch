; Attributes: bp-based frame

_sp_useWineskin	proc far

	fluidNumber= word ptr -106h
	stringBufferP= dword ptr -104h
	stringBuffer= word ptr -100h
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
	mov	[bp+fluidNumber], ax
	PUSH_OFFSET(s_drinksAndFeels)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	mov	bx, [bp+fluidNumber]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_drinkStringList+2)[bx]
	push	word ptr g_drinkStringList[bx]
	push	dx
	push	ax
	STRCAT(stringBufferP)

	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	cmp	[bp+fluidNumber], 1
	jnz	short l_quickFix

	CHARINDEX(ax, STACKVAR(spellCaster), si)
	cmp	gs:party.class[si], class_bard
	jnz	short l_quickFix

	push	gs:party.level[si]
	CALL(lib_maxFF, near)
	mov	gs:party.specAbil[si],	al
	jmp	short l_return

l_quickFix:
	mov	al, byte ptr [bp+spellCaster]
	mov	gs:bat_curTarget, al
	mov	ax, BITMASK(spell_quickFix, 80h)
	push	ax
	push	[bp+spellCaster]
	CALL(_batchSpellCast, near)

l_return:
	pop	si
	FUNC_EXIT
	retf
_sp_useWineskin	endp
