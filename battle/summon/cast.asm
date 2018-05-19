; Attributes: bp-based frame

bat_summonCast proc far

	target=	word ptr -6
	slotP= dword ptr -4
	slotNumber=	word ptr  6
	spellNumber= word ptr  8

	FUNC_ENTER(6)

	CHARINDEX(ax, STACKVAR(slotNumber))
	add	ax, offset party
	mov	word ptr [bp+slotP], ax
	mov	word ptr [bp+slotP+2], seg seg027
	mov	bx, [bp+spellNumber]
	test	spellCastFlags[bx], 20h
	jz	short l_checkHostile

	mov	ax, 7
	push	ax
	CALL(bat_getRandomChar, near)
	mov	[bp+target], ax
	jmp	short l_doCast

l_checkHostile:
	lfs	bx, [bp+slotP]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short l_targetEnemy
	mov	ax, 7
	push	ax
	CALL(bat_getRandomChar, near)
	jmp	short l_skipSelfTarget

l_targetEnemy:
	mov	ax, 80h				; Target is 1st monster group

l_skipSelfTarget:
	mov	[bp+target], ax
	mov	ax, [bp+slotNumber]
	cmp	[bp+target], ax
	jz	short l_return

l_doCast:
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	mov	ax, 1
	push	ax
	push	[bp+spellNumber]
	push	[bp+slotNumber]
	CALL(doCastSpell)

l_return:
	FUNC_EXIT
	retf
bat_summonCast endp
