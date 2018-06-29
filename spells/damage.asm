; Attributes: bp-based frame

sp_damageSpell proc far

	attP= word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	counter= word ptr -0Ah
	attStru= byte ptr -8
	partySlotNumber=	word ptr  6
	spellNumber= word ptr  8

	FUNC_ENTER(10h)
	push	di
	push	si

	mov	bx, [bp+spellNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+var_C], ax
	lea	ax, [bp+attStru]
	mov	[bp+attP], ax
	mov	[bp+var_E], ss
	mov	[bp+counter], 0
	jmp	short loc_20100
loc_200FD:
	inc	[bp+counter]
loc_20100:
	cmp	[bp+counter], 7
	jge	short loc_20118
	mov	si, [bp+var_C]
	mov	bx, [bp+counter]
	mov	al, byte ptr damageSpellData.effectStrIndex[bx+si]
	lfs	si, dword ptr [bp+attP]
	mov	fs:[bx+si], al
	jmp	short loc_200FD
loc_20118:
	mov	bx, [bp+spellNumber]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	push	ax
	sub	sp, 8
	lea	si, [bp+attStru]
	mov	di, sp
	push	ss
	pop	es
	movsw
	movsw
	movsw
	movsb
	push	[bp+partySlotNumber]
	CALL(bat_doBreathAttack, near)
	pop	si
	pop	di
	FUNC_EXIT
	retf
sp_damageSpell endp
