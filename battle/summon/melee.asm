; Attributes: bp-based frame

bat_summonMelee proc far

	target= word ptr	-6
	slotP= dword ptr -4
	slotNumber= word ptr	 6
	attackType= word ptr	 8
	attackDamage= word ptr	 0Ah

	FUNC_ENTER(6)

	cmp	[bp+slotNumber], 4
	jge	short l_return

	CHARINDEX(ax, STACKVAR(slotNumber))
	add	ax, offset party
	mov	word ptr [bp+slotP], ax
	mov	word ptr [bp+slotP+2], seg seg027

	lfs	bx, [bp+slotP]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short l_targetEnemy

	mov	ax, 7
	push	ax
	CALL(bat_getRandomChar, near)
	jmp	short l_doMelee

l_targetEnemy:
	mov	ax, 80h				; 1st monster group

l_doMelee:
	mov	[bp+target], ax
	mov	ax, [bp+attackDamage]
	mov	gs:summonMeleeDamage, ax
	mov	ax, [bp+attackType]
	mov	gs:summonMeleeType, ax
	push	[bp+target]
	push	[bp+slotNumber]
	CALL(bat_charMelee, near)

l_return:
	FUNC_EXIT
	retf
bat_summonMelee endp
