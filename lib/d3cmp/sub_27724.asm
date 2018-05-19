undefine(`CALL')

sub_27724 proc near
	cmp	dl, 8
	jbe	short loc_27733
loc_27729:
	xor	ax, ax
	shl	di, 1
	adc	ax, 0
	dec	dl
	retn
loc_27733:
	mov	si, d3cmp_workBufIndex
	xor	ax, ax
	test	si, 80h
	jnz	short loc_27759
loc_2773F:
	mov	al, byte ptr d3cmp_workBuf[si]
	inc	d3cmp_workBufIndex
	mov	cl, 8
	sub	cl, dl
	shl	ax, cl
	or	di, ax
	add	dl, 8
	test	cl, 8
	jz	short loc_27729
	jmp	short loc_27733
loc_27759:
	call	d3cmp_readData
	xor	si, si
	jmp	short loc_2773F
sub_27724 endp
