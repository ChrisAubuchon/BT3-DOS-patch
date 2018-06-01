; Attributes: bp-based frame

chest_disarm proc far

	var_2A=	word ptr -2Ah
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2Ah	
	call	someStackOperation
	push	si
	mov	ax, offset aWhoWillDisarmIt?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1F94E
	sub	ax, ax
	jmp	loc_1FA16
loc_1F94E:
	getCharP	[bp+var_2], bx
	test	gs:party.status[bx], 1Ch
	jz	short loc_1F967
	sub	ax, ax
	jmp	loc_1FA16
loc_1F967:
	mov	ax, offset aEnterTrapName
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 28h	
	push	ax
	lea	ax, [bp+var_2A]
	push	ss
	push	ax
	call	readString
	add	sp, 6
	mov	bx, gs:trapIndex
	mov	al, byte_47988[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapName+2)[bx]
	push	word ptr trapName[bx]
	lea	ax, [bp+var_2A]
	push	ss
	push	ax
	push	cs
	call	near ptr chest_trapStrcmp
	add	sp, 8
	or	ax, ax
	jz	short loc_1FA07
	getCharP	[bp+var_2], si
	cmp	gs:party.class[si], class_rogue
	jnz	short loc_1F9F4
	call	random
	cmp	gs:party.specAbil[si],	al
	jb	short loc_1F9F4
	mov	ax, offset aYouDisarmedIt
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	gs:trapIndex, 0
	mov	ax, 1
	jmp	short loc_1FA16
	jmp	short loc_1FA05
loc_1F9F4:
	mov	ax, offset aDisarmFailed
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short loc_1FA16
loc_1FA05:
	jmp	short loc_1FA11
loc_1FA07:
	push	[bp+var_2]
	push	cs
	call	near ptr chest_setOffTrap
	add	sp, 2
loc_1FA11:
	mov	ax, 1
	jmp	short $+2
loc_1FA16:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_disarm endp
