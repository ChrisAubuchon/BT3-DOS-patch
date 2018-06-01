; Attributes: bp-based frame

chest_examine proc far

	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 106h
	call	someStackOperation
	push	si
	mov	ax, offset aWhoWillExamineIt?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_106], ax
	or	ax, ax
	jge	short loc_1F5E8
	sub	ax, ax
	jmp	loc_1F6EE
loc_1F5E8:
	getCharP	[bp+var_106], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1F602
	sub	ax, ax
	jmp	loc_1F6EE
loc_1F602:
	mov	bx, [bp+var_106]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	test	gs:word_42298, ax
	jz	short loc_1F62E
	mov	ax, offset aThatCharacterHasAlr
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	loc_1F6EE
loc_1F62E:
	mov	bx, [bp+var_106]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	or	gs:word_42298, ax
	getCharP	bx, bx
	test	gs:party.status[bx], 1Ch
	jz	short loc_1F65E
	sub	ax, ax
	jmp	loc_1F6EE
loc_1F65E:
	getCharP	[bp+var_106], si
	cmp	gs:party.class[si], class_rogue
	jnz	short loc_1F67F
	call	random
	cmp	gs:(party.specAbil+1)[si], al
	jnb	short loc_1F690
loc_1F67F:
	mov	ax, offset aYouFoundNothing_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short loc_1F6EE
loc_1F690:
	mov	ax, offset aItLooksLikeA
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	bx, gs:trapIndex
	mov	al, byte_47988[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapName+2)[bx]
	push	word ptr trapName[bx]
	push	dx
	push	[bp+var_104]
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short $+2
loc_1F6EE:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_examine endp
