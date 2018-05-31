; Attributes: bp-based frame

review_changeMageClass proc far

	var_78=	word ptr -76h
	convertList=	word ptr -22h
	currentClassSpellIndex=	word ptr -20h
	loopCounter= word ptr -1Eh
	slotNumber=	word ptr -1Ch
	inKey=	word ptr -1Ah
	newClass=	word ptr -18h
	var_16=	word ptr -16h
	convertListMouseMask= word ptr	-2

	FUNC_ENTER(76h)
	push	si

	PUSH_OFFSET(s_whichMageSeeksChange)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.class[bx]
	cmp	al, class_chronomancer
	jz	short l_unableToChangeClass
	cmp	al, class_geomancer
	jnz	short l_spellcasterCheck

l_unableToChangeClass:
	PUSH_OFFSET(s_cannotChangeClass)
	PRINTSTRING(wait)
	jmp	l_return

l_spellcasterCheck:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	mov	[bp+currentClassSpellIndex], ax
	cmp	ax, 0FFh
	jnz	short l_checkSpellLevels

	PUSH_OFFSET(s_thouArtNotASpellcaster)
	PRINTSTRING(wait)
	jmp	l_return

l_checkSpellLevels:
	mov	[bp+loopCounter], 0

l_spellLevelLoop:
	push	[bp+currentClassSpellIndex]
	push	[bp+loopCounter]
	push	[bp+slotNumber]
	CALL(character_learnedSpellLevel, near)
	or	ax, ax
	jnz	short l_spellLevelNext

	PUSH_OFFSET(s_mustKnowThreeSpellLevels)
	PRINTSTRING(wait)
	jmp	l_return

l_spellLevelNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short l_spellLevelLoop

	mov	[bp+convertList], 0
	mov	[bp+convertListMouseMask], 0
	mov	[bp+loopCounter], 0

l_convertLoop:
	push	[bp+slotNumber]
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_mageConversionCheckFunctions[bx]
	add	sp, 2
	or	ax, ax
	jz	short l_convertNext
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (magicUserString+2)[bx]
	push	word ptr magicUserString[bx]
	push	[bp+convertList]
	CALL(printListItem)
	mov	si, [bp+convertList]
	inc	[bp+convertList]
	shl	si, 1
	mov	ax, [bp+loopCounter]
	mov	[bp+si+var_16],	ax
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+convertListMouseMask], ax

l_convertNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 6
	jl	short l_convertLoop

l_emptyListCheck:
	cmp	[bp+convertList], 0
	jnz	short l_promptForNewClass
	PUSH_OFFSET(s_doesntQualifyForNewClass)
	PRINTSTRING(wait)
	jmp	l_return

l_promptForNewClass:
	PUSH_OFFSET(s_newClassPrompt)
	PRINTSTRING

l_ioLoop:
	push	[bp+convertListMouseMask]
	CALL(getKey)
	mov	[bp+inKey], ax
	cmp	ax, dosKeys_ESC
	jz	l_return
	cmp	[bp+inKey], 10Eh
	jl	short l_checkKey
	cmp	[bp+inKey], 119h
	jg	short l_checkKey
	sub	[bp+inKey], 0DEh 

l_checkKey:
	cmp	[bp+inKey], 31h 
	jl	short l_ioLoop
	mov	ax, [bp+convertList]
	add	ax, 31h	
	cmp	ax, [bp+inKey]
	jl	short l_ioLoop
	mov	si, [bp+inKey]
	shl	si, 1
	mov	ax, [bp+si+var_78]
	mov	[bp+loopCounter], ax
	cmp	ax, 5
	jnz	short l_changeClass

	PUSH_OFFSET(s_convertChronomancerPrompt)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_dostThouAccept)
	PRINTSTRING(true)
	CALL(getYesNo)
	or	ax, ax
	jz	l_return

	PUSH_OFFSET(s_arboriaSpellText)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_arboriaSpellLocation)
	PRINTSTRING(wait)
	push	[bp+slotNumber]
	CALL(mage_removeAllSpells, near)

l_changeClass:
	getCharP	[bp+slotNumber], si
	mov	bx, [bp+loopCounter]
	mov	al, g_convertListToMageClass[bx]
	sub	ah, ah
	mov	[bp+newClass], ax
	mov	cl, gs:party.class[si]
	sub	ch, ch
	cmp	ax, cx
	jz	short l_return
	sub	ax, ax
	mov	word ptr gs:(party.experience+2)[si], ax
	mov	word ptr gs:party.experience[si], ax
	mov	gs:party.maxLevel[si],	1
	mov	gs:party.level[si], 1
	mov	al, byte ptr [bp+newClass]
	mov	gs:party.class[si], al
	mov	bx, [bp+newClass]
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	push	ax
	sub	ax, ax
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnSpellLevel, near)
	mov	byte ptr g_printPartyFlag,	0
	PUSH_OFFSET(s_beginsNewProfession)
	PRINTSTRING(wait)

l_return:
	pop	si
	FUNC_EXIT
	retf
review_changeMageClass endp
