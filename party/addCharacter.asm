; This function	inserts	a new member into the last
; active slot in the party. Dead, paralyzed or	stoned
; members are moved down.
; Attributes: bp-based frame

party_addCharacter proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	emptySlot= word	ptr -2

	FUNC_ENTER(6)
	push	si

	CALL(party_getLastSlot, near)
	mov	[bp+emptySlot],	ax
	cmp	ax, 7
	jge	l_return
	mov	[bp+var_4], 0
loc_14CB5:
	CALL(party_getLastSlot, near)
	cmp	ax, [bp+var_4]
	jle	short l_return
	CHARINDEX(ax, STACKVAR(var_4), si)
	test	gs:party.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_14D2B
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party._name[si]
	push	dx
	push	ax
	CALL(copyCharacterBuf, near)
	push	[bp+var_4]
	CALL(party_pack, near)
	cmp	gs:newCharBuffer.class,	class_illusion
	jz	short loc_14D29
	cmp	gs:newCharBuffer.specAbil+3, 0
	jnz	short loc_14D29
	CALL(party_findEmptySlot, near)
	mov	[bp+var_6], ax
	CHARINDEX(ax, STACKVAR(var_6) ,bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	push	dx
	push	ax
	CALL(copyCharacterBuf, near)
loc_14D29:
	jmp	short loc_14D2E
loc_14D2B:
	inc	[bp+var_4]
loc_14D2E:
	jmp	short loc_14CB5
l_return:
	pop	si
	FUNC_EXIT
	retf
party_addCharacter endp
