sub_27980 proc near
	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di
	push	ds
	push	es
	push	bp
	mov	word_4EE4A, 0
	mov	word_4EE48, 0
loc_27995:
	mov	si, word_4EE48
	shl	si, 1
	cmp	word_4D88D[si],	273h
	jl	short loc_279C0
	mov	di, word_4EE4A
	shl	di, 1
	mov	ax, word_4CC4B[si]
	inc	ax
	shr	ax, 1
	mov	word_4CC4B[di],	ax
	mov	ax, word_4D88D[si]
	mov	word_4D88D[di],	ax
	inc	word_4EE4A
loc_279C0:
	inc	word_4EE48
	cmp	word_4EE48, 273h
	jl	short loc_27995
	mov	word_4EE48, 0
	mov	word_4EE4A, 13Ah
	jmp	short loc_27A52
loc_279DA:
	dec	word_4EE4C
loc_279DE:
	mov	bx, word_4EE4C
	shl	bx, 1
	mov	ax, word_4EE4E
	cmp	word_4CC4B[bx],	ax
	ja	short loc_279DA
	inc	word_4EE4C
	mov	cx, word_4EE4A
	sub	cx, word_4EE4C
	shl	cx, 1
	mov	word_4EE50, cx
	std
	mov	di, word_4EE4C
	shl	di, 1
	add	di, offset word_4CC4B
	add	di, cx
	shr	cx, 1
	mov	si, di
	sub	si, 2
	rep movsw
	mov	si, word_4EE4C
	shl	si, 1
	mov	ax, word_4EE4E
	mov	word_4CC4B[si],	ax
	mov	cx, word_4EE50
	mov	di, word_4EE4C
	shl	di, 1
	add	di, word_4D88D
	add	di, cx
	shr	cx, 1
	mov	si, di
	sub	si, 2
	rep movsw
	cld
	mov	bx, word_4EE4C
	shl	bx, 1
	mov	ax, word_4EE48
	mov	word_4D88D[bx],	ax
	add	word_4EE48, 2
	inc	word_4EE4A
loc_27A52:
	cmp	word_4EE4A, 273h
	jge	short loc_27A8C
	mov	ax, word_4EE48
	inc	ax
	mov	word_4EE4C, ax
	mov	bx, word_4EE4A
	shl	bx, 1
	mov	si, word_4EE48
	shl	si, 1
	mov	ax, word_4CC4B[si]
	mov	si, word_4EE4C
	shl	si, 1
	add	ax, word_4CC4B[si]
	mov	word_4CC4B[bx],	ax
	mov	word_4EE4E, ax
	mov	ax, word_4EE4A
	dec	ax
	mov	word_4EE4C, ax
	jmp	loc_279DE
loc_27A8C:
	mov	word_4EE48, 0
	jmp	short loc_27AA9
loc_27A94:
	mov	si, word_4EE4C
	shl	si, 1
	mov	ax, word_4EE48
	mov	word_4D133[si+2], ax
	mov	word_4D133[si], ax
loc_27AA5:
	inc	word_4EE48
loc_27AA9:
	cmp	word_4EE48, 273h
	jge	short loc_27AD0
	mov	bx, word_4EE48
	shl	bx, 1
	mov	ax, word_4D88D[bx]
	mov	word_4EE4C, ax
	cmp	ax, 273h
	jl	short loc_27A94
	mov	bx, ax
	shl	bx, 1
	mov	ax, word_4EE48
	mov	word_4D133[bx], ax
	jmp	short loc_27AA5
loc_27AD0:
	pop	bp
	pop	es
	pop	ds
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	retn
sub_27980 endp
