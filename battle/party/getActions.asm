; Attributes: bp-based frame

bat_partyGetActions proc far

	slotNumber=	word ptr -138h
	stringBuffer= word ptr -136h
	validMouseOptions=	word ptr -36h
	validKeys=	word ptr -20h
	loopCounter=	word ptr -14h
	mouseBitmask=	word ptr -12h
	actionOptions=	word ptr -10h
	inKey= word ptr	-6
	stringBufferP= dword ptr -4

	FUNC_ENTER(138h)
	push	si

	cmp	g_partyAttackFlag, 0
	jnz	l_getCharacterActions

	CALL(bat_monGroupActive)
	or	ax, ax
	jz	l_getCharacterActions

	CALL(_return_zero)
	or	ax, ax
	jnz	l_getCharacterActions

	PUSH_STACK_ADDRESS(actionOptions)
	CALL(bat_partyGetActionOptions, near)

	PUSH_STACK_ADDRESS(validMouseOptions)
	PUSH_STACK_ADDRESS(validKeys)
	PUSH_STACK_ADDRESS(actionOptions)
	PUSH_OFFSET(s_willYourGallantBand)
	CALL(printVarString)
	mov	[bp+mouseBitmask], ax

l_fraIoLoop:					; fra = Fight Run Advance
	push	[bp+mouseBitmask]
	CALL(getKey)
	mov	[bp+inKey], ax

	mov	[bp+loopCounter], 0
l_fraCheckKeyLoop:
	mov	si, [bp+loopCounter]
	cmp	byte ptr [bp+si+validKeys], 0
	jz	short l_fraIoLoop

	mov	al, byte ptr [bp+si+validKeys]		; Check valid keys
	cbw
	cmp	ax, [bp+inKey]
	jz	short l_execPartyOptionFunction

	shl	si, 1					; Check valid mouse selections
	mov	ax, [bp+inKey]
	cmp	[bp+si+validMouseOptions], ax
	jz	short l_execPartyOptionFunction
	inc	[bp+loopCounter]
	jmp	short l_fraCheckKeyLoop

l_execPartyOptionFunction:
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_batPartyOptionFunctions[bx]
	or	ax, ax
	jnz	l_return

l_getCharacterActions:
	mov	[bp+slotNumber], 0

l_characterActionLoop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_confirmActions

	CALL(text_clear)
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_monster
	jnb	l_characterActionNext

	test	gs:party.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_characterActionNext

	test	gs:party.status[si], stat_possessed or	stat_nuts
	jz	short l_printOptions
	cmp	gs:(party.specAbil+3)[si], 0
	jnz	l_uncontrolledAction

l_printOptions:
	CALL(text_clear)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(VAR_4)

	PUSH_OFFSET(s_hasTheseOptions)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	mov	bx, [bp+slotNumber]
	cmp	gs:g_characterMeleeDistance[bx], 0
	jz	short l_skipMelee

	mov	al, gs:g_characterMeleeDistance[bx]
	add	al, '1'
	mov	s_attackDistString, al
	mov	ax, offset s_attackDistString
	push	ds
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

l_skipMelee:
	PUSH_OFFSET(s_characterOptionsString)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	push	[bp+slotNumber]
	PUSH_STACK_ADDRESS(actionOptions)
	CALL(bat_charGetActionOptions, near)

	PUSH_STACK_ADDRESS(validMouseOptions)
	PUSH_STACK_ADDRESS(validKeys)
	PUSH_STACK_ADDRESS(actionOptions)
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(printVarString)

	mov	[bp+mouseBitmask], ax
	PRINTOFFSET(s_selectAnOption)

	push	[bp+mouseBitmask]
	CALL(getKey)
	mov	[bp+inKey], ax
	mov	[bp+loopCounter], 0
l_characterActionCheckKeyLoop:
	mov	si, [bp+loopCounter]
	cmp	byte ptr [bp+si+validKeys], 0		; Check valid keys
	jz	l_printOptions
	mov	al, byte ptr [bp+si+validKeys]
	cbw
	cmp	ax, [bp+inKey]
	jz	short l_execCharacterActionFunction

	shl	si, 1
	mov	ax, [bp+inKey]
	cmp	[bp+si+validMouseOptions], ax		; Check valid mouse inputs
	jnz	short l_characterActionCheckKeyNext

l_execCharacterActionFunction:
	mov	al, byte ptr [bp+loopCounter]
	inc	al
	mov	bx, [bp+slotNumber]
	mov	gs:g_charActionList[bx], al
	push	[bp+slotNumber]
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_batCharOptionFunctions[bx]
	add	sp, 2
	or	ax, ax					; 0 indicates failure from option function
	jz	l_characterActionLoop			; Retry on failure
	jmp	l_characterActionNext			; Move to next slot on success
	
l_characterActionCheckKeyNext:
	inc	[bp+loopCounter]
	jmp	short l_characterActionCheckKeyLoop

l_uncontrolledAction:
	mov	bx, [bp+slotNumber]
	mov	gs:g_charActionList[bx], 8

l_characterActionNext:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	l_characterActionLoop

l_confirmActions:
	PRINTOFFSET(s_useTheseCommands, clear)
	CALL(getYesNo)
	or	ax, ax
	jz	l_getCharacterActions

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_partyGetActions endp
