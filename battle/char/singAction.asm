; Attributes: bp-based frame

bat_charSingAction proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	text_clear
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	call	song_getSong
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1D6AE
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
loc_1D6AE:
	cmp	[bp+var_2], 0
	jl	short loc_1D6B9
	mov	ax, 1
	jmp	short loc_1D6BB
loc_1D6B9:
	sub	ax, ax
loc_1D6BB:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_charSingAction endp
