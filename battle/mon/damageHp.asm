; Attributes: bp-based frame

bat_monDamageHp proc far

	loopCounter= word ptr	-4
	groupSize= word	ptr -2
	slotNumber= word ptr  6

	FUNC_ENTER(4)

	MONINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:g_monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize],	ax
	or	ax, ax
	jz	short l_returnZero

	mov	[bp+loopCounter], 0
l_findUnhitMonsterLoop:
	mov	ax, [bp+groupSize]
	cmp	[bp+loopCounter], ax
	jge	short l_markAllAsUnhit
	mov	bx, [bp+slotNumber]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+loopCounter]
	shl	ax, 1
	add	bx, ax
	test	byte ptr gs:bat_monBeenHitList[bx], 1
	jz	short l_fundUnhitMonsterNext

	push	[bp+loopCounter]
	push	[bp+slotNumber]
	CALL(bat_monApplySpecialEffect, near)
	jmp	short l_return

l_fundUnhitMonsterNext:
	inc	[bp+loopCounter]
	jmp	short l_findUnhitMonsterLoop

l_markAllAsUnhit:
	mov	[bp+loopCounter], 0
l_loop:
	mov	ax, [bp+groupSize]
	cmp	[bp+loopCounter], ax
	jge	short l_applyEffect
	mov	bx, [bp+slotNumber]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+loopCounter]
	shl	ax, 1
	add	bx, ax
	or	byte ptr gs:bat_monBeenHitList[bx], 1
	inc	[bp+loopCounter]
	jmp	short l_loop

l_applyEffect:
	sub	ax, ax
	push	ax
	push	[bp+slotNumber]
	CALL(bat_monApplySpecialEffect, near)
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_monDamageHp endp

