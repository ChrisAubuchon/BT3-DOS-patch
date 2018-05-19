huf_getNextBit	proc near
	mov	ax, word ptr ds:huf_bitMask
	or	al, al
	jz	short l_getNextByte

l_return:
	and	ah, al
	shr	al, 1
	mov	ds:huf_bitMask, al
	mov	al, ah
	or	al, al
	retn

l_getNextByte:
	mov	si, ds:huf_fileBufferIndex
	cmp	si, offset huf_fileBufferIndex
	jz	short l_readMoreData
	lodsb
	mov	byte ptr ds:huf_currentByte, al
	mov	ds:huf_fileBufferIndex, si
	mov	ah, 80h
	xchg	al, ah
	jmp	short l_return

l_readMoreData:
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
	mov	byte ptr ds:huf_currentByte, al
	xchg	al, ah
	jmp	short l_return
huf_getNextBit	endp
