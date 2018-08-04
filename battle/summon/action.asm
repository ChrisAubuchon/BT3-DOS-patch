; Attributes: bp-based frame
bat_summonAction proc	far

	var_C= word ptr	-0Ah
	attDamage= word	ptr -8h
	attType= word ptr -6
	slotP= dword ptr -4
	slotNumber=	word ptr  6

	FUNC_ENTER(0Ch)
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber))
	add	ax, offset party
	mov	word ptr [bp+slotP], ax
	mov	word ptr [bp+slotP+2], seg seg027

	lfs	bx, [bp+slotP]
	cmp	fs:[bx+summonStat_t.class], class_illusion
	jnz	short l_notIllusion

	cmp	gs:g_monsterDisbelieveFlag, 0
	jnz	l_return

l_notIllusion:
	CALL(random)
	and	ax, 6
	mov	si, ax
	lfs	bx, [bp+slotP]
	mov	al, fs:[bx+si+summonStat_t.attacks._type]
	sub	ah, ah
	mov	[bp+attType], ax
	mov	al, fs:[bx+si+summonStat_t.attacks.damage]
	mov	[bp+attDamage],	ax

	cmp	[bp+attType], 80h
	jge	short l_meleeCheck

	push	ax
	push	[bp+attType]
	push	[bp+slotNumber]
	CALL(bat_summonCast, near)
	jmp	short l_return

l_meleeCheck:
	mov	ax, [bp+attType]
	sub	ax, 0F0h
	and	ax, 7Fh
	mov	[bp+var_C], ax
	cmp	[bp+var_C], 0Ah
	jge	short loc_1BD1F
	push	[bp+attDamage]
	push	[bp+var_C]
	push	[bp+slotNumber]
	CALL(bat_summonMelee, near)
	jmp	short l_return

loc_1BD1F:
	mov	ax, [bp+var_C]
	cmp	ax, 10h
	jz	short l_breathe
	cmp	ax, 11h
	jz	short l_sing
	jmp	short l_return

l_breathe:
	push	[bp+attDamage]
	push	[bp+slotNumber]
	CALL(bat_summonBreathAttack, near)
	jmp	short l_return

l_sing:
	push	[bp+attDamage]
	push	[bp+slotNumber]
	CALL(bat_doCombatSong, near)

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_summonAction endp
