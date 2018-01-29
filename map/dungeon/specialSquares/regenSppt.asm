; Attributes: bp-based frame

dunsq_regenSppt	proc far
	FUNC_ENTER
	inc	gs:regenSpptSq
	sub	ax, ax
	FUNC_EXIT
	retf
dunsq_regenSppt	endp
