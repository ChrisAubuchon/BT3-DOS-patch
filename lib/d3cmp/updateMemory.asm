d3cmp_updateMemory proc	near
	push	bp
	push	ax
	push	di
	cmp	word_4D12F, 8000h
	jnz	short loc_27699
	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di
	push	ds
	push	es
	push	bp
	call	sub_27980
	pop	bp
	pop	es
	pop	ds
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
loc_27699:
	mov	si, ax
	shl	si, 1
	mov	bp, word_4D619[si]
loc_276A1:
	mov	cx, bp
	shl	bp, 1
	inc	ds:word_4CC4B[bp]
	mov	si, ds:word_4CC4B[bp]
	mov	bx, cx
	inc	bx
	shl	bx, 1
	cmp	word_4CC4B[bx],	si
	jb	short loc_276BE
	mov	bx, bp
	jmp	short loc_27716
loc_276BE:
	add	bx, 2
	cmp	si, word_4CC4B[bx]
	ja	short loc_276BE
	sub	bx, 2
	mov	ax, word_4CC4B[bx]
	mov	di, cx
	shl	di, 1
	mov	word_4CC4B[di],	ax
	mov	word_4CC4B[bx],	si
	mov	si, word_4D88D[di]
	shl	si, 1
	shr	bx, 1
	mov	word_4D133[si], bx
	cmp	si, 1254
	jge	short loc_276F0
	mov	word_4D133[si+2], bx
loc_276F0:
	shl	bx, 1
	mov	di, word_4D88D[bx]
	shl	di, 1
	shr	si, 1
	mov	word_4D88D[bx],	si
	mov	word_4D133[di], cx
	cmp	di, 4E6h
	jge	short loc_2770C
	mov	word_4D133[di+2], cx
loc_2770C:
	mov	si, cx
	shl	si, 1
	shr	di, 1
	mov	word_4D88D[si],	di
loc_27716:
	mov	bp, word_4D133[bx]
	or	bp, bp
	jz	short loc_27720
	jmp	short loc_276A1
loc_27720:
	pop	di
	pop	ax
	pop	bp
	retn
d3cmp_updateMemory endp
