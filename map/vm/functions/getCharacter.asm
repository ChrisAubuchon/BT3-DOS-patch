; Attributes: bp-based frame
mfunc_getCharacter proc	far

	slotNumber= word ptr	-2
	dataP= dword ptr	 6

	FUNC_ENTER(2)
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	short loc_1A4CA
	mov	al, byte ptr [bp+slotNumber]
	mov	gs:g_userSlotNumber, al
loc_1A4CA:
	cmp	[bp+slotNumber], 0
	jl	short l_returnZero
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
mfunc_getCharacter endp
