; Attributes: bp-based frame
snd_toggle proc	far
	FUNC_ENTER
	CHKSTK

	cmp	g_soundActiveFlag, 1
	sbb	ax, ax
	neg	ax
	mov	g_soundActiveFlag, ax
	push	ax
	CALL(sub_27E05, 2)

	FUNC_EXIT
	retf
snd_toggle endp
