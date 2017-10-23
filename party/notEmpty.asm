; This function	returns	1 if roster slot zero
; is occupied. Zero otherwise
; Attributes: bp-based frame

party_isNotEmpty	proc far
	FUNC_ENTER
	cmp	gs:party._name, 1
	sbb	ax, ax
	inc	ax
	FUNC_EXIT
	retf
party_isNotEmpty	endp

