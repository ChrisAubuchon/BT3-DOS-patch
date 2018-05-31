; Attributes: bp-based frame

bat_charGetActionTarget proc far

	var_228= byte ptr -228h
	var_11E= byte ptr -11Eh
	var_11C= word ptr -11Ch
	var_11A= byte ptr -11Ah
	var_119= byte ptr -119h
	var_10E= word ptr -10Eh
	var_E= word ptr	-0Eh
	var_C= dword ptr -0Ch
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	stringOff= word	ptr  8
	stringSeg= word	ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 11Eh
	call	someStackOperation
	push	si
	mov	ax, 0FFFFh
	mov	[bp+var_8], ax
	mov	[bp+var_2], ax
	mov	[bp+var_6], 0
	mov	[bp+var_11C], 0
	jmp	short loc_1DB0E
loc_1DB0A:
	inc	[bp+var_11C]
loc_1DB0E:
	cmp	[bp+var_11C], 0Ch
	jge	short loc_1DB20
	mov	si, [bp+var_11C]
	mov	[bp+si+var_11A], 20h 
	jmp	short loc_1DB0A
loc_1DB20:
	push	[bp+stringSeg]
	push	[bp+stringOff]
	call	printStringWClear
	add	sp, 4
	mov	ax, [bp+arg_0]
	jmp	loc_1DD02
loc_1DB34:
	call	party_findEmptySlot
	mov	[bp+var_8], ax
	cmp	ax, 1
	jg	short loc_1DB46
	sub	ax, ax
	jmp	loc_1DD93
loc_1DB46:
	mov	al, byte ptr [bp+var_8]
	add	al, monStruSize
	mov	byte ptr aMember17+0Bh,	al
	mov	ax, offset aMember17
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+var_4], 2000h
	jmp	loc_1DD20
loc_1DB63:
	push	cs
	call	near ptr bat_monGroupCount
	mov	[bp+var_2], ax
	cmp	ax, 1
	jg	short loc_1DB75
	mov	ax, 80h
	jmp	loc_1DD93
loc_1DB75:
	mov	[bp+var_4], 0
	mov	[bp+var_11C], 0
	jmp	short loc_1DB86
loc_1DB82:
	inc	[bp+var_11C]
loc_1DB86:
	mov	ax, [bp+var_2]
	cmp	[bp+var_11C], ax
	jge	short loc_1DC09
	lea	ax, [bp+var_10E]
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], ss
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	bx, si
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+var_4], ax
	mov	al, byte ptr [bp+var_11C]
	add	al, 41h	
	mov	[bp+var_11E], al
	mov	[bp+si+var_119], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	al, [bp+var_11E]
	mov	fs:[bx], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 29h
	push	[bp+var_11C]
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	push	cs
	call	near ptr bat_monPrintGroup
	add	sp, 6
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	lfs	bx, [bp+var_C]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10E]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1DB82
loc_1DC09:
	jmp	loc_1DD20
loc_1DC0C:
	call	party_findEmptySlot
	mov	[bp+var_8], ax
	push	cs
	call	near ptr bat_monGroupCount
	mov	[bp+var_2], ax
	mov	[bp+var_4], 2000h
	mov	[bp+var_11C], 0
	jmp	short loc_1DC2C
loc_1DC28:
	inc	[bp+var_11C]
loc_1DC2C:
	mov	ax, [bp+var_2]
	cmp	[bp+var_11C], ax
	jge	short loc_1DCAF
	lea	ax, [bp+var_10E]
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], ss
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	bx, si
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+var_4], ax
	mov	al, byte ptr [bp+var_11C]
	add	al, 41h	
	mov	[bp+var_11E], al
	mov	[bp+si+var_119], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	al, [bp+var_11E]
	mov	fs:[bx], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 29h
	push	[bp+var_11C]
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	push	cs
	call	near ptr bat_monPrintGroup
	add	sp, 6
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	lfs	bx, [bp+var_C]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10E]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1DC28
loc_1DCAF:
	cmp	[bp+var_2], 0
	jz	short loc_1DCCE
	mov	ax, offset aOr
	push	ds
	push	ax
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
loc_1DCCE:
	cmp	[bp+var_8], 1
	jle	short loc_1DCEB
	mov	al, byte ptr [bp+var_8]
	add	al, monStruSize
	mov	byte ptr aMember17+0Bh,	al
	mov	ax, offset aMember17
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_1DCF8
loc_1DCEB:
	mov	ax, offset aMember1
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_1DCF8:
	jmp	short loc_1DD20
loc_1DCFA:
	mov	ax, 80h
	jmp	loc_1DD93
	jmp	short loc_1DD20
loc_1DD02:
	or	ax, ax
	jl	short loc_1DCFA
	cmp	ax, target_partyMember
	jg	short loc_1DD0E
	jmp	loc_1DB34
loc_1DD0E:
	cmp	ax, 2
	jnz	short loc_1DD16
	jmp	loc_1DB63
loc_1DD16:
	cmp	ax, 3
	jnz	short loc_1DD1E
	jmp	loc_1DC0C
loc_1DD1E:
	jmp	short loc_1DCFA
loc_1DD20:
	push	[bp+var_4]
	call	getKey
	add	sp, 2
	mov	[bp+var_E], ax
	cmp	ax, 10Eh
	jl	short loc_1DD43
	cmp	ax, 119h
	jg	short loc_1DD43
	mov	si, ax
	mov	al, [bp+si+var_228]
	sub	ah, ah
	mov	[bp+var_E], ax
loc_1DD43:
	cmp	[bp+var_6], 0
	jz	short loc_1DD54
	cmp	[bp+var_E], 1Bh
	jnz	short loc_1DD54
	mov	ax, 0FFFFh
	jmp	short loc_1DD93
loc_1DD54:
	cmp	[bp+var_E], 30h	
	jle	short loc_1DD6D
	mov	ax, [bp+var_8]
	add	ax, 31h	
	cmp	ax, [bp+var_E]
	jle	short loc_1DD6D
	mov	ax, [bp+var_E]
	sub	ax, 31h	
	jmp	short loc_1DD93
loc_1DD6D:
	cmp	[bp+var_E], 41h	
	jl	short loc_1DD86
	mov	ax, [bp+var_2]
	add	ax, 41h	
	cmp	ax, [bp+var_E]
	jle	short loc_1DD86
	mov	ax, [bp+var_E]
	add	ax, 3Fh	
	jmp	short loc_1DD93
loc_1DD86:
	cmp	[bp+var_E], 1Bh
	jnz	short loc_1DD91
	mov	ax, 0FFFFh
	jmp	short loc_1DD93
loc_1DD91:
	jmp	short loc_1DD20
loc_1DD93:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_charGetActionTarget endp
