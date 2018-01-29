; Attributes: bp-based frame

mfunc_ifIsClass	proc far

	desiredClass= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(2)

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+desiredClass], ax

	CHARINDEX(ax, gs:g_userSlotNumber, bx)
	mov	al, gs:party.class[bx]
	sub	ah, ah
	cmp	ax, [bp+desiredClass]
	jnz	short l_setToZero
	mov	ax, 1
	jmp	short l_return

l_setToZero:
	sub	ax, ax

l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifIsClass	endp
