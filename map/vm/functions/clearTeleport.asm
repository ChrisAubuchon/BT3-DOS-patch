; Attributes: bp-based frame

mfunc_clearTeleport proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	mov	ax, 0FEh
	push	ax
	CALL(bigpic_drawPictureNumber)
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mfunc_teleport, near)
	FUNC_EXIT
	retf
mfunc_clearTeleport endp
