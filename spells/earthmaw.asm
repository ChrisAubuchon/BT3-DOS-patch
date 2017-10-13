; Attributes: bp-based frame

sp_earthMaw proc far

	loopCounter= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	si

	push_ds_String	aAndTheEarthSwa
	push_ss_string	var_100
	std_call	_strcat, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx

	cmp	gs:bat_curTarget, 80h
	jnb	short l_monTarget

	; Kill all part members
	mov	[bp+loopCounter], 0
l_partyLoopEnter:
	getCharP	[bp+loopCounter], si
	or	gs:roster.status[si], stat_dead
	mov	gs:roster.currentHP[si], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_partyLoopEnter

	call	endNoncombatSong
	push_ds_string	aTheParty
	push_ss_string	var_100
	std_call	_strcat,8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	jmp	l_return

l_monTarget:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	si, ax
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Eh
	dec	ax
	push	ax
	push	si
	push	[bp+var_104]
	push	[bp+var_106]
	near_call	strcatTargetName,8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	[bp+var_102], ax
	getMonP	[bp+var_102], bx
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
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_earthMaw endp
