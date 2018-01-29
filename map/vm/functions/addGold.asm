; Attributes: bp-based frame

mfunc_addGold proc far

	dataP= dword ptr  6

	FUNC_ENTER
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	bx, ax
	shl	bx, 1
	mov	ax, g_vm_registers[bx]
	cwd
	mov	cx, ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	add	word ptr gs:party.gold[bx], cx
	adc	word ptr gs:(party.gold+2)[bx], dx
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_addGold endp
