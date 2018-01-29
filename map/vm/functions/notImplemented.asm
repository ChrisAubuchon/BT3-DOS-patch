; Attributes: bp-based frame

mfunc_notImplemented proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	PUSH_OFFSET(s_notImplemented)
	PRINTSTRING
	IOWAIT
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_notImplemented endp
