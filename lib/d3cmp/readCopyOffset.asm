; This function uses the high byte of the current data
; word to determine the offset of the sequence that is
; to be repeated in d3cmp_outputBuffer
;
; A return value of 0 indicates that the previous
; byte is repeated
;

d3cmp_readCopyOffset proc near

; This section is common to several functions
; and updates the current data word stored in di
; ==============================================
; updateDataWord()
; ==============================================
	cmp	dl, 8
	ja	short loc_277EE
loc_277C1:
	mov	si, d3cmp_workBufIndex
	xor	ax, ax
	test	si, 80h
	jnz	short l_readData
loc_277CD:
	mov	al, byte ptr d3cmp_workBuf[si]
	inc	d3cmp_workBufIndex
	mov	cl, 8
	sub	cl, dl
	shl	ax, cl
	or	di, ax
	add	dl, 8
	test	cl, 8
	jz	short loc_277EE
	jmp	short loc_277C1
l_readData:
	CALL(d3cmp_readData)
	xor	si, si
	jmp	short loc_277CD
; ==============================================
; updateDataWord() end
; ==============================================

loc_277EE:
	; Extract 8 bits to index into byte_4CB3F
	sub	dl, 8			; subtract 8 from dataShift value
	mov	bx, di			; save original dataWord value
	xor	ax, ax			; clear ax
	xchg	bl, ah			; 
	mov	di, ax			; dataWord = (dataWord << 8)
	xchg	bh, bl			; bx = low 8 bits of original dataWord 
					; bx = index into byte_4CB3F & byte_4CA3F
					; arrays

	xor	cx, cx
	mov	ch, byte_4CB3F[bx]	; write byte_4CB3F value to high 8 bits
	shr	cx, 1
	shr	cx, 1
	push	cx			; Equivalent to cx = (byte_4CB3F[index] << 6)

	xor	cx, cx
	mov	cl, byte_4CA3F[bx]
	dec	cl
	dec	cl			; cx = (byte_4CA3F[index] - 2)
	jcxz	short l_return

loc_27812:
	shl	bx, 1
	xchg	dh, cl
	cmp	dl, 8
	jbe	short l_updateDataWord

loc_2781B:
	xor	ax, ax
	shl	di, 1
	adc	ax, 0
	dec	dl
	xchg	cl, dh
	add	bx, ax
	loop	loc_27812

l_return:
	pop	cx
	and	bx, 3Fh
	or	cx, bx
	mov	ax, cx
	retn

; ==============================================
; updateDataWord()
; ==============================================
l_updateDataWord:
	mov	si, d3cmp_workBufIndex
	xor	ax, ax
	test	si, 80h
	jnz	short loc_27859
loc_2783F:
	mov	al, byte ptr d3cmp_workBuf[si]
	inc	d3cmp_workBufIndex
	mov	cl, 8
	sub	cl, dl
	shl	ax, cl
	or	di, ax
	add	dl, 8
	test	cl, 8
	jz	short loc_2781B
	jmp	short l_updateDataWord

loc_27859:
	CALL(d3cmp_readData)
	xor	si, si
	jmp	short loc_2783F
; ==============================================
; updateDataWord() end
; ==============================================
d3cmp_readCopyOffset endp
