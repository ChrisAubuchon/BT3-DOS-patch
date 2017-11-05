; Attributes: bp-based frame

text_castSpell proc far

	_instr = word ptr -7
	counter = word ptr -2
	arg_0 = word ptr 6

	FUNC_ENTER(7)
	push	si

	CALL(text_clear)

	PUSH_OFFSET(s_spellToCast)
	PRINTSTRING

	PUSH_IMM(4)
	PUSH_STACK_ADDRESS(_instr)
	CALL(readString)

	PUSH_STACK_ADDRESS(_instr)
	CALL(_strlen)
	cmp	ax, 4
	jl	l_fail_no_print

	lea	si, [bp+_instr]
	mov	[bp+counter], 0

l_toupper_start:
	cmp	[bp+counter], 4
	jge	l_toupper_exit
	mov	bx, [bp+counter]
	mov	al, ss:[si+bx]
	sub	ah, ah
	push	ax
	CALL(_str_capitalize)

	mov	bx, [bp+counter]
	mov	ss:[si+bx], al
	inc	[bp+counter]
	jmp	l_toupper_start

l_toupper_exit:
	mov	[bp+counter], 0

l_spellCmp_start:
	cmp	[bp+counter], 7Eh
	jge	l_spellNotFound

	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	shl	bx, 1
	mov	si, word ptr spellString.abbreviation[bx]
	lea	di, [bp+_instr]
	push	ss
	pop	es
	mov	cx, 4
	repe	cmpsb
	jz	l_spellFound

	inc	[bp+counter]
	jmp	l_spellCmp_start

l_spellNotFound:
	PUSH_OFFSET(s_noSpellByThatName)
	jmp	l_fail

l_spellFound:
	push	[bp+counter]
	push	[bp+arg_0]
	CALL(mage_hasLearnedSpell)
	or	ax, ax
	jz	l_notLearned
	
	mov	ax, [bp+counter]
	jmp	l_return

l_notLearned:
	PUSH_OFFSET(s_dontKnowThatSpell)

l_fail:
	PRINTSTRING
	DELAY(2)

l_fail_no_print:
	mov	ax, 0FFFFh

l_return:
	pop	si
	FUNC_EXIT
	retf
text_castSpell endp
