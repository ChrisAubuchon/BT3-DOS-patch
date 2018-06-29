; Attributes: bp-based frame

random_1d8	proc far
	FUNC_ENTER

	CALL(random)
	and	ax, 7
	inc	ax
	FUNC_EXIT
	retf
random_1d8	endp
