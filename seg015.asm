; Segment type:	Pure code
seg015 segment word public 'CODE' use16
	assume cs:seg015
;org 0Dh
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
algn_25E6D:
align 2
; Attributes: bp-based frame

doSummon proc far

	arg_0= byte ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	test	gs:disbelieveFlags, disb_nosummon
	jz	short loc_25E96
	mov	ax, offset s_butItFizzledNl
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_25EB2
loc_25E96:
	test	[bp+arg_0], 80h
	jz	short loc_25EA8
	push	[bp+arg_2]
	push	cs
	call	near ptr sum_monSummon
	add	sp, 2
	jmp	short loc_25EB2
loc_25EA8:
	push	[bp+arg_2]
	push	cs
	call	near ptr sum_partySummonSpell
	add	sp, 2
loc_25EB2:
	mov	sp, bp
	pop	bp
locret_25EB5:
	retf
doSummon endp

; Attributes: bp-based frame

sum_partySummonSpell proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+var_4], 0
loc_25EC6:
	call	party_findEmptySlot
	mov	[bp+var_2], ax
	cmp	ax, 7
	jge	short loc_25F1E
	mov	ax, [bp+arg_0]
	and	ax, 1Fh
	getMonIndex	cx, cx
	add	ax, offset summonData
	push	ds
	push	ax
	push	[bp+var_2]
	call	_sp_convertMonToSummon
	add	sp, 6
	test	byte ptr [bp+arg_0], 80h
	jz	short loc_25EF8
	mov	al, class_illusion
	jmp	short loc_25EFA
loc_25EF8:
	mov	al, class_monster
loc_25EFA:
	mov	cx, ax
	getCharP	[bp+var_2], bx
	mov	gs:party.class[bx], cl
	mov	byte ptr g_printPartyFlag,	0
	mov	[bp+var_4], 1
	jmp	short loc_25F2A
loc_25F1E:
	push	[bp+var_4]
	push	cs
	call	near ptr sum_printNoRoom
	add	sp, 2
	jmp	short loc_25F36
loc_25F2A:
	cmp	g_curSpellNumber, 4Dh 
	jz	short loc_25EC6
loc_25F36:
	mov	sp, bp
	pop	bp
	retf
sum_partySummonSpell endp

; Attributes: bp-based frame

sum_monSummon proc far

	groupNo= word ptr -6
	var_4= word ptr	-4
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	[bp+var_4], 0
loc_25F4A:
	mov	[bp+groupNo], 0
	jmp	short loc_25F54
loc_25F51:
	inc	[bp+groupNo]
loc_25F54:
	cmp	[bp+groupNo], 4
	jge	short loc_25F72
	getMonP	[bp+groupNo], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jnz	short loc_25F70
	jmp	short loc_25F72
loc_25F70:
	jmp	short loc_25F51
loc_25F72:
	cmp	[bp+groupNo], 4
	jge	short loc_25F97
	push	[bp+groupNo]
	push	[bp+arg_0]
	push	cs
	call	near ptr sum_newMonGroup
	add	sp, 4
	push	[bp+groupNo]
	push	[bp+arg_0]
	push	cs
	call	near ptr sum_addMonToGroup
	add	sp, 4
	or	[bp+var_4], ax
	jmp	short loc_25FDA
loc_25F97:
	cmp	g_curSpellNumber, 4Dh 
	jnz	short loc_25FAF
	push	[bp+var_4]
	push	cs
	call	near ptr sum_printNoRoom
	add	sp, 2
	jmp	short loc_25FF5
loc_25FAF:
	push	[bp+arg_0]
	push	cs
	call	near ptr sum_getMatchMonGroup
	add	sp, 2
	mov	[bp+groupNo], ax
	or	ax, ax
	jl	short loc_25FDA
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr sum_addMonToGroup
	add	sp, 4
	or	[bp+var_4], ax
	push	[bp+var_4]
	push	cs
	call	near ptr sum_printNoRoom
	add	sp, 2
	jmp	short loc_25FF5
loc_25FDA:
	cmp	g_curSpellNumber, 4Dh 
	jz	short loc_25FF2
	push	[bp+var_4]
	push	cs
	call	near ptr sum_printNoRoom
	add	sp, 2
	jmp	short loc_25FF5
loc_25FF2:
	jmp	loc_25F4A
loc_25FF5:
	mov	sp, bp
	pop	bp
	retf
sum_monSummon endp

; This function	looks for a monster group that matches
; the summonData.name given by summonNo. It returns
; the matching group number. If	not found, it returns
; 0xffff
; Attributes: bp-based frame

sum_getMatchMonGroup proc far

	var_2= word ptr	-2
	summonNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_2600E
loc_2600B:
	inc	[bp+var_2]
loc_2600E:
	cmp	[bp+var_2], 4
	jge	short loc_26043
	getMonIndex	ax, [bp+summonNo]
	add	ax, offset summonData
	push	ds
	push	ax
	getMonP	[bp+var_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	map_strcmp
	add	sp, 8
	or	ax, ax
	jz	short loc_26041
	mov	ax, [bp+var_2]
	jmp	short loc_26048
loc_26041:
	jmp	short loc_2600B
loc_26043:
	mov	ax, 0FFFFh
	jmp	short $+2
loc_26048:
	mov	sp, bp
	pop	bp
	retf
sum_getMatchMonGroup endp

; Attributes: bp-based frame

sum_addMonToGroup proc far

	var_116= word ptr -116h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	groupSize= word	ptr -2
	arg_0= byte ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 116h
	call	someStackOperation
	push	si
	getMonP	[bp+arg_2], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize],	ax
	cmp	ax, 1Fh
	jnz	short loc_2607B
	sub	ax, ax
	jmp	loc_26186
loc_2607B:
	getMonP	[bp+arg_2], si
	inc	gs:monGroups.groupSize[si]
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	call	dice_doYDX
	add	sp, 2
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bx, [bp+arg_2]
	mov	ax, cx
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+groupSize]
	shl	cx, 1
	add	bx, cx
	mov	gs:monHpList[bx], ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+groupSize]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	test	[bp+arg_0], 80h
	jz	short loc_260EF
	getMonP	[bp+arg_2], bx
	or	gs:monGroups.flags[bx],	10h
	jmp	short loc_26101
loc_260EF:
	getMonP	[bp+arg_2], bx
	and	gs:monGroups.flags[bx],	0EFh
loc_26101:
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	mov	ax, offset aAndA
	push	ds
	push	ax
	lea	ax, [bp+var_102]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	sub	ax, ax
	push	ax
	push	dx
	push	[bp+var_106]
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	ax, offset aAppears
	push	ds
	push	ax
	push	dx
	push	[bp+var_106]
	call	_strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	lea	ax, [bp+var_102]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 1
	jmp	short $+2
loc_26186:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sum_addMonToGroup endp

; Attributes: bp-based frame

sum_newMonGroup proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	and	[bp+arg_0], 1Fh
	getMonIndex	ax, [bp+arg_0]
	add	ax, offset summonData
	push	ds
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr sub_261E8
	add	sp, 8
	mov	ax, 20h
	push	ax
	getMonIndex	ax, [bp+arg_0]
	add	ax, offset summonHpDice
	push	ds
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups.hpDice[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memcpy

	; FIXED: Set the group size to 0. 
	getMonP	[bp+arg_2], bx
	mov	monGroups.groupSize[bx], 0

	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
sum_newMonGroup endp

; Attributes: bp-based frame

sub_261E8 proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_261FE
loc_261FB:
	inc	[bp+var_2]
loc_261FE:
	cmp	[bp+var_2], 10h
	jge	short loc_26210
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_0]
	mov	byte ptr fs:[bx+si], 0FFh
	jmp	short loc_261FB
loc_26210:
	lfs	bx, [bp+arg_4]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_2622C
	inc	word ptr [bp+arg_4]
	mov	al, fs:[bx]
	or	al, 80h
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	fs:[bx], al
	jmp	short loc_26210
loc_2622C:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_261E8 endp

; Attributes: bp-based frame

sum_printNoRoom	proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 0
	jnz	short loc_2625A
	mov	ax, offset aButNoRoomForASummoni
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayWithTable
loc_2625A:
	mov	sp, bp
	pop	bp
	retf
sum_printNoRoom	endp

seg015 ends
