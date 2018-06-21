; Attributes: bp-based frame

party_applyEquipmentEffects proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER(4)
	push	si
	mov	[bp+var_4], 0
	jmp	short loc_1EC81
loc_1EC7E:
	inc	[bp+var_4]
loc_1EC81:
	cmp	[bp+var_4], 7
	jl	short loc_1EC8A
	jmp	loc_1ED56
loc_1EC8A:
	CHARINDEX(ax, STACKVAR(var_4), bx)
	test	gs:party.status[bx], 0Ch
	jz	short loc_1ECA1
	jmp	loc_1ED53
loc_1ECA1:
	mov	[bp+var_2], 0
	mov	ax, itemEff_anotherSpptRegen
	push	ax
	push	[bp+var_4]
	call	character_isEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1ECBC
	inc	[bp+var_2]
loc_1ECBC:
	mov	ax, itemEff_regenSppt
	push	ax
	push	[bp+var_4]
	call	character_isEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1ECD2
	inc	[bp+var_2]
loc_1ECD2:
	CHARINDEX(ax, STACKVAR(var_4), si)
	mov	ax, [bp+var_2]
	add	gs:party.currentSppt[si], ax
	mov	ax, gs:party.maxSppt[si]
	cmp	gs:party.currentSppt[si], ax
	jbe	short loc_1ECF7
	mov	gs:party.currentSppt[si], ax
loc_1ECF7:
	cmp	gs:g_currentSongPlusOne, 0
	jz	short loc_1ED1E
	cmp	gs:g_currentSong, 3
	jnz	short loc_1ED1E
	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+var_4]
	jz	short loc_1ED31
loc_1ED1E:
	mov	ax, itemEff_regenHP
	push	ax
	push	[bp+var_4]
	call	character_isEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1ED53
loc_1ED31:
	CHARINDEX(ax, STACKVAR(var_4), si)
	inc	gs:party.currentHP[si]
	mov	ax, gs:party.maxHP[si]
	cmp	gs:party.currentHP[si], ax
	jbe	short loc_1ED53
	mov	gs:party.currentHP[si], ax
loc_1ED53:
	jmp	loc_1EC7E
loc_1ED56:
	mov	byte ptr g_printPartyFlag,	0
	pop	si
	FUNC_EXIT
	retf
party_applyEquipmentEffects endp
