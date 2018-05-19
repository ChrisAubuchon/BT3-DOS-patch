huf_init proc far

	fileHandle= word ptr	 6

	push	bp
	mov	bp, sp
	push	ds
	push	si
	push	di
	push	es
	mov	ax, seg	seg020
	mov	ds, ax
	assume ds:seg020
	mov	bx, [bp+fileHandle]
	mov	huf_fileHandle, bx
	mov	ah, 3Fh	
	mov	dx, offset huf_fileBuffer
	mov	cx, 200h
	int	21h		; BX = file handle, CX = number	of bytes to read
				; DS:DX	-> buffer
	mov	si, offset huf_fileBuffer
	lodsw
	mov	dx, ax
	lodsw
	xchg	al, ah
	xchg	dl, dh
	mov	word ptr huf_dataSize, ax
	mov	word ptr huf_dataSize+2, dx
	mov	huf_nodeListTail, 0
	add	si, 4
	lodsb
	mov	huf_fileBufferIndex, si
	mov	huf_bitMask, 80h
	mov	huf_currentByte, al
	mov	ax, offset huf_treeData
	push	ax
	CALL(huf_expandTree)
	pop	es
	pop	di
	pop	si
	pop	ds
	assume ds:dseg
	pop	bp
	retf
huf_init endp
