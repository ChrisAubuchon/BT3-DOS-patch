; Attributes: bp-based frame

d3cmp_flate proc far

	srcP	= dword ptr 6
	destP	= dword ptr 0Ah

	push	bp
	mov	bp, sp
	push	di
	push	si
	push	ds
	push	es
	mov	ax, seg	dseg
	mov	ds, ax

	mov	ax, word ptr [bp+srcP]
	mov	word ptr d3cmp_srcP, ax

	mov	ax, word ptr [bp+srcP+2]
	mov	word ptr d3cmp_srcP+2,	ax

	mov	ax, word ptr [bp+destP]
	mov	word ptr d3cmp_destP+2, ax

	mov	ax, word ptr [bp+destP+2]
	mov	word ptr d3cmp_destP, ax

	mov	ax, word ptr d3cmp_srcP+2
	mov	es, ax
	mov	di, word ptr d3cmp_srcP
	mov	ax, es:[di]
	mov	word ptr dataHeader, ax
	mov	ax, es:[di+2]
	mov	word ptr dataHeader+2, ax
	add	word ptr d3cmp_srcP, 4

	; Initialize d3comp_outputBuffer array to ' '
	mov	ax, ds
	mov	es, ax
	assume es:dseg
	mov	di, offset d3comp_outputBuffer
	mov	cx, 4155
	mov	al, 20h	
	rep stosb

	xor	di, di
	CALL(d3cmp_readData)
	CALL(d3cmp_doDecomp)
	pop	es
	assume es:nothing
	pop	ds
	pop	si
	pop	di
	pop	bp
	retf
d3cmp_flate endp
