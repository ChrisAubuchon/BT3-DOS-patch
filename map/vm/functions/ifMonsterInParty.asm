; Attributes: bp-based frame
mfunc_ifMonsterInParty proc	far

	rval= word ptr	-4
	slotNumber= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(4)
	push	si

	mov	[bp+rval], 0
	mov	[bp+slotNumber], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_monster
	jnz	short l_next
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(vm_strcmp, near)
	or	ax, ax
	jz	short l_next
	mov	[bp+rval], 1
	jmp	short l_skipString

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_skipString:
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	cmp	byte ptr fs:[bx], 0FFh
	jnz	short l_skipString

	mov	al, byte ptr [bp+slotNumber]
	mov	gs:g_userSlotNumber, al
	push	[bp+rval]
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if)

	pop	si
	FUNC_EXIT
	retf
mfunc_ifMonsterInParty endp
