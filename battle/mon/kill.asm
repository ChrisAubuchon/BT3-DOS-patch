; Attributes: bp-based frame

bat_monKill proc far

	mon= word ptr -2
	groupNo= word ptr  6
	monNo= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	ax, [bp+monNo]
	mov	[bp+mon], ax
	jmp	short loc_1E508
loc_1E505:
	inc	[bp+mon]
loc_1E508:
	getMonP	[bp+groupNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	cmp	ax, [bp+mon]
	jb	short loc_1E54F
	mov	si, [bp+groupNo]
	mov	cl, 6
	shl	si, cl
	mov	ax, [bp+mon]
	shl	ax, 1
	add	si, ax
	mov	ax, gs:(monHpList+2)[si]
	mov	gs:monHpList[si], ax
	mov	ax, gs:(bat_monPriorityList+2)[si]
	mov	gs:bat_monPriorityList[si], ax
	jmp	short loc_1E505
loc_1E54F:
	getMonP	[bp+groupNo], si
	dec	gs:monGroups.groupSize[si]
	test	gs:monGroups.groupSize[si], 1Fh
	jnz	short loc_1E56E
	and	gs:monGroups.flags[si],	0FEh
loc_1E56E:
	getMonP	[bp+groupNo], si
	mov	ah, gs:monGroups.rewardMid[si]
	sub	al, al
	mov	dl, gs:monGroups.rewardHi[si]
	sub	dh, dh
	mov	cl, 10h
	shl	dx, cl
	add	ax, dx
	mov	cl, gs:monGroups.rewardLo[si]
	sub	ch, ch
	add	ax, cx
	sub	dx, dx
	add	gs:batRewardLo,	ax
	adc	gs:batRewardHi,	dx
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monKill endp
