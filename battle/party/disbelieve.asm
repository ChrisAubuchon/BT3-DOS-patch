; Attributes: bp-based frame

bat_partyDisbelieves proc far

	groupNo= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+groupNo], 3
	jmp	short loc_1EAD1
loc_1EACE:
	dec	[bp+groupNo]
loc_1EAD1:
	cmp	[bp+groupNo], 0
	jge	short loc_1EADA
	jmp	loc_1EB64
loc_1EADA:
	getMonP	[bp+groupNo], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1EB61
	test	gs:monGroups.flags[si],	10h
	jz	short loc_1EB61
	mov	gs:bat_curTarget, 0
;	test	gs:byte_4240E, 81h
	test	gs:disbelieveFlags, disb_disruptill OR disb_disbelieve
	jnz	short loc_1EB20
	sub	ax, ax
	push	ax
	mov	ax, 80h
	push	ax
	call	savingThrowCheck
	add	sp, 4
	cmp	ax, 2
	jnz	short loc_1EB61
loc_1EB20:
	mov	gs:specialAttackVal, speAtt_stoning
	getMonP	[bp+groupNo], bx
	mov	gs:monGroups.groupSize[bx], 1
	push	[bp+groupNo]
	call	bat_monDamageHp
	add	sp, 2
	mov	ax, offset aThePartyDisbelieves_
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayWithTable
loc_1EB61:
	jmp	loc_1EACE
loc_1EB64:
	and	gs:disbelieveFlags, 0FEh
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_partyDisbelieves endp
