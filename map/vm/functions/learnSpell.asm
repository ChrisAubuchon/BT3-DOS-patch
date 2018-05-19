; Attributes: bp-based frame

mfunc_learnSpell proc far

	dataP= dword ptr  6

	FUNC_ENTER
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	mov	al, gs:g_userSlotNumber
	push	ax
	CALL(character_learnSpell)
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_learnSpell endp
