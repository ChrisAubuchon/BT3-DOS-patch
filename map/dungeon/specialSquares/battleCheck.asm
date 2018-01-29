; Attributes: bp-based frame

dunsq_battleCheck proc far

	var_2= word ptr	-2

	FUNC_ENTER(2)

	CALL(random)
	and	ax, 80h
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_24DA7
	inc	byte_4EECC

	; Add code to mask the encounter out
	mov	ax, 7Fh
	push	ax
	mov	ax, 2
	push	ax
	push	sq_east
	push	sq_north
	CALL(dun_maskSquare)

loc_24DA7:
	mov	ax, [bp+var_2]
	FUNC_EXIT
	retf
dunsq_battleCheck endp

