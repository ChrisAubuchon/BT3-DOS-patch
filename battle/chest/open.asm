; Attributes: bp-based frame
chest_open proc	far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aWhoWillOpenIt?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1F8B8
	sub	ax, ax
	jmp	short loc_1F920
loc_1F8B8:
	getCharP	[bp+var_2], bx
	test	gs:party.status[bx], 7Ch
	jz	short loc_1F8D0
	sub	ax, ax
	jmp	short loc_1F920
loc_1F8D0:
	getCharP	[bp+var_2], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1F8E4
	sub	ax, ax
	jmp	short loc_1F920
loc_1F8E4:
	call	random
	test	al, 80h
	jz	short loc_1F8F9
	push	[bp+var_2]
	push	cs
	call	near ptr chest_setOffTrap
	add	sp, 2
	jmp	short loc_1F90F
loc_1F8F9:
	mov	gs:trapIndex, 0
	mov	gs:word_42560, 1
loc_1F90F:
	delayNoTable	5
	mov	ax, 1
	jmp	short $+2
loc_1F920:
	mov	sp, bp
	pop	bp
	retf
chest_open endp

