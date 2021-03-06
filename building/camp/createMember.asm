
; Attributes: bp-based frame

camp_createMember proc far

	mouseSubtractor= byte ptr -23Ah
	var_EC=	byte ptr -0ECh
	var_EA=	word ptr -0EAh
	var_E8=	word ptr -0E8h
	var_7E=	byte ptr -7Eh
	var_34=	word ptr -34h
	counter= word ptr -32h
	var_30=	word ptr -30h
	attributeValueList=	word ptr -2Eh
	inKey=	word ptr -22h
	dataP=	dword ptr -20h
	var_1C=	word ptr -1Ch
	var_8= word ptr	-8
	raceGenderValue= word ptr -6
	var_4= word ptr	-4
	mouseBitMask= word ptr	-2

	FUNC_ENTER(0ECh)
	push	di
	push	si
	mov	word ptr [bp+dataP], offset newCharBuffer
	mov	word ptr [bp+dataP+2],	seg seg027
loc_129B3:
	mov	[bp+counter], 0
	jmp	short loc_129BD
loc_129BA:
	inc	[bp+counter]
loc_129BD:
	cmp	[bp+counter], 78h 
	jge	short loc_129CF
	mov	bx, [bp+counter]
	lfs	si, [bp+dataP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_129BA
loc_129CF:
	CALL(getCharacterGender, near)
	mov	gs:newCharBuffer.gender, al
	cmp	al, 0FFh
	jnz	short loc_129E4
	sub	ax, ax
	jmp	loc_12DAE
loc_129E4:
	CALL(getCharacterRace, near)
	mov	gs:newCharBuffer.race, al
	cmp	al, 0FFh
	jnz	short loc_129F9
	sub	ax, ax
	jmp	loc_12DAE
loc_129F9:
	mov	al, gs:newCharBuffer.race
	sub	ah, ah
	shl	ax, 1
	mov	cl, gs:newCharBuffer.gender
	sub	ch, ch
	add	ax, cx
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	mov	[bp+raceGenderValue], ax
	mov	[bp+counter], 0
	jmp	short loc_12A1F
loc_12A1C:
	inc	[bp+counter]
loc_12A1F:
	cmp	[bp+counter], 5
	jge	short loc_12A5A
	CALL(random)
	and	ax, 7
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	mov	cx, ax
	mov	al, byte ptr g_raceBaseAttributes.male_st[bx+si]
	cbw
	add	ax, cx
	mov	si, bx
	shl	si, 1
	mov	[bp+si+attributeValueList],	ax
	mov	si, [bp+counter]
	shl	si, 1
	cmp	[bp+si+attributeValueList],	charMaxAttribute
	jle	short loc_12A58
	mov	si, [bp+counter]
	shl	si, 1
	mov	[bp+si+attributeValueList],	charMaxAttribute
loc_12A58:
	jmp	short loc_12A1C
loc_12A5A:
	CALL(random)
	and	ax, 0Fh
	add	ax, 13
	mov	[bp+var_30], ax
	mov	gs:newCharBuffer.currentHP, ax
	mov	gs:newCharBuffer.maxHP,	ax
	CALL(text_clear)
	mov	ax, 5
	push	ax
	PUSH_STACK_ADDRESS(var_E8)
	PUSH_STACK_ADDRESS(attributeValueList)
	CALL(getAttributeString)

	PUSH_STACK_ADDRESS(var_E8)
	PRINTSTRING(false)
	mov	al, gs:newCharBuffer.race
	sub	ah, ah
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	[bp+raceGenderValue], ax
	sub	ax, ax
	mov	[bp+var_EA], ax
	mov	[bp+mouseBitMask], ax
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	[bp+var_8], ax
	mov	[bp+counter], 0
	jmp	short loc_12AD8
loc_12AD5:
	inc	[bp+counter]
loc_12AD8:
	cmp	[bp+counter], 10
	jge	short loc_12B30
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	cmp	byte ptr g_raceStartingClasses.canBeWarrior[bx+si], 0
	jz	short loc_12B2E
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, g_mouseLineMaskList[bx+2]
	or	[bp+mouseBitMask], ax
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_classString+2)[bx]
	push	word ptr g_classString[bx]
	push	[bp+var_EA]
	CALL(printListItem, near)
	mov	si, [bp+var_EA]
	inc	[bp+var_EA]
	shl	si, 1
	mov	ax, [bp+counter]
	mov	[bp+si+var_1C],	ax
loc_12B2E:
	jmp	short loc_12AD5
loc_12B30:
	mov	[bp+var_4], 0
	mov	[bp+var_34], 1
loc_12B3A:
	push	[bp+mouseBitMask]
	CALL(getKey)
	mov	[bp+inKey], ax
	mov	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+inKey]
	jg	short loc_12B7B
	mov	ax, [bp+var_EA]
	add	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+inKey]
	jl	short loc_12B7B
	mov	si, [bp+inKey]
	sub	si, [bp+var_8]
	shl	si, 1
	mov	al, [bp+si+mouseSubtractor]
	mov	gs:newCharBuffer.class,	al
	mov	[bp+var_34], 0
loc_12B7B:
	cmp	[bp+inKey], 30h 
	jle	short loc_12BA4
	mov	ax, [bp+var_EA]
	add	ax, 30h	
	cmp	ax, [bp+inKey]
	jl	short loc_12BA4
	mov	si, [bp+inKey]
	shl	si, 1
	mov	al, [bp+si+var_7E]
	mov	gs:newCharBuffer.class,	al
	mov	[bp+var_34], 0
	jmp	short loc_12BB4
loc_12BA4:
	cmp	[bp+inKey], 1Bh
	jnz	short loc_12BB4
	mov	[bp+var_34], 0
	mov	[bp+var_4], 1
loc_12BB4:
	cmp	[bp+var_34], 0
	jz	short loc_12BBD
	jmp	loc_12B3A
loc_12BBD:
	cmp	[bp+var_4], 0
	jz	short loc_12BC6
	jmp	loc_129B3
loc_12BC6:
	mov	al, gs:newCharBuffer.class
	sub	ah, ah
	mov	si, ax
	mov	di, word ptr gs:newCharBuffer.gender
	and	di, 0FFh
	mov	bx, si
	shl	bx, 1
	mov	al, g_classPictureNumber[bx+di]
	mov	gs:newCharBuffer.picIndex, al
	mov	ax, si
	jmp	short loc_12C3B
loc_12BEB:
	mov	gs:newCharBuffer.spells, 0E0h ;	'�'
	jmp	short loc_12C56
loc_12BF7:
	mov	gs:newCharBuffer.spells+2, 1Ch
	jmp	short loc_12C56
loc_12C03:
	mov	gs:newCharBuffer.specAbil, 14h
	mov	gs:newCharBuffer.specAbil+1, 14h
	mov	gs:newCharBuffer.specAbil+2, 14h
	jmp	short loc_12C56
loc_12C1B:
	mov	gs:newCharBuffer.specAbil, 1
	mov	gs:newCharBuffer.specAbil+1, 0FCh 
	jmp	short loc_12C56
loc_12C2D:
	mov	gs:newCharBuffer.specAbil, 5
	jmp	short loc_12C56
	jmp	short loc_12C56
loc_12C3B:
	cmp	ax, class_conjurer
	jz	short loc_12BEB
	cmp	ax, class_magician
	jz	short loc_12BF7
	cmp	ax, class_rogue
	jz	short loc_12C03
	cmp	ax, class_bard
	jz	short loc_12C1B
	cmp	ax, class_hunter
	jz	short loc_12C2D
	jmp	short $+2
loc_12C56:
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	mov	al, g_classStartingInventoryIndex[bx]
	cbw
	mov	[bp+raceGenderValue], ax
	mov	[bp+counter], 0
loc_12C6E:
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	mov	al, g_classStartingInventory[bx+si]
	cmp	al, 0FEh 
	jz	short loc_12C8A
	mov	gs:newCharBuffer.inventory.itemFlags[bx], al
	inc	[bp+counter]
	jmp	short loc_12C6E
loc_12C8A:
	mov	word ptr [bp+dataP], offset newCharBuffer.strength
	mov	word ptr [bp+dataP+2],	seg seg027
	mov	[bp+counter], 0
	jmp	short loc_12C9E
loc_12C9B:
	inc	[bp+counter]
loc_12C9E:
	cmp	[bp+counter], 5
	jge	short loc_12CB7
	mov	si, [bp+counter]
	shl	si, 1
	mov	al, byte ptr [bp+si+attributeValueList]
	mov	bx, [bp+counter]
	lfs	si, [bp+dataP]
	mov	fs:[bx+si], al
	jmp	short loc_12C9B
loc_12CB7:
	mov	gs:newCharBuffer.level,	1
	mov	gs:newCharBuffer.maxLevel, 1
	cmp	gs:newCharBuffer.class,	class_warrior
	jz	short loc_12CEE
	cmp	gs:newCharBuffer.class,	class_rogue
	jnb	short loc_12CEE
	CALL(random)
	and	ax, 0Fh
	add	ax, 8
	mov	gs:newCharBuffer.currentSppt, ax
	jmp	short loc_12CF5
loc_12CEE:
	mov	gs:newCharBuffer.currentSppt, 0
loc_12CF5:
	mov	ax, gs:newCharBuffer.currentSppt
	mov	gs:newCharBuffer.maxSppt, ax
loc_12CFD:
	PUSH_OFFSET(s_nameYourCharacter)
	PRINTSTRING(true)
	mov	ax, 0Eh
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(readString)
	or	ax, ax
	jnz	short loc_12D25
	jmp	loc_12DAE
loc_12D25:
	cmp	gs:newCharBuffer._name,	2Ah 
	jnz	short loc_12D37
	mov	gs:newCharBuffer._name,	58h 
loc_12D37:
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(roster_nameExists, near)
	or	ax, ax
	jl	short loc_12D6A
	PUSH_OFFSET(s_nameAlreadyExists)
	PRINTSTRING(true)
	IOWAIT
	mov	[bp+var_4], 1
	jmp	short loc_12D6F
loc_12D6A:
	mov	[bp+var_4], 0
loc_12D6F:
	cmp	[bp+var_4], 0
	jnz	short loc_12CFD
	CALL(roster_countCharacters, near)
	mov	[bp+var_30], ax
	CHARINDEX(ax, STACKVAR(var_30), bx)
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(copyCharacterBuf, near)
	CHARINDEX(ax, STACKVAR(var_30), bx)
	mov	fs, seg022_x
	assume fs:seg022
	mov	fs:(g_rosterCharacterBuffer+78h)[bx], 0
loc_12DAE:
	pop	si
	pop	di
	FUNC_EXIT
	retf
camp_createMember endp
