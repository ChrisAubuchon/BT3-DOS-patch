sub_27632 proc near
	mov	si, d3cmp_workBufIndex
	xor	ax, ax
	test	si, 80h
	jnz	short loc_27647
loc_2763E:
	mov	al, byte ptr d3cmp_workBuf[si]
	inc	d3cmp_workBufIndex
	retn
loc_27647:
	call	d3cmp_readData
	xor	si, si
	jmp	short loc_2763E
sub_27632 endp
