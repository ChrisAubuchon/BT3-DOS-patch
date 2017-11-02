
; Attributes: bp-based frame

; UNUSED - var_2 & var_4

_sp_useWeapon proc far

	var_10=	word ptr -10h
	var_E= byte ptr	-0Eh
	var_D= byte ptr	-0Dh
	var_C= byte ptr	-0Ch
	var_B= byte ptr	-0Bh
	var_A= byte ptr	-0Ah
	var_9= byte ptr	-9
	var_8= byte ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	spellCaster=	word ptr  6

	FUNC_ENTER
	CHKSTK(10h)
	push	di
	push	si

	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	mov	[bp+var_6], ax
	mov	[bp+var_10], 31
	jmp	short loc_2259F
loc_2259C:
	dec	[bp+var_10]
loc_2259F:
	cmp	[bp+var_10], 0
	jge	short loc_225A8
	jmp	loc_22632
loc_225A8:
	mov	bx, [bp+var_10]
	mov	al, byte_48382[bx]
	sub	ah, ah
	cmp	ax, [bp+var_6]
	jnz	short loc_2262F
	cmp	bx, 17h
	jge	short loc_225C0
	mov	ax, offset s_castsWeapon
	jmp	short loc_225C3
loc_225C0:
	mov	ax, offset s_breathes
loc_225C3:
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	push	ds
	push	ax
	PRINTSTRING
	mov	ax, [bp+var_10]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	si, ax
	mov	al, byte ptr weaponDamageList.effectStrIndex[si]
	mov	[bp+var_E], al
	mov	al, weaponDamageList.elements[si]
	mov	[bp+var_D], al
	mov	[bp+var_C], 10h
	mov	[bp+var_B], 0
	mov	al, weaponDamageList.repelFlags[si]
	mov	[bp+var_A], al
	mov	al, weaponDamageList.damage[si]
	mov	[bp+var_9], al
	mov	al, weaponDamageList.targetFlags[si]
	mov	[bp+var_8], al
	mov	al, weaponDamageList.levelMult[si]
	sub	ah, ah
	push	ax
	sub	sp, 8
	push	si
	lea	si, [bp+var_E]
	mov	di, sp
	add	di, 2
	push	ss
	pop	es
	assume es:nothing
	movsw
	movsw
	movsw
	movsb
	pop	si
	push	[bp+spellCaster]
	CALL(bat_doBreathAttack, near)
loc_2262F:
	jmp	loc_2259C
loc_22632:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
_sp_useWeapon endp
