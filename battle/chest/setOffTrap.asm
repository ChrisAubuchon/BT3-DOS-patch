; Attributes: bp-based frame

chest_setOffTrap proc far

	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	si
	mov	ax, offset aYouSetOffA
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, gs:trapIndex
	mov	al, byte_47988[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapName+2)[bx]
	push	word ptr trapName[bx]
	push	dx
	push	[bp+var_106]
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, gs:trapIndex
	mov	al, trapDice[bx]
	sub	ah, ah
	push	ax
	call	randomYdX
	add	sp, 2
	mov	[bp+var_108], ax
	mov	si, gs:trapIndex
	shl	si, 1
	mov	al, byte ptr stru_47938.lo[si]
	mov	gs:monGroups.breathSaveLo, al
	mov	al, stru_47938.hi[si]
	mov	gs:monGroups.breathSaveHi, al
	mov	bx, gs:trapIndex
	test	trapFlags[bx], 80h
	jz	short loc_1F7A6
	push	[bp+var_108]
	push	[bp+arg_0]
	push	cs
	call	near ptr chest_doTrap
	add	sp, 4
	jmp	short loc_1F7CA
loc_1F7A6:
	mov	[bp+var_102], 0
	jmp	short loc_1F7B2
loc_1F7AE:
	inc	[bp+var_102]
loc_1F7B2:
	cmp	[bp+var_102], 7
	jge	short loc_1F7CA
	push	[bp+var_108]
	push	[bp+var_102]
	push	cs
	call	near ptr chest_doTrap
	add	sp, 4
	jmp	short loc_1F7AE
loc_1F7CA:
	mov	gs:trapIndex, 0
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0
	wait4IO
	mov	ax, 1
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_setOffTrap endp
