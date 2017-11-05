; Attributes: bp-based frame

summon_maskSummonName proc far

	loopCounter= word ptr	-2
	destAddress= dword ptr  6
	srcAddress= dword ptr  0Ah

	FUNC_ENTER(2)
	push	si

	mov	[bp+loopCounter], 0
l_zeroLoop:
	mov	bx, [bp+loopCounter]
	lfs	si, [bp+destAddress]
	mov	byte ptr fs:[bx+si], 0FFh
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 10h
	jl	short l_zeroLoop

l_copyLoop:
	lfs	bx, [bp+srcAddress]
	cmp	byte ptr fs:[bx], 0
	jz	short l_return
	inc	word ptr [bp+srcAddress]
	mov	al, fs:[bx]
	or	al, 80h
	lfs	bx, [bp+destAddress]
	inc	word ptr [bp+destAddress]
	mov	fs:[bx], al
	jmp	short l_copyLoop

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
summon_maskSummonName endp
