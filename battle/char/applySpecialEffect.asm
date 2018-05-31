; Attributes: bp-based frame

bat_charApplySpecialEffect proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	ax, gs:specialAttackVal
	jmp	loc_1E869
loc_1E68A:
	sub	ax, ax
	jmp	loc_1E88A
poisonChar:
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_poisoned
	mov	ax, 1
	jmp	loc_1E88A
levelDrainChar:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1E6C2
	sub	ax, ax
	jmp	loc_1E88A
	jmp	short loc_1E70E
loc_1E6C2:
	getCharP	[bp+charNo], bx
	cmp	gs:party.level[bx], 1
	jbe	short loc_1E6DF
	getCharP	[bp+charNo], bx
	dec	gs:party.level[bx]
loc_1E6DF:
	getCharP	[bp+charNo], si
	mov	ax, gs:party.level[si]
	dec	ax
	push	ax
	push	[bp+charNo]
	call	getLevelXp
	add	sp, 4
	cwd
	mov	word ptr gs:party.experience[si], ax
	mov	word ptr gs:(party.experience+2)[si], dx
	mov	ax, 1
	jmp	loc_1E88A
loc_1E70E:
	sub	ax, ax
	jmp	loc_1E88A
nutsifyChar:
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_nuts
	mov	ax, 1
	jmp	loc_1E88A
oldifyChar:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1E744
	sub	ax, ax
	jmp	loc_1E88A
loc_1E744:
	getCharP	[bp+charNo], bx
	test	gs:party.status[bx], stat_old
	jz	short loc_1E759
	sub	ax, ax
	jmp	loc_1E88A
loc_1E759:
	getCharP	[bp+charNo], si
	mov	ax, 5
	push	ax
	lea	ax, party.savedST[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.strength[si]
	push	dx
	push	ax
	push	cs
	call	near ptr character_applyAgeStatus
	add	sp, 0Ah
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_old
	mov	ax, 1
	jmp	loc_1E88A
possessChar:
	getCharP	[bp+charNo], si
	mov	gs:party.currentHP[si], 64h 
	and	gs:party.status[si], stat_poisoned or stat_old	or stat_stoned or stat_paralyzed or stat_possessed or stat_nuts	or stat_unknown
	or	gs:party.status[si], stat_possessed
	mov	ax, 1
	jmp	loc_1E88A
stoneChar:
	getCharP	[bp+charNo], si
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	or	gs:party.status[si], stat_stoned
	mov	ax, 1
	jmp	loc_1E88A
killChar:
	getCharP	[bp+charNo], si
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	mov	ax, 1
	jmp	loc_1E88A
loc_1E802:
	mov	[bp+var_4], 0
	jmp	short loc_1E80D
loc_1E809:
	add	[bp+var_4], 3
loc_1E80D:
	cmp	[bp+var_4], 24h	
	jge	short loc_1E846
	getCharP	[bp+charNo], si
	add	si, [bp+var_4]
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	cmp	itemTypeList[bx], 1
	jnz	short loc_1E844
	and	gs:party.inventory.itemFlags[si], 0FCh
loc_1E844:
	jmp	short loc_1E809
loc_1E846:
	mov	ax, 1
	jmp	short loc_1E88A
consumeSppt:
	getCharP	[bp+charNo], bx
	mov	gs:party.currentSppt[bx], 0
	mov	ax, 1
	jmp	short loc_1E88A
loc_1E863:
	sub	ax, ax
	jmp	short loc_1E88A
	jmp	short loc_1E88A
loc_1E869:
	cmp	ax, 9
	ja	short loc_1E863
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_1E876[bx]
off_1E876 dw offset loc_1E68A
dw offset poisonChar
dw offset levelDrainChar
dw offset nutsifyChar
dw offset oldifyChar
dw offset possessChar
dw offset stoneChar
dw offset killChar
dw offset loc_1E802
dw offset consumeSppt
loc_1E88A:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_charApplySpecialEffect endp
