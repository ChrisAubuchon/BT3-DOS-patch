; Attributes: bp-based frame
;
; Recursively reconstruct the Huffman tree
;
huf_expandTree	proc near

	arg_0= word ptr	 2

	CALL(huf_getNextBit)
	jnz	short loc_27576

	CALL(huf_newNode)
	mov	di, ax
	CALL(huf_newNode)
	mov	bp, sp
	mov	si, [bp+arg_0]
	mov	[si], di
	mov	[si+2],	ax
	push	ax
	push	di
	CALL(huf_expandTree)
	CALL(huf_getNextBit)
	CALL(huf_expandTree)
	retn

loc_27576:
	CALL(huf_extractByte)
	mov	bp, sp
	mov	si, [bp+arg_0]
	mov	[si+4],	al
	retn
huf_expandTree	endp
