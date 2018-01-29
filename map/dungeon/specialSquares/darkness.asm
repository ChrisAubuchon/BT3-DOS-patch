; Attributes: bp-based frame

dunsq_doDarkness proc far
	FUNC_ENTER

	cmp	lightDuration, 0
	jz	short l_checkLightSong
	sub	ax, ax
	push	ax
	CALL(icon_deactivate)
l_checkLightSong:
	mov	lightDistance, 0
	cmp	gs:g_currentSongPlusOne, 0
	jz	short l_return
	cmp	gs:g_currentSong, 5
	jnz	short l_return
	CALL(endNoncombatSong)

l_return:
	PUSH_OFFSET(s_darkness)
	PRINTSTRING(true)
	sub	ax, ax

	FUNC_EXIT
	retf
dunsq_doDarkness endp
