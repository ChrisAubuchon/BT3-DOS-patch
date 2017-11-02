; Attributes: bp-based frame

; DWORD var_104 & var_106

sp_earthMaw proc far

	loopCounter= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	FUNC_ENTER
	CHKSTK(108h)
	push	si

	PUSH_OFFSET(s_earthSwallows)
	PUSH_STACK_ADDRESS(var_100)
	STRCAT
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx

	cmp	gs:bat_curTarget, 80h
	jnb	short l_monTarget

	; Kill all party members
	mov	[bp+loopCounter], 0
l_partyLoopEnter:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_partyLoopEnter

	CALL(endNoncombatSong)
	PUSH_OFFSET(s_theParty)
	PUSH_STACK_ADDRESS(var_100)
	STRCAT
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	jmp	l_return

l_monTarget:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	si, ax
	and	ax, 3
	MONINDEX(cx, cx, bx)
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Eh
	dec	ax
	push	ax
	push	si
	push	[bp+var_104]
	push	[bp+var_106]
	CALL(strcatTargetName, near)
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	[bp+var_102], ax
	MONINDEX(ax, STACKVAR(var_102), bx)
	and	gs:monGroups.groupSize[bx], 0E0h
	mov	[bp+loopCounter], 0
l_monLoopEnter:
	jge	short l_return
	mov	bx, [bp+var_102]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+loopCounter]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 32
	jl	short l_monLoopEnter
l_return:
	PUSH_STACK_ADDRESS(var_100)
	PRINTSTRING
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_earthMaw endp
