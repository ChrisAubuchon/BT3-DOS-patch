; Attributes: bp-based frame
dunsq_somethingOdd proc	far
	FUNC_ENTER
	sub	al, al
	mov	g_detectType, al
	mov	gs:g_detectSecretDoorFlag, al
	sub	ax, ax
	FUNC_EXIT
	retf
dunsq_somethingOdd endp
