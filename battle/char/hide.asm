; Attributes: bp-based frame

bat_charHide proc far

	stringBufferP= dword ptr -108h
	stringBuffer= word ptr -104h
	tmpBufferP= dword ptr	-4
	arg_0= word ptr	 6

	FUNC_ENTER(108h)

	CHARINDEX(ax, STACKVAR(arg_0), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	PUSH_OFFSET(s_jumpsIntoShadows)
	push	dx
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)

	mov	ax, itemEff_alwaysHide
	push	ax
	push	[bp+arg_0]
	CALL(character_isEffectEquipped)
	or	ax, ax
	jz	short l_hideSuccess

	CALL(random)
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(arg_0), bx)
	cmp	gs:(party.specAbil+2)[bx], cl
	jbe	short l_hideFailed

l_hideSuccess:
	mov	ax, offset s_andSucceeds
	mov	word ptr [bp+tmpBufferP], ax
	mov	word ptr [bp+tmpBufferP+2], ds
	mov	bx, [bp+arg_0]
	inc	gs:g_characterMeleeDistance[bx]
	jmp	short l_return

l_hideFailed:
	mov	ax, offset s_butIsDiscovered
	mov	word ptr [bp+tmpBufferP], ax
	mov	word ptr [bp+tmpBufferP+2], ds
	mov	bx, [bp+arg_0]
	mov	gs:g_characterMeleeDistance[bx], 0

l_return:
	push	word ptr [bp+tmpBufferP+2]
	push	word ptr [bp+tmpBufferP]
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	FUNC_EXIT
	retf
bat_charHide endp
