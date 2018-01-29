; Replace the opcode at	*dataP with 0xff effectively
; removing the code from the level. Used so the	party
; only runs the	code at	the current square once	per
; level.
; Attributes: bp-based frame

mfunc_clearSpecial proc far

	destinationP= dword ptr -4
	dataP= dword ptr 6

	FUNC_ENTER(4)
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(map_getDataOffsetP)
	mov	word ptr [bp+destinationP], ax
	mov	word ptr [bp+destinationP+2], dx
	lfs	bx, [bp+destinationP]
	mov	byte ptr fs:[bx], 0FFh
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	add	ax, 2
	FUNC_EXIT
	retf
mfunc_clearSpecial endp
