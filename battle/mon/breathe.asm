; Attributes: bp-based frame

bat_monBreathe proc far

	argumentsP= dword ptr -114h
	loopCounter= word ptr -110h
	arguments= word ptr -10Eh
	var_10C= byte ptr -10Ch
	var_10A= byte ptr -10Ah
	target=	word ptr -106h
	stringBufferP= dword ptr -104h
	stringBuffer= word ptr -100h
	slotNumber= word ptr	 6
	arg_4= byte ptr	 0Ah

	FUNC_ENTER(114h)
	push	di
	push	si

	push	[bp+slotNumber]
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(bat_monGetName, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	mov	ax, 7
	push	ax
	CALL(bat_getRandomChar, near)
	mov	[bp+target], ax
	lea	ax, [bp+arguments]
	mov	word ptr [bp+argumentsP], ax
	mov	word ptr [bp+argumentsP+2], ss

	mov	[bp+loopCounter], 0
l_loop:
	mov	bx, [bp+loopCounter]
	mov	al, byte ptr breathAttack.specialAttack[bx]
	lfs	si, [bp+argumentsP]
	mov	fs:[bx+si], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loop

	MONINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:g_monGroups.breathFlag[bx]
	mov	[bp+var_10C], al
	sub	ah, ah
	xor	al, 0Ah
	push	ax
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	PUSH_OFFSET(s_firesBreathes)
	PLURALIZE(stringBufferP)

	NULL_TERMINATE(STACKVAR(stringBufferP))

	mov	al, [bp+arg_4]
	mov	[bp+var_10A], al
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	MONINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:g_monGroups.breathRange[bx]
	sub	ah, ah
	push	ax
	sub	sp, 8
	lea	si, [bp+arguments]
	mov	di, sp
	push	ss
	pop	es
	assume es:nothing
	movsw
	movsw
	movsw
	movsb
	push	[bp+slotNumber]
	CALL(bat_doBreathAttack)

	pop	si
	pop	di
	FUNC_EXIT
	retf
bat_monBreathe endp
