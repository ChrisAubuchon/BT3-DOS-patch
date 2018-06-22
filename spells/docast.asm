; Attributes: bp-based frame

doCastSpell proc far

	stringBuf= word ptr -108h
	stringBufP= dword ptr -8
	partySlotNumber=	word ptr  6
	spellNumber= word ptr  8
	itemUsedFlag= word ptr	 0Ah
	useSppt= word ptr	 0Ch

	FUNC_ENTER(108h)

	push	[bp+partySlotNumber]
	PUSH_STACK_ADDRESS(stringBuf)
	CALL(bat_getAttackerName)
	SAVE_PTR_STACK(dx, ax, stringBufP)
	APPEND_CHAR(STACKVAR(stringBufP), ' ')

	cmp	[bp+spellNumber], 7Eh 
	jge	short l_spptCheck

	PUSH_OFFSET(s_castsASpell)
	PUSH_STACK_DWORD(stringBufP)
	STRCAT(stringBufP)
	APPEND_CHAR(STACKVAR(stringBufP), ' ')

	; Append full spell name to output string
	mov	bx, [bp+spellNumber]
	mov	cl, 3
	shl	bx, cl
	push	word ptr (spellString.fullName+2)[bx]
	push	word ptr spellString.fullName[bx]
	push	word ptr [bp+stringBufP+2]
	push	word ptr [bp+stringBufP]
	STRCAT(stringBufP)

l_spptCheck:
	cmp	[bp+useSppt], 0
	jz	short l_castIt
	push	[bp+spellNumber]
	push	[bp+partySlotNumber]
	CALL(_sp_checkSPPT, near)
	or	ax, ax
	jz	short l_fizzled
	mov	al, gs:sq_antiMagicFlag
	sub	ah, ah
	or	ax, ax
	jz	short l_castIt

l_fizzled:
	NULL_TERMINATE(STACKVAR(stringBufP))
	PUSH_STACK_ADDRESS(stringBuf)
	PRINTSTRING

	CALL(printSpellFizzled)

	sub	ax, ax
	jmp	short l_return
l_castIt:
	PUSH_STACK_ADDRESS(stringBuf)
	PRINTSTRING
	push	[bp+itemUsedFlag]
	push	[bp+spellNumber]
	push	[bp+partySlotNumber]
	CALL(spell_cast, near)
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
doCastSpell endp
