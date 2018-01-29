; DWORD - 1C4 & 1C6, 17E & 180, 24 & 26
; Attributes: bp-based frame

getTransferCharacters proc far

	var_1CA= dword ptr -1CAh
	var_1C6= word ptr -1C6h
	var_1C4= word ptr -1C4h
	var_1C2= word ptr -1C2h
	var_1C0= word ptr -1C0h
	var_1BC= word ptr -1BCh
	var_1BA= dword ptr -1BAh
	var_1B6= word ptr -1B6h
	var_1B4= word ptr -1B4h
	fd= word ptr -182h
	var_180= word ptr -180h
	var_17E= word ptr -17Eh
	var_17C= word ptr -17Ch
	var_17A= dword ptr -17Ah
	var_26=	word ptr -26h
	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh

	FUNC_ENTER(1CAh)
	push	si

	mov	ax, 9000
	push	ax
	CALL(_mallocMaybe)
	mov	[bp+var_1C6], ax
	mov	[bp+var_1C4], dx

	mov	ax, 500h
	push	ax
	CALL(_mallocMaybe)
	mov	[bp+var_180], ax
	mov	[bp+var_17E], dx

loc_2649C:
	PUSH_OFFSET(s_diskToTransferFrom)
	PRINTSTRING(true)
	lea	ax, [bp+var_1B4]
	mov	[bp+var_26], ax
	mov	[bp+var_24], ss
	mov	ax, 18h
	push	ax
	PUSH_STACK_ADDRESS(var_1E)
	CALL(readString)
	or	ax, ax
	jz	short loc_264E1
	PUSH_STACK_ADDRESS(var_1E)
	push	[bp+var_24]
	push	[bp+var_26]
	CALL(strcat)
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx

loc_264E1:
	PUSH_OFFSET(s_thievesInf)
	push	[bp+var_24]
	push	[bp+var_26]
	CALL(strcat)
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx

	sub	ax, ax
	push	ax
	PUSH_STACK_ADDRESS(var_1B4)
	CALL(open)
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_2653C
	PUSH_OFFSET(s_noCharactersFoundOn)
	PRINTSTRING(true)

	PUSH_STACK_ADDRESS(var_1B4)
	PRINTSTRING
	IOWAIT
	jmp	loc_2649C

loc_2653C:
	mov	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	mov	word ptr [bp+var_1BA], ax
	mov	word ptr [bp+var_1BA+2], dx

	mov	[bp+var_1C2], 0
loc_26554:
	CHARINDEX(ax, STACKVAR(var_1C2), bx)
	lfs	si, [bp+var_1BA]
	mov	byte ptr fs:[bx+si], 0
	inc	[bp+var_1C2]
	cmp	[bp+var_1C2], 75
	jl	short loc_26554

	mov	ax, 9000
	push	ax
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	push	[bp+fd]
	CALL(read)

	push	[bp+fd]
	CALL(close)

	PUSH_STACK_ADDRESS(var_1E)
	PUSH_STACK_ADDRESS(var_1B4)
	CALL(strcat)
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx

	PUSH_OFFSET(s_partiesInf)
	push	dx
	push	[bp+var_26]
	CALL(strcat)
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx

	mov	ax, [bp+var_180]
	mov	dx, [bp+var_17E]
	mov	word ptr [bp+var_1BA], ax
	mov	word ptr [bp+var_1BA+2], dx

	mov	[bp+var_1C2], 0
loc_265DE:
	mov	bx, [bp+var_1C2]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+var_1BA]
	mov	byte ptr fs:[bx+si], 0
	inc	[bp+var_1C2]
	cmp	[bp+var_1C2], 0Ah
	jl	short loc_265DE

	sub	ax, ax
	push	ax
	PUSH_STACK_ADDRESS(var_1B4)
	CALL(open)
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_2663C
	PUSH_OFFSET(s_noPartiesFoundOn)
	PRINTSTRING(true)
	PUSH_STACK_ADDRESS(var_1B4)
	PRINTSTRING
	IOWAIT
	jmp	short loc_26654

loc_2663C:
	mov	ax, 500h
	push	ax
	push	[bp+var_17E]
	push	[bp+var_180]
	push	[bp+fd]
	CALL(read)

loc_26654:
	mov	[bp+var_1C2], 0
	mov	[bp+var_1C0], 0
loc_2665A:
	cmp	[bp+var_1C0], 10
	jge	l_partyLimitReached
	mov	si, [bp+var_1C2]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+var_1C2]
	mov	cl, 7
	shl	ax, cl
	add	ax, [bp+var_180]
	mov	dx, [bp+var_17E]
	mov	word ptr [bp+si+var_17A], ax
	mov	word ptr [bp+si+var_17A+2], dx
	mov	si, [bp+var_1C2]
	inc	[bp+var_1C2]
	inc	[bp+var_1C0]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_17A]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_2665A

l_partyLimitReached:
	dec	[bp+var_1C2]
	mov	ax, [bp+var_1C2]
	mov	[bp+var_1BC], ax
	mov	[bp+var_1C0], 0
loc_2669C:
	cmp	[bp+var_1C0], 75
	jge	l_charLimitReached

	mov	ax, [bp+var_1C2]
	sub	ax, [bp+var_1BC]
	CHARINDEX(cx, cx)
	add	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	mov	si, [bp+var_1C2]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+var_17A], ax
	mov	word ptr [bp+si+var_17A+2], dx
	mov	si, [bp+var_1C2]
	inc	[bp+var_1C2]
	inc	[bp+var_1C0]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_17A]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_2669C
l_charLimitReached:
	dec	[bp+var_1C2]

l_askWhoTransfers:
	push	[bp+var_1C2]
	PUSH_STACK_ADDRESS(var_17A)
	PUSH_OFFSET(s_whoShallTransfer)
	CALL(text_scrollingWindow)
	mov	[bp+var_1C0], ax
	or	ax, ax
	jge	short loc_2671D
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	CALL(_freeMaybe)
	push	[bp+var_17E]
	push	[bp+var_180]
	CALL(_freeMaybe)
	jmp	l_return
loc_2671D:
	mov	ax, [bp+var_1BC]
	cmp	[bp+var_1C0], ax
	jge	l_transferCharacter

l_transferParty:
	mov	si, [bp+var_1C0]
	shl	si, 1
	shl	si, 1
	mov	ax, word ptr [bp+si+var_17A]
	mov	dx, word ptr [bp+si+var_17A+2]
	mov	[bp+var_22], ax
	mov	[bp+var_20], dx

	mov	[bp+var_17C], 0
loc_26748:
	mov	ax, [bp+var_17C]
	mov	cl, 4
	shl	ax, cl
	add	ax, [bp+var_22]
	mov	dx, [bp+var_20]
	add	ax, 10h
	mov	word ptr [bp+var_1CA], ax
	mov	word ptr [bp+var_1CA+2], dx
	lfs	bx, [bp+var_1CA]
	cmp	byte ptr fs:[bx], 0
	jz	l_askWhoTransfers
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	push	dx
	push	ax
	CALL(transfer_findName, near)
	mov	[bp+var_1B6], ax
	cmp	[bp+var_1B6], 0
	jl	short loc_267AE

	CHARINDEX(ax, STACKVAR(var_1B6))
	add	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	push	dx
	push	ax
	CALL(transfer_bt3Character, near)

loc_267AE:
	inc	[bp+var_17C]
	cmp	[bp+var_17C], 7
	jl	short loc_26748
	jmp	l_askWhoTransfers

l_transferCharacter:
	mov	si, [bp+var_1C0]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_17A+2]
	push	word ptr [bp+si+var_17A]
	CALL(transfer_bt3Character, near)
	jmp	l_askWhoTransfers

l_return:
	pop	si
	FUNC_EXIT
	retf
getTransferCharacters endp
