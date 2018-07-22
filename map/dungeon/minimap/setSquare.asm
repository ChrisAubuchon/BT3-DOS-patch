; Attributes: bp-based frame

minimap_setSquare proc far

	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	FUNC_ENTER
	push	di
	push	si
	push	ds
	push	es
	mov	si, offset g_minimapCharacters
	les	di, [bp+arg_0]
	mov	ax, [bp+arg_4]
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	add	si, ax
	mov	cx, 8
loc_27E58:
	lodsb
	or	al, es:[di]
	stosb
	dec	cx
	jnz	short loc_27E58
	pop	es
	pop	ds
	assume ds:dseg
	pop	si
	pop	di
	FUNC_EXIT(false)
	retf
minimap_setSquare endp
