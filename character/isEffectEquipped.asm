; Attributes: bp-based frame
;
; Return:
;   0 - has effect and is equipped
;   1 - has effect and not equipped
;  -1 - does not have effect
;

character_isEffectEquipped proc far

	rval= word ptr -4
	inventorySlotNumber= word ptr	-2
	slotNumber= word ptr  6
	effectNumber= word ptr  8

	FUNC_ENTER(4)

	mov	[bp+rval], 0FFFFh
	cmp	byte ptr gs:party._name[bx], 0
	jz	short l_return

	mov	[bp+inventorySlotNumber], 1
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	mov	bx, ax
	mov	al, itemEffectList[bx]
	and	ax, 0Fh
	cmp	ax, [bp+effectNumber]
	jnz	l_next

	; Effect found. Determine if the item is equipped or not.
	;
	mov	[bp+rval], 1
	mov	ax, [bp+inventorySlotNumber]
	dec	ax
	mov	gs:g_inventoryPackStart, ax
	mov	ax, [bp+slotNumber]
	mov	gs:g_inventoryPackTarget, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.acBase[bx]
	and	al, 3
	cmp	al, 1
	jnz	short l_next

	sub	ax, ax
	mov	[bp+rval], ax
	jmp	short l_return

l_next:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], 24h
	jl	l_loop

l_return:
	mov	ax, [bp+rval]
	FUNC_EXIT
	retf
character_isEffectEquipped endp
