; Attributes: bp-based frame

bat_partyGetActions proc far

	charNo=	word ptr -138h
	var_136= word ptr -136h
	var_36=	word ptr -36h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_6= word ptr	-6
	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 138h
	call	someStackOperation
	push	si
	cmp	g_partyAttackFlag, 0
	jz	short loc_1D720
	jmp	loc_1D7BE
loc_1D720:
	call	bat_isAMonGroupActive
	or	ax, ax
	jnz	short loc_1D72C
	jmp	loc_1D7BE
loc_1D72C:
	call	_return_zero
	or	ax, ax
	jz	short loc_1D738
	jmp	loc_1D7BE
loc_1D738:
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_partyCanAdvance
	add	sp, 4
	lea	ax, [bp+var_36]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	mov	ax, offset aWillYourGallantBand
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_14], ax
loc_1D763:
	mov	[bp+var_22], 1
	push	[bp+var_14]
	call	getKey
	add	sp, 2
	mov	[bp+var_6], ax
	mov	[bp+var_16], 0
loc_1D77B:
	mov	si, [bp+var_16]
	cmp	byte ptr [bp+si+var_20], 0
	jz	short loc_1D7B8
	mov	al, byte ptr [bp+si+var_20]
	cbw
	cmp	ax, [bp+var_6]
	jz	short loc_1D797
	shl	si, 1
	mov	ax, [bp+var_6]
	cmp	[bp+si+var_36],	ax
	jnz	short loc_1D7B3
loc_1D797:
	mov	bx, [bp+var_16]
	shl	bx, 1
	shl	bx, 1
	call	off_475D0[bx]
	mov	[bp+var_12], ax
	or	ax, ax
	jz	short loc_1D7AE
	jmp	loc_1D996
	jmp	short loc_1D7B3
loc_1D7AE:
	mov	[bp+var_22], 0
loc_1D7B3:
	inc	[bp+var_16]
	jmp	short loc_1D77B
loc_1D7B8:
	cmp	[bp+var_22], 0
	jnz	short loc_1D763
loc_1D7BE:
	mov	[bp+charNo], 0
	jmp	short loc_1D7CA
loc_1D7C6:
	inc	[bp+charNo]
loc_1D7CA:
	cmp	[bp+charNo], 7
	jl	short loc_1D7D4
	jmp	loc_1D97D
loc_1D7D4:
	getCharP	[bp+charNo], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1D7EC
	jmp	loc_1D97D
loc_1D7EC:
	call	text_clear
	getCharP	[bp+charNo], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1D809
	jmp	loc_1D97A
loc_1D809:
	test	gs:party.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_1D814
	jmp	loc_1D97A
loc_1D814:
	test	gs:party.status[si], stat_possessed or	stat_nuts
	jz	short loc_1D827
	cmp	gs:(party.specAbil+3)[si], 0
	jz	short loc_1D827
	jmp	loc_1D96C
loc_1D827:
	call	text_clear
	getCharP	[bp+charNo], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_136]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	ax, offset aHasTheseOptionsThisBa
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_4]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	bx, [bp+charNo]
	cmp	gs:g_characterMeleeDistance[bx], 0
	jz	short loc_1D89A
	mov	al, gs:g_characterMeleeDistance[bx]
	add	al, '1'
	mov	byte_4724A, al
	mov	ax, offset byte_4724A
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_4]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
loc_1D89A:
	mov	ax, offset a@defend@partyAttack@c
	push	ds
	push	ax
	push	word ptr [bp+var_4+2]
	push	word ptr [bp+var_4]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	byte ptr fs:[bx], 0
	push	[bp+charNo]
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_charGetAction
	add	sp, 6
	lea	ax, [bp+var_36]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	lea	ax, [bp+var_136]
	push	ss
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_14], ax
	mov	ax, offset aSelectAnOption_
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+var_22], 1
	push	[bp+var_14]
	call	getKey
	add	sp, 2
	mov	[bp+var_6], ax
	mov	[bp+var_16], 0
loc_1D912:
	mov	si, [bp+var_16]
	cmp	byte ptr [bp+si+var_20], 0
	jz	short loc_1D961
	mov	al, byte ptr [bp+si+var_20]
	cbw
	cmp	ax, [bp+var_6]
	jz	short loc_1D92E
	shl	si, 1
	mov	ax, [bp+var_6]
	cmp	[bp+si+var_36],	ax
	jnz	short loc_1D95C
loc_1D92E:
	mov	al, byte ptr [bp+var_16]
	inc	al
	mov	bx, [bp+charNo]
	mov	gs:g_charActionList[bx], al
	push	[bp+charNo]
	mov	bx, [bp+var_16]
	shl	bx, 1
	shl	bx, 1
	call	off_475DC[bx]
	add	sp, 2
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	mov	[bp+var_22], cx
loc_1D95C:
	inc	[bp+var_16]
	jmp	short loc_1D912
loc_1D961:
	cmp	[bp+var_22], 0
	jz	short loc_1D96A
	jmp	loc_1D827
loc_1D96A:
	jmp	short loc_1D97A
loc_1D96C:
	mov	bx, [bp+charNo]
	mov	gs:g_charActionList[bx], 8
loc_1D97A:
	jmp	loc_1D7C6
loc_1D97D:
	mov	ax, offset s_useTheseCommands?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_1D996
	jmp	loc_1D7BE
loc_1D996:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_partyGetActions endp
