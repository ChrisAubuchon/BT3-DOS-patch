; Attributes: bp-based frame
getCharacterGender proc	far

	func_enter

loc_loop_start:
	PUSH_OFFSET(s_genderOptions)
	PRINTSTRING(true)

	mov	ax, 0Ch
	push	ax
	CALL(getKey)

	cmp	ax, 1Bh
	jz	loc_return_ff

	cmp	ax, 'F'
	jz	loc_return_one
	cmp	ax, 111h
	jz	loc_return_one

	cmp	ax, 'M'
	jz	loc_return_zero
	cmp	ax, 110h
	jnz	loc_loop_start
	
loc_return_zero:
	xor	ax, ax
	jmp	loc_exit

loc_return_one:
	mov	ax, 1
	jmp	loc_exit

loc_return_ff:
	mov	ax, 0FFh

loc_exit:
	FUNC_EXIT
	retf
getCharacterGender endp
