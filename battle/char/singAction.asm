; Attributes: bp-based frame

bat_charSingAction proc far

	songNumber= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)

	CALL(text_clear)

	sub	ax, ax
	push	ax
	push	[bp+slotNumber]
	CALL(song_getSong)
	mov	[bp+songNumber], ax
	or	ax, ax
	jl	short l_returnZero

	mov	al, byte ptr [bp+songNumber]
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharActionTarget[bx], al

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_charSingAction endp
