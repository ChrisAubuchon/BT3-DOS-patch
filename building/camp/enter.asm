; Attributes: bp-based frame

camp_enter proc	far

	lastActiveSlot=	word ptr -58h
	loopCounter=	word ptr -56h
	mouseBitmask=	word ptr -54h
	optionKeys=	word ptr -52h
	currentKey=	word ptr -3Eh
	optionMouse=	word ptr -3Ch
	campOptionList=	word ptr -14h

	FUNC_ENTER
	CHKSTK(58h)
	push	si

	CALL(endNonCombatSong)

	; End all duration spells when entering camp
	mov	[bp+loopCounter], 0
l_durationSpellLoopEntry:
	mov	bx, [bp+loopCounter]
	cmp	lightDuration[bx], 0
	jz	short l_notActive
	push	bx
	CALL(icon_deactivate, 2)
l_notActive:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short l_durationSpellLoopEntry

	mov	gs:gl_detectSecretDoorFlag, 0
	mov	gs:songACBonus,	0
	NEAR_CALL(readRosterFiles)
	NEAR_CALL(roster_writeParty)
	PUSH_OFFSET(s_ruinTitle)
	CALL(setTitle, 4)
	sub	ax, ax
	push	ax
	CALL(bigpic_drawPictureNumber, 2)
l_mainIoLoopEntry:
	CALL(text_clear)
	PUSH_STACK_ADDRESS(campOptionList)
	NEAR_CALL(camp_configOptionList, 4)
	PUSH_STACK_ADDRESS(optionMouse)
	PUSH_STACK_ADDRESS(optionKeys)
	PUSH_STACK_ADDRESS(campOptionList)
	PUSH_OFFSET(s_campMenuString)
	CALL(printVarString, 10h)
	mov	[bp+mouseBitmask], ax
	NEAR_CALL(party_findEmptySlot)
	mov	[bp+lastActiveSlot], ax
	mov	ax, [bp+mouseBitmask]
	or	ah, 20h
	push	ax
	CALL(getKey)
	mov	[bp+currentKey], ax

	cmp	ax, '0'			; Print character if 1-7
	jle	short l_checkKeyAgainstOptions
	mov	ax, [bp+lastActiveSlot]
	add	ax, '1'
	cmp	ax, [bp+currentKey]
	jle	short l_checkKeyAgainstOptions
	mov	ax, [bp+currentKey]
	sub	ax, '1'
	push	ax
	CALL(printCharacter, 2)
	sub	ax, ax
	push	ax
	CALL(bigpic_drawPictureNumber, 2)
	PUSH_OFFSET(s_ruinTitle)
	CALL(setTitle, 4)
	jmp	short loc_135A7

l_checkKeyAgainstOptions:
	mov	[bp+loopCounter], 0
loc_13569:
	mov	si, [bp+loopCounter]
	cmp	byte ptr [bp+si+optionKeys], 0
	jz	short loc_135A7

	mov	al, byte ptr [bp+si+optionKeys]
	cbw
	cmp	ax, [bp+currentKey]
	jz	short l_executeCampFunction
	shl	si, 1
	mov	ax, [bp+currentKey]
	cmp	[bp+si+optionMouse], ax
	jnz	short loc_135A2

l_executeCampFunction:
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_campActionFunctions[bx]
	cmp	buildingRvalMaybe, 0
	jz	short loc_135A2
	mov	ax, buildingRvalMaybe
	jmp	short loc_135AA
loc_135A2:
	inc	[bp+loopCounter]
	jmp	short loc_13569
loc_135A7:
	jmp	l_mainIoLoopEntry
loc_135AA:
	pop	si
	FUNC_EXIT
	retf
camp_enter endp

