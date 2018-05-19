; Populate optionList with 1s for inventory actions
;
; 0 - Trade
; 1 - Discard
; 2 - Equip
; 3 - Unequip
; 4 - Identify
;
; Attributes: bp-based frame

inventory_getOptions proc far

	loopCounter= word ptr	-4
	savedItemFlags= word ptr	-2
	optionList= dword ptr  6
	slotNumber= word ptr	 0Ah
	inventorySlotNumber= word ptr	 0Ch

	FUNC_ENTER(4)
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	mov	[bp+savedItemFlags], ax
	mov	al, byte ptr [bp+savedItemFlags]
	and	al, 3
	cmp	al, 1
	jnz	short l_setUnequipFalse
	mov	al, 1
	jmp	short l_setUnequip
l_setUnequipFalse:
	sub	al, al
l_setUnequip:
	lfs	bx, [bp+optionList]
	mov	fs:[bx+3], al

	; This loop sets: trade, discard and equip
	; to 0 if unequip is set above
	;
	mov	[bp+loopCounter], 0
l_loop:
	lfs	bx, [bp+optionList]
	cmp	byte ptr fs:[bx+3], 1
	sbb	ax, ax
	neg	ax
	mov	bx, [bp+loopCounter]
	mov	si, word ptr [bp+optionList]
	mov	fs:[bx+si], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short l_loop

	lfs	bx, [bp+optionList]
	mov	byte ptr fs:[bx+4], 0		; Initialze identify to false

	lfs	bx, [bp+optionList]
	cmp	byte ptr fs:[bx], 0
	jz	short l_return

	; Set Equip to false if item is unequippable
	mov	al, byte ptr [bp+savedItemFlags]
	and	al, 3
	cmp	al, 2
	jnz	short l_setIdentify
	mov	byte ptr fs:[bx+2], 0

l_setIdentify:
	mov	al, byte ptr [bp+savedItemFlags]
	and	al, 0C0h
	cmp	al, 80h
	jnz	short l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_rogue

	jnz	short l_return
	lfs	bx, [bp+optionList]
	mov	byte ptr fs:[bx+4], 1

l_return:
	pop	si
	FUNC_EXIT
	retf
inventory_getOptions endp
