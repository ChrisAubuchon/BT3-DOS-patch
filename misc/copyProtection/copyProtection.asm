; Attributes: bp-based frame

copyProtection proc	far

	resultHigh= word ptr -14Ch
	inputString= word ptr -14Ah
	var_136= word ptr -136h
	random16_3= word ptr -134h
	stringBufferP= word ptr -132h
	var_12E= word ptr -12Eh
	var_12C= word ptr -12Ch
	stringBuffer= word ptr -12Ah
	random16_1= word ptr -2Ah
	loopCounter=	word ptr -28h
	var_26=	word ptr -26h
	resultLow=	word ptr -24h
	random16_2= word ptr -22h
	resultLength=	word ptr -20h
	cpString=	word ptr -1Eh
	var_A= word ptr	-0Ah
	random16_4= word ptr -6
	var_4= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER(14Ch)
	push	si

	CALL(random)
	and	ax, 0Fh
	mov	[bp+random16_1], ax
	CALL(random)
	and	ax, 0Fh
	mov	[bp+random16_2], ax
	CALL(random)
	and	ax, 0Fh
	mov	[bp+random16_3], ax
	CALL(random)
	and	ax, 0Fh
	mov	[bp+random16_4], ax

	mov	bx, ax
	mov	al, byte_4CA18[bx]
	sub	ah, ah
	mov	[bp+var_A], ax			; var_A = byte_4CA18[random16_4]
	mov	cl, 4
	shr	ax, cl
	mov	[bp+var_136], ax		; var_136 = var_A >> 4

	mov	al, byte ptr [bp+random16_4]
	xor	al, byte ptr [bp+random16_1]
	test	al, 1				; if ((random16_1 ^ random16_4) & 1)
	jz	short loc_2712B
	mov	ax, [bp+var_A]
	and	ax, 7
	shl	ax, 1
	mov	cx, [bp+random16_2]
	and	cx, 1
	or	ax, cx				
	mov	[bp+var_12E], ax		;   var_12E = (((var_A & 7) << 1) | (random16_2 & 1))

	mov	bx, ax
	mov	al, byte_4CA28[bx]
	sub	ah, ah
	add	ax, [bp+random16_1]
	sub	ax, [bp+var_136]
	and	ax, 0Fh
	mov	[bp+random16_2], ax		;   random16_2 = (byte_4CA28[var_12E] + random16_1 - var_136) & 0Fh
						; endif
loc_2712B:
	mov	ax, [bp+var_A]
	and	ax, 7
	shl	ax, 1
	mov	[bp+var_12E], ax		; var_12E = ((var_A & 7) << 1)

	mov	ax, [bp+random16_2]
	sub	ax, [bp+random16_1]
	add	ax, [bp+var_136]
	and	ax, 0Fh
	mov	[bp+var_12C], ax		; var_12C = (random16_2 - random16_1 + var_136) & 0Fh

	mov	bx, [bp+var_12E]
	mov	al, byte_4CA28[bx]
	sub	ah, ah
	cmp	ax, [bp+var_12C]
	jz	short loc_27162			; if (byte_4CA28[var_12E] == var_12C) var_26 = 1
	mov	al, byte_4CA28[bx + 1]
	cmp	ax, [bp+var_12C]		; if (byte_4CA28[var_12E+1] == var_12C) var_26 = 1
	jnz	short loc_27167			; else var_26 = 0
loc_27162:
	mov	ax, 1
	jmp	short loc_27169
loc_27167:
	sub	ax, ax
loc_27169:
	mov	[bp+var_26], ax
	or	ax, ax
	jz	short loc_2717F			; if var_26 != 0
	mov	ax, [bp+random16_3]
	sub	ax, [bp+random16_1]
	mov	cl, 4
	shl	ax, cl
	or	al, 8
	jmp	short loc_27189			;   var_4 = ((random16_3 - random16_1) << 4) | 8

loc_2717F:					; else
	mov	ax, [bp+random16_2]
	sub	ax, [bp+random16_1]
	mov	cl, 4
	shl	ax, cl				;   var_4 = (random16_2 - random16_1) << 4

loc_27189:
	mov	[bp+var_4], ax
	mov	al, byte ptr [bp+var_4]
	add	al, byte ptr [bp+var_A]
	sub	ah, ah
	mov	[bp+var_2], ax			; var_2 = var_4 + var_A

	mov	ah, byte ptr [bp+var_2]
	sub	al, al
	add	ax, [bp+var_2]
	mov	[bp+resultLow], ax			; resultLow = (var_2 << 8) + var_2

	mov	[bp+loopCounter], 0Fh		; loopCounter = 0Fh
loc_271A9:					; do {
	mov	ax, [bp+resultLow]
	and	ax, 1
	mov	[bp+var_4], ax			;   var_4 = resultLow & 1
	shr	[bp+resultLow], 1			;   resultLow >> 1
	or	ax, ax				;   if var_4 != 0
	jz	short loc_271C6			;     resultLow += 0B400
	add	byte ptr [bp+resultLow+1], 0B4h
loc_271C6:
	dec	[bp+loopCounter]			; } while (--loopCounter > 0)
	cmp	[bp+loopCounter], 0
	jg	short loc_271A9

loc_271C8:
	mov	al, byte ptr [bp+resultLow+1]
	sub	ah, ah
	mov	[bp+resultHigh], ax
	mov	ax, [bp+var_2]
	and	ax, 7
	mov	si, ax
	shr	si, 1
	mov	al, g_copyProtectionLengthMask[si]
	sub	ah, ah
	and	[bp+resultHigh], ax
	mov	ax, si
	xor	al, 3
	mov	[bp+resultLength], ax


	; Zero 20 bytes of cpString
	mov	[bp+loopCounter], 0
loc_271F3:
	mov	si, [bp+loopCounter]
	mov	byte ptr [bp+si+cpString], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 20
	jl	short loc_271F3

	mov	[bp+loopCounter], 0

	mov	ax, [bp+resultHigh]
	mov	cl, 7
	shr	ax, cl
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+loopCounter]
	inc	[bp+loopCounter]
	mov	byte ptr [bp+si+cpString], al			; cpString[0] = ((resultHigh >> 7) & 7) | 0x30

	mov	ax, [bp+resultHigh]
	mov	cl, 4
	shr	ax, cl
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+loopCounter]
	inc	[bp+loopCounter]
	mov	byte ptr [bp+si+cpString], al			; cpString[1] = ((resultHigh >> 4) & 7) | 0x30

	mov	ax, [bp+resultHigh]
	shr	ax, 1
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+loopCounter]
	inc	[bp+loopCounter]
	mov	byte ptr [bp+si+cpString], al			; cpString[2] = ((resultHigh >> 1) & 7) | 0x30

	mov	ax, [bp+resultLow]
	mov	cl, 6
	shr	ax, cl
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+loopCounter]
	inc	[bp+loopCounter]
	mov	byte ptr [bp+si+cpString], al			; cpString[3] = ((resultLow >> 6) & 7) | 0x30

	mov	ax, [bp+resultLow]
	mov	cl, 3
	shr	ax, cl
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+loopCounter]
	inc	[bp+loopCounter]
	mov	byte ptr [bp+si+cpString], al			; cpString[4] = ((resultLow >> 3) & 7 | 0x30

	push	[bp+resultLow]
	CALL(cp_toDigit, near)
	mov	si, [bp+loopCounter]
	inc	[bp+loopCounter]
	mov	byte ptr [bp+si+cpString], al			; cpString[5] = (resultLow & 7) | 0x30

	PUSH_OFFSET(s_copyProtectIntro)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	mov	bx, [bp+random16_1]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationOne+2)[bx]
	push	word ptr g_cpLocationOne[bx]
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_OFFSET(s_commaSpace)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	mov	bx, [bp+random16_2]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationTwo+2)[bx]
	push	word ptr g_cpLocationTwo[bx]
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_OFFSET(s_commaSpace)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	mov	bx, [bp+random16_3]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationThree+2)[bx]
	push	word ptr g_cpLocationThree[bx]
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_OFFSET(s_commaCapitalAnd)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	mov	bx, [bp+random16_4]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationFour+2)[bx]
	push	word ptr g_cpLocationFour[bx]
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_OFFSET(s_period)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	ax, 10h
	push	ax
	PUSH_STACK_ADDRESS(inputString)
	CALL(readString)

	push	[bp+resultLength]
	PUSH_STACK_ADDRESS(cpString)
	PUSH_STACK_ADDRESS(inputString)
	CALL(cp_compareStrings, near)

	pop	si
	FUNC_EXIT
	retf
copyProtection endp
