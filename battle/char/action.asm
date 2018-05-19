; Attributes: bp-based frame

bat_charAction proc far

	slotNumber=	word ptr  6

	FUNC_ENTER

	mov	bx, [bp+slotNumber]
	mov	gs:bat_charPriority[bx], 0
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jb	short l_actionSwitch

	push	[bp+slotNumber]
	CALL(bat_summonAction)
	jmp	l_return

l_actionSwitch:
	mov	bx, [bp+slotNumber]
	mov	al, gs:g_charActionList[bx]
	sub	ah, ah
	sub	ax, 1
	cmp	ax, 7
	ja	l_return
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_1B3EA[bx]

off_1B3EA dw offset l_attack		; Attack
	  dw offset l_return		; Defend
	  dw offset l_attack		; Party attack
	  dw offset l_cast		; Cast
	  dw offset l_use		; Use
	  dw offset l_hide		; Hide
	  dw offset l_sing		; Song
	  dw offset l_possessed		; Possessed action

l_attack:
	mov	bx, [bp+slotNumber]
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	push	bx
	CALL(bat_charMelee, near)
	jmp	short l_return

l_cast:
	push	[bp+slotNumber]
	CALL(bat_charCast, near)
	jmp	short l_return

l_use:
	push	[bp+slotNumber]
	CALL(bat_charUse, near)
	jmp	short l_return

l_hide:
	push	[bp+slotNumber]
	CALL(bat_charHide, near)
	jmp	short l_return

l_sing:
	push	[bp+slotNumber]
	CALL(bat_charSing, near)
	jmp	short l_return

l_possessed:
	push	[bp+slotNumber]
	CALL(bat_charPossessedAttack, near)

l_return:
	FUNC_EXIT
	retf
bat_charAction endp
