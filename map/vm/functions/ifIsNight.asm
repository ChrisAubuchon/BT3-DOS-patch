; Attributes: bp-based frame

mfunc_ifIsNight	proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	cmp	gs:isNight, 1
	sbb	ax, ax
	neg	ax
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifIsNight	endp
