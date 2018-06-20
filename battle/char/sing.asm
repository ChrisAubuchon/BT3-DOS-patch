; Attributes: bp-based frame

bat_charSing proc far

	stringBufferP= dword ptr -108h
	stringBuffer= word ptr -102h
	canSingFlag= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(108h)

	mov	[bp+canSingFlag], 0
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	mov	ax, itemEff_freeSinging
	push	ax
	push	[bp+slotNumber]
	CALL(character_isEffectEquipped)
	or	ax, ax
	jnz	short loc_1C384

	mov	[bp+canSingFlag], 1
	jmp	short loc_1C3AA

loc_1C384:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.specAbil[bx],	0
	jz	short loc_1C3AA

	mov	[bp+canSingFlag], 1
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	dec	gs:party.specAbil[bx]

loc_1C3AA:
	cmp	[bp+canSingFlag], 0
	jz	short loc_1C3F4
	PUSH_OFFSET(s_plays)
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	bx, [bp+slotNumber]
	mov	al, gs:g_batCharActionTarget[bx]
	sub	ah, ah
	push	ax
	push	bx
	CALL(bat_doCombatSong)
	jmp	short l_return
loc_1C3F4:
	PUSH_OFFSET(s_lost)
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	mov	ax, 0
	push	ax
	mov	ax, 6
	push	ax
	push	[bp+slotNumber]
	push	dx
	push	word ptr [bp+stringBufferP]
	CALL(printCharPronoun)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	PUSH_OFFSET(s_voice)
	push	dx
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING

l_return:
	FUNC_EXIT
	retf
bat_charSing endp
