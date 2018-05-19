huf_flate	proc far

	bufferP= dword ptr  6
	maxSize= word ptr	 0Ah

	push	bp
	mov	bp, sp
	push	es
	push	ds
	mov	ax, seg	seg020
	mov	ds, ax
	assume ds:seg020
	push	si
	push	di

	les	di, [bp+bufferP]
	mov	huf_bufferP, di
	mov	bx, [bp+maxSize]
	mov	huf_flateSize, bx
	mov	ax, word ptr huf_dataSize
	mov	dx, word ptr huf_dataSize+2
	sub	cx, cx
	sub	bx, ax
	sbb	cx, dx
	jl	short l_skipFixSize
	mov	huf_flateSize, ax		; Set flateSize to huf_dataSize 
						; if huf_dataSize < huf_flateSize
l_skipFixSize:
	mov	huf_flateByteCount, 0

loc_274CA:
	mov	ax, huf_flateSize
	cmp	ax, huf_flateByteCount
	jz	short l_return

	mov	di, offset huf_treeData

loc_274D6:
	cmp	word ptr [di], 0
	jz	short loc_274F8

	mov	ax, word ptr huf_bitMask
	or	al, al
	jz	short l_getNextByte

loc_274E2:
	and	ah, al
	shr	al, 1
	mov	huf_bitMask, al
	mov	al, ah
	or	al, al
	jnz	short loc_274F3

	mov	di, [di]
	jmp	short loc_274D6

loc_274F3:
	mov	di, [di+2]
	jmp	short loc_274D6

loc_274F8:
	mov	al, [di+4]
	mov	di, huf_bufferP
	stosb
	mov	huf_bufferP, di
	inc	huf_flateByteCount
	jmp	short loc_274CA

l_return:
	sub	word ptr huf_dataSize, ax
	sbb	word ptr huf_dataSize+2, 0
	pop	di
	pop	si
	pop	ds
	assume ds:dseg
	pop	es
	pop	bp
	retf

l_getNextByte:
	mov	si, ds:huf_fileBufferIndex
	cmp	si, offset huf_fileBufferIndex
	jz	short l_nextFileBuffer
	lodsb
	mov	ds:huf_currentByte, al
	mov	ds:huf_fileBufferIndex, si
	mov	ah, 80h
	xchg	al, ah
	jmp	short loc_274E2

l_nextFileBuffer:
	mov	ah, 3Fh	
	mov	bx, ds:huf_fileHandle
	mov	cx, 200h
	mov	dx, offset huf_fileBuffer
	int	21h	; DOS -	2+ - call(read) FROM FILE WITH HANDLE
			; BX = file handle, CX = number	of bytes to read
			; DS:DX	-> buffer
	mov	si, dx
	lodsb
	mov	ah, 80h
	mov	ds:huf_fileBufferIndex, si
	mov	ds:huf_currentByte, al
	xchg	al, ah
	jmp	short loc_274E2
huf_flate	endp
