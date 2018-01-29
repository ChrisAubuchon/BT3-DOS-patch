; Attributes: bp-based frame

mfunc_addMonster proc far

	monsterIndex= word ptr	-4
	slotNumber= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(4)
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+monsterIndex], ax

	CALL(party_findEmptySlot)
	mov	[bp+slotNumber], ax
	cmp	ax, 7
	jge	short l_setReturnValue

	MONINDEX(ax, STACKVAR(monsterIndex), bx)
	lea	ax, monsterBuf[bx]
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+slotNumber]
	CALL(_sp_convertMonToSummon)
	mov	byte ptr g_printPartyFlag,	0

l_setReturnValue:
	cmp	[bp+slotNumber], 7
	jge	short l_returnZero
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if)
	FUNC_EXIT
	retf
mfunc_addMonster endp
