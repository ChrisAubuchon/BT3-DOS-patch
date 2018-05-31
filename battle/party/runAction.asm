; Attributes: bp-based frame

bat_partyRunAction proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	gs:songCanRun, 0
	jz	short loc_1D404
	mov	gs:runAwayFlag,	1
	mov	ax, 1
	jmp	short loc_1D46D
loc_1D404:
	mov	[bp+var_2], 0
	jmp	short loc_1D40E
loc_1D40B:
	inc	[bp+var_2]
loc_1D40E:
	cmp	[bp+var_2], 7
	jge	short loc_1D44C
	getCharP	[bp+var_2], bx
	cmp	byte ptr gs:party._name[bx], 0
	jz	short loc_1D44A
	mov	ax, itemEff_alwaysRunAway
	push	ax
	push	[bp+var_2]
	call	character_isEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1D44A
	mov	gs:runAwayFlag,	1
	mov	ax, 1
	jmp	short loc_1D46D
loc_1D44A:
	jmp	short loc_1D40B
loc_1D44C:
	call	random
	sub	ah, ah
	mov	[bp+var_2], ax
	cmp	ax, 0C0h 
	jg	short loc_1D45F
	mov	al, 1
	jmp	short loc_1D461
loc_1D45F:
	sub	al, al
loc_1D461:
	mov	gs:runAwayFlag,	al
	sub	ah, ah
	jmp	short $+2
loc_1D46D:
	mov	sp, bp
	pop	bp
	retf
bat_partyRunAction endp
