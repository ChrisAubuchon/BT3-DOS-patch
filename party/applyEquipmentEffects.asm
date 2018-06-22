; Attributes: bp-based frame

party_applyEquipmentEffects proc far

	loopCounter= word ptr	-4
	regenAmount= word ptr	-2

	FUNC_ENTER(4)
	push	si

	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	test	gs:party.status[bx], stat_dead or stat_stoned
	jnz	l_next

	mov	[bp+regenAmount], 0
	mov	ax, itemEff_anotherSpptRegen
	push	ax
	push	[bp+loopCounter]
	CALL(character_isEffectEquipped)
	or	ax, ax
	jnz	short l_checkRegenSppt
	inc	[bp+regenAmount]

l_checkRegenSppt:
	mov	ax, itemEff_regenSppt
	push	ax
	push	[bp+loopCounter]
	CALL(character_isEffectEquipped)
	or	ax, ax
	jnz	short l_doSpptRegen
	inc	[bp+regenAmount]

l_doSpptRegen:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	mov	ax, [bp+regenAmount]
	add	gs:party.currentSppt[si], ax
	mov	ax, gs:party.maxSppt[si]
	cmp	gs:party.currentSppt[si], ax
	jbe	short l_checkForBringaround
	mov	gs:party.currentSppt[si], ax

l_checkForBringaround:
	cmp	gs:g_currentSongPlusOne, 0
	jz	short l_checkForHpRegenEquipped

	cmp	gs:g_currentSong, song_bringaround
	jnz	short l_checkForHpRegenEquipped

	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+loopCounter]
	jz	short l_doRegenHp

l_checkForHpRegenEquipped:
	mov	ax, itemEff_regenHP
	push	ax
	push	[bp+loopCounter]
	CALL(character_isEffectEquipped)
	or	ax, ax
	jnz	short l_next

l_doRegenHp:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	inc	gs:party.currentHP[si]
	mov	ax, gs:party.maxHP[si]
	cmp	gs:party.currentHP[si], ax
	jbe	short l_next
	mov	gs:party.currentHP[si], ax

l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_loop

l_return:
	mov	byte ptr g_printPartyFlag,	0
	pop	si
	FUNC_EXIT
	retf
party_applyEquipmentEffects endp
