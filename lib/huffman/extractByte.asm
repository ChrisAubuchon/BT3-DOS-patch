huf_extractByte proc near
	mov	bp, 8

loc_275CE:
	shl	di, 1
	CALL(huf_getNextBit)
	jz	short loc_275D8
	or	di, 1

loc_275D8:
	dec	bp

	jnz	short loc_275CE
	mov	ax, di
	retn
huf_extractByte endp
