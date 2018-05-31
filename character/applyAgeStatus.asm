; Attributes: bp-based frame

character_applyAgeStatus proc far

	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	jmp	short loc_1E89E
loc_1E89B:
	dec	[bp+arg_8]
loc_1E89E:
	cmp	[bp+arg_8], 0
	jl	short loc_1E8BF
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	fs:[bx], al
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 1
	jmp	short loc_1E89B
loc_1E8BF:
	mov	sp, bp
	pop	bp
	retf
character_applyAgeStatus endp
