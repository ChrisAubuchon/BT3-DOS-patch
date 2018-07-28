; Attributes: bp-based frame

dun_detectSquares proc far

	aheadFlags= word ptr -6
	detectIndex= word ptr	-2
	sqE= word ptr  6
	sqN= word ptr  8
	direction= word ptr  0Ah

	FUNC_ENTER(6)
	push	si

	; Return if detect spell not active
	cmp	detectDuration, 0
	jz	l_return

	; Return if current square and direction are the same as
	; the last time this function was run.
	;
	mov	al, gs:g_lastDetectSqE
	sub	ah, ah
	cmp	ax, [bp+sqE]
	jnz	short loc_256DB
	mov	al, gs:g_lastDetectSqN
	cmp	ax, [bp+sqN]
	jnz	short loc_256DB
	mov	al, gs:g_lastDetectDirection
	cmp	ax, [bp+direction]
	jz	l_return

loc_256DB:
	; Set the last detection variables
	mov	al, byte ptr [bp+sqE]
	mov	gs:g_lastDetectSqE, al
	mov	al, byte ptr [bp+sqN]
	mov	gs:g_lastDetectSqN, al
	mov	al, byte ptr [bp+direction]
	mov	gs:g_lastDetectDirection, al

	PUSH_STACK_ADDRESS(aheadFlags)
	push	[bp+sqN]
	push	[bp+sqE]
	CALL(detect_getSquares, near)
	mov	bl, g_detectType
	sub	bh, bh
	mov	al, g_detectStartList[bx]
	cbw
	mov	[bp+detectIndex], ax

l_loop:
	mov	bx, [bp+detectIndex]
	mov	al, g_detectByte[bx]
	sub	ah, ah
	cmp	ax, 0FFh
	jge	short l_return
	mov	si, ax
	mov	al, byte ptr [bp+si+aheadFlags]
	cbw
	mov	cl, g_detectMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next

	mov	bx, [bp+detectIndex]
	mov	al, g_detectMessageIndex[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (detectMessages+2)[bx]
	push	word ptr detectMessages[bx]
	PRINTSTRING
l_next:
	inc	[bp+detectIndex]
	jmp	short l_loop

l_return:
	pop	si
	FUNC_EXIT
	retf
dun_detectSquares endp
