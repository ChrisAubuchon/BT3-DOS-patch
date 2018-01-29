; Attributes: bp-based frame

mfunc_waitForIo proc far

	arg_0= dword ptr 6

	FUNC_ENTER
	IOWAIT
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_waitForIo endp
