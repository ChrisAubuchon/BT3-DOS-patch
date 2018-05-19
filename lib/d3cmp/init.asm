d3cmp_init proc	near
	push	bp
	push	di
	push	si
	xor	si, si				
	mov	bp, 2

loc_27868:					 
	mov	cx, si				; for (i = 0; i < 314; i++) {
	shr	cx, 1				;
	mov	word_4CC4B[si],	1		;	word_4CC4B[i] = 1
	mov	di, cx
	add	di, 627				;
	mov	word_4D88D[si],	di		; 	word_4D88D[i] = i + 627
	shl	di, 1
	mov	word_4D133[di], cx		;	word_4D133[i+627] = i
	add	si, bp
	cmp	si, 628
	jl	short loc_27868

	xor	di, di
	mov	bx, 628
loc_2788F:
	mov	ax, word_4CC4B[di]
	add	ax, word_4CC4B[di+2]
	mov	word_4CC4B[bx],	ax
	shr	di, 1
	mov	word_4D88D[bx],	di
	shl	di, 1
	shr	bx, 1
	mov	word_4D133[di], bx
	mov	word_4D133[di+2], bx
	shl	bx, 1
	add	di, 4
	add	bx, bp
	cmp	bx, 1252
	jle	short loc_2788F
	mov	word_4D131, 0FFFFh
	mov	word_4D617, 0
	pop	si
	pop	di
	pop	bp
	retn
d3cmp_init endp
