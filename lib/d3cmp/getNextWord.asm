; This function extracts the next data element from the source
; buffer.
;
d3cmp_getNextWord proc near
	mov	bx, word_4DD71

loc_27791:
	shl	bx, 1
	cmp	bx, 1254
	jnb	short loc_277B1

	cmp	dl, 8
	jbe	short l_updateDataWord

loc_2779E:
	xor	ax, ax
	shl	di, 1
	adc	ax, 0
	dec	dl
	shl	ax, 1
	add	bx, ax
	mov	bx, word_4D88D[bx]
	jmp	short loc_27791

; ==============================================
; updateDataWord()
; ==============================================
l_updateDataWord:
	mov	si, d3cmp_workBufIndex
	xor	ax, ax
	test	si, 80h
	jnz	short loc_27786

loc_2776C:
	mov	al, byte ptr d3cmp_workBuf[si]
	inc	d3cmp_workBufIndex
	mov	cl, 8
	sub	cl, dl
	shl	ax, cl
	or	di, ax
	add	dl, 8
	test	cl, 8
	jz	short loc_2779E
	jmp	short l_updateDataWord

loc_27786:
	CALL(d3cmp_readData)
	xor	si, si
	jmp	short loc_2776C
; ==============================================
; updateDataWord() end
; ==============================================

loc_277B1:
	mov	ax, bx
	shr	ax, 1
	sub	ax, 627
	CALL(d3cmp_updateMemory)
	retn
d3cmp_getNextWord endp
