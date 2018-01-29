; DWORD - var_130 & var_132
;
; Attributes: bp-based frame

copyProtection proc	far

	var_14C= word ptr -14Ch
	var_14A= word ptr -14Ah
	var_136= word ptr -136h
	random16_3= word ptr -134h
	var_132= word ptr -132h
	var_130= word ptr -130h
	var_12E= word ptr -12Eh
	var_12C= word ptr -12Ch
	var_12A= word ptr -12Ah
	random16_1= word ptr -2Ah
	var_28=	word ptr -28h
	var_26=	word ptr -26h
	var_24=	word ptr -24h
	random16_2= word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
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
	mov	[bp+var_12E], ax		;   var_12E = ((var_A & 7) << 1) | (random16_2 & 1))

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
	mov	[bp+var_24], ax			; var_24 = (var_2 & 0F0h) + var_2

	mov	[bp+var_28], 0Fh		; var_28 = 0Fh
loc_271A9:					; do {
	mov	ax, [bp+var_24]
	and	ax, 1
	mov	[bp+var_4], ax			;   var_4 = var_24 & 1
	shr	[bp+var_24], 1			;   var_24 >> 1
	or	ax, ax				;   if var_4 != 0
	jz	short loc_271C6			;     var_24 += 0B400
	add	byte ptr [bp+var_24+1],	0B4h
loc_271C6:
	dec	[bp+var_28]			; } while (--var_28 > 0)
	cmp	[bp+var_28], 0
	jg	short loc_271A9

loc_271C8:
	mov	al, byte ptr [bp+var_24+1]
	sub	ah, ah
	mov	[bp+var_14C], ax
	mov	ax, [bp+var_2]
	and	ax, 7
	mov	si, ax
	shr	si, 1
	mov	al, byte_4CA38[si]
	sub	ah, ah
	and	[bp+var_14C], ax
	mov	ax, si
	xor	al, 3
	mov	[bp+var_20], ax


	; Zero 20 bytes of var_1E
	mov	[bp+var_28], 0
loc_271F3:
	mov	si, [bp+var_28]
	mov	byte ptr [bp+si+var_1E], 0
	inc	[bp+var_28]
	cmp	[bp+var_28], 20
	jl	short loc_271F3

	mov	[bp+var_28], 0

	mov	ax, [bp+var_14C]
	mov	cl, 7
	shr	ax, cl
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[0] = ((var_14C >> 7) & 7) | 0x30

	mov	ax, [bp+var_14C]
	mov	cl, 4
	shr	ax, cl
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[1] = ((var_14C >> 4) & 7) | 0x30

	mov	ax, [bp+var_14C]
	shr	ax, 1
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[2] = ((var_14C >> 1) & 7) | 0x30

	mov	ax, [bp+var_24]
	mov	cl, 6
	shr	ax, cl
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[3] = ((var_24 >> 6) & 7) | 0x30

	mov	ax, [bp+var_24]
	mov	cl, 3
	shr	ax, cl
	push	ax
	CALL(cp_toDigit, near)
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[4] = ((var_24 >> 3) & 7 | 0x30

	push	[bp+var_24]
	CALL(cp_toDigit, near)
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[5] = (var_24 & 7) | 0x30

	PUSH_OFFSET(s_copyProtectIntro)
	PUSH_STACK_ADDRESS(var_12A)
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	bx, [bp+random16_1]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationOne+2)[bx]
	push	word ptr g_cpLocationOne[bx]
	push	dx
	push	ax
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	PUSH_OFFSET(s_commaSpace)
	push	dx
	push	[bp+var_132]
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	bx, [bp+random16_2]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationTwo+2)[bx]
	push	word ptr g_cpLocationTwo[bx]
	push	dx
	push	ax
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	PUSH_OFFSET(s_commaSpace)
	push	dx
	push	[bp+var_132]
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	bx, [bp+random16_3]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationThree+2)[bx]
	push	word ptr g_cpLocationThree[bx]
	push	dx
	push	ax
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	PUSH_OFFSET(s_commaAnd)
	push	dx
	push	[bp+var_132]
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	bx, [bp+random16_4]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationFour+2)[bx]
	push	word ptr g_cpLocationFour[bx]
	push	dx
	push	ax
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	PUSH_OFFSET(s_period)
	push	dx
	push	[bp+var_132]
	CALL(strcat)
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	PUSH_STACK_ADDRESS(var_12A)
	PRINTSTRING
	mov	ax, 10h
	push	ax
	PUSH_STACK_ADDRESS(var_14A)
	CALL(readString)

	push	[bp+var_20]
	PUSH_STACK_ADDRESS(var_1E)
	PUSH_STACK_ADDRESS(var_14A)
	CALL(cp_compareStrings, near)

	pop	si
	FUNC_EXIT
	retf
copyProtection endp
