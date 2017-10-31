; Attributes: bp-based frame

party_reorder proc far

	emptySlot=	word ptr -24h
	var_22=	word ptr -22h
	var_14=	word ptr -14h
	loopCounter=	word ptr -12h
	slotNumberRead=	word ptr -10h
	var_E= word ptr	-0Eh

	FUNC_ENTER
	CHKSTK(24h)
	push	di
	push	si

	CALL(party_findEmptySlot)
	mov	[bp+emptySlot], ax
	cmp	ax, 1
	jle	l_return

l_reorderEntry:
	CALL(text_clear)
	mov	[bp+loopCounter], 0

; Initialize arrays:
;   var_E is initialized with 0
;   var_22 is initialized with 0FFFFh
l_listInitialization:
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	[bp+si+var_E], 0
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	[bp+si+var_22],	0FFFFh
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_listInitialization

	PUSH_OFFSET(s_newOrder)
	PRINTSTRING
	mov	[bp+loopCounter], 0

l_newOrderIoEntry:
	mov	al, byte ptr [bp+loopCounter]
	add	al, '1'
	mov	byte_42AF5, al
	PUSH_OFFSET(s_gtChar)
	CALL(text_nlWriteString, 4)

l_retryReadSlot:
	CALL(readSlotNumber)
	mov	[bp+slotNumberRead], ax
	or	ax, ax
	jl	l_return

	mov	ax, [bp+emptySlot]
	cmp	[bp+slotNumberRead], ax
	jge	short l_retryReadSlot

	mov	si, [bp+slotNumberRead]
	shl	si, 1
	cmp	[bp+si+var_E], 0
	jnz	short l_retryReadSlot

	mov	si, [bp+slotNumberRead]
	shl	si, 1
	mov	[bp+si+var_E], 1
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	ax, [bp+slotNumberRead]
	mov	[bp+si+var_22],	ax
	CHARINDEX(ax, STACKVAR(slotNumberRead), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(text_writeString, 4)
	inc	[bp+loopCounter]
	mov	ax, [bp+emptySlot]
	dec	ax
	cmp	ax, [bp+loopCounter]
	jg	short l_newOrderIoEntry

	mov	[bp+var_14], 0
l_var_EcomparisonLoopEntry:
	mov	si, [bp+var_14]
	shl	si, 1
	cmp	[bp+si+var_E], 0
	jz	short loc_119C9
	inc	[bp+var_14]
	jmp	short l_var_EcomparisonLoopEntry

loc_119C9:
	mov	si, [bp+emptySlot]
	shl	si, 1
	mov	ax, [bp+var_14]
	mov	[bp+si+emptySlot], ax
	mov	al, byte ptr [bp+emptySlot]
	add	al, '0'
	mov	byte_42AF5, al
	PUSH_OFFSET(s_gtChar)
	CALL(text_nlWriteString, 4)
	CHARINDEX(ax, STACKVAR(var_14), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(text_writeString, 4)
	PUSH_OFFSET(s_useThisOrder)
	PRINTSTRING
	CALL(getYesNo)
	or	ax, ax
	jz	l_reorderEntry

	mov	[bp+loopCounter], 0
	jmp	short loc_11A27
loc_11A24:
	inc	[bp+loopCounter]
loc_11A27:
	mov	ax, [bp+emptySlot]
	dec	ax
	cmp	ax, [bp+loopCounter]
	jle	short l_updateAndReturn
	mov	di, [bp+loopCounter]
	shl	di, 1
	mov	si, [bp+di+var_22]
	cmp	[bp+loopCounter], si
	jz	short loc_11A7D
	push	si
	push	[bp+loopCounter]
	NEAR_CALL(party_swapMembers, 4)
	mov	ax, [bp+loopCounter]
	inc	ax
	mov	[bp+var_14], ax
	jmp	short loc_11A54
loc_11A51:
	inc	[bp+var_14]
loc_11A54:
	mov	ax, [bp+emptySlot]
	cmp	[bp+var_14], ax
	jge	short loc_11A6D
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+loopCounter]
	cmp	[bp+si+var_22],	ax
	jnz	short loc_11A6B
	jmp	short loc_11A6D
loc_11A6B:
	jmp	short loc_11A51
loc_11A6D:
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	ax, [bp+si+var_22]
	mov	si, [bp+var_14]
	shl	si, 1
	mov	[bp+si+var_22],	ax
loc_11A7D:
	jmp	short loc_11A24
l_updateAndReturn:
	mov	byte ptr g_printPartyFlag,	0
l_return:
	pop	si
	pop	di
	FUNC_EXIT
	retf
party_reorder endp
