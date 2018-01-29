; Attributes: bp-based frame
;
; Remove an amount of gold from a player. The amount is stored
; in the register specified.
;

mfunc_ifGiveGold proc far

	registerAmountLo= word ptr	-0Ah
	registerAmountHi= word ptr	-8
	registerNumber= word ptr	-6
	memberGoldLo= word ptr	-4
	memberGoldHi= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(0Ah)

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	mov	ax, word ptr gs:party.gold[bx]
	mov	dx, word ptr gs:(party.gold+2)[bx]
	mov	[bp+memberGoldLo], ax
	mov	[bp+memberGoldHi], dx

	mov	bx, [bp+registerNumber]
	shl	bx, 1
	mov	ax, g_vm_registers[bx]
	cwd
	mov	[bp+registerAmountLo], ax
	mov	[bp+registerAmountHi], dx

	mov	ax, [bp+memberGoldLo]
	mov	dx, [bp+memberGoldHi]
	cmp	[bp+registerAmountHi], dx
	ja	short l_notEnough
	jb	short l_removeGold
	cmp	[bp+registerAmountLo], ax
	ja	short l_notEnough

l_removeGold:
	mov	ax, [bp+registerAmountLo]
	mov	dx, [bp+registerAmountHi]
	mov	cx, ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	sub	word ptr gs:party.gold[bx], cx
	sbb	word ptr gs:(party.gold+2)[bx], dx
	jmp	short l_setReturnValue

l_notEnough:
	PUSH_OFFSET(s_youDontHaveEnoughGold)
	PRINTSTRING
	DELAY(3)

l_setReturnValue:
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	mov	ax, g_vm_registers[bx]
	cwd
	cmp	dx, [bp+memberGoldHi]
	ja	short l_returnZero
	jb	short l_returnOne
	cmp	ax, [bp+memberGoldLo]
	ja	short l_returnZero

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifGiveGold endp
