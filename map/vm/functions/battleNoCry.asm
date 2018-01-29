; Attributes: bp-based frame

mfunc_battleNoCry proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	mov	gs:byte_4228B, 1
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mfunc_battle, near)
	FUNC_EXIT
	retf
mfunc_battleNoCry endp
