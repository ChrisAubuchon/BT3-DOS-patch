; Attributes: bp-based frame

dunsq_regenHP proc far
	FUNC_ENTER
	inc	gs:sqRegenHPFlag
	FUNC_EXIT
	retf
dunsq_regenHP endp
