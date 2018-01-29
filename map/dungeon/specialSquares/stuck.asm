; Attributes: bp-based frame

dunsq_doStuck proc far
	FUNC_ENTER
	CALL(random)
	and	al, 3
	mov	gs:stuckFlag, al
	sub	ax, ax
	FUNC_EXIT
	retf
dunsq_doStuck endp
