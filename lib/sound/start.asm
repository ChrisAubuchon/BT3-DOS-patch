; Attributes: bp-based frame

sound_start proc far

	_segment= word ptr  8
	arg_4= word ptr	 0Ah

	FUNC_ENTER
	mov	cx, [bp+_segment]
	mov	ax, [bp+arg_4]
	and	al, 3
	mov	ah, 1
	call	music_driver
	FUNC_EXIT(false)
	retf
sound_start endp
