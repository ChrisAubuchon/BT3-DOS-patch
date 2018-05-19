; Read 64 words from the source and write to the work buffer
;
; Resets d3cmp_workBufIndex
;
d3cmp_readData proc near
	push	es
	push	di
	push	cx
	push	si
	push	ax
	cld
	mov	ax, ds
	mov	es, ax
	assume es:dseg
	mov	di, offset d3cmp_workBuf
	mov	si, word ptr d3cmp_srcP
	add	word ptr d3cmp_srcP, 80h
	mov	ds, word ptr d3cmp_srcP+2
	mov	cx, 64
	rep movsw
	mov	ax, es
	mov	ds, ax
	mov	d3cmp_workBufIndex, 0
	pop	ax
	pop	si
	pop	cx
	pop	di
	pop	es
	assume es:nothing
	retn
d3cmp_readData endp
