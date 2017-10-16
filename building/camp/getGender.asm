; Attributes: bp-based frame
getCharacterGender proc	far

	func_enter

loc_loop_start:
	push_ds_string	aDoYouWishYourC
	std_call	printStringWClear, 4

	mov	ax, 0Ch
	push	ax
	std_call	getKey, 2

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
	mov	sp, bp
	pop	bp
	retf
getCharacterGender endp
