; Attributes: bp-based frame

song_getSong proc far

	var_22C= word ptr -22Ch
	var_72=	word ptr -72h
	songListString=	word ptr -34h
	counter= word ptr -1Ch
	songListStringP= dword ptr -1Ah
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	optionLetters=	word ptr -10h
	partySlotNumber=	word ptr  6
	songPlayingFlag= word ptr	 8

	FUNC_ENTER(34h)
	push	si

	sub	ax, ax
	mov	[bp+var_12], ax
	mov	[bp+var_16], ax
	mov	[bp+counter], ax
l_loopEnter:
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	mov	al, gs:(party.specAbil+1)[bx]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next
	lea	ax, [bp+songListString]
	mov	word ptr [bp+songListStringP], ax
	mov	word ptr [bp+songListStringP+2], ss

	mov	si, [bp+var_16]
	shl	si, 1
	mov	ax, bx
	mov	[bp+si+optionLetters],	ax
	lfs	bx, [bp+songListStringP]
	inc	word ptr [bp+songListStringP]
	mov	ax, [bp+var_16]
	inc	[bp+var_16]
	add	al, '1'
	mov	fs:[bx], al

	lfs	bx, [bp+songListStringP]
	inc	word ptr [bp+songListStringP]
	mov	byte ptr fs:[bx], ')'
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (songNames+2)[bx]
	push	word ptr songNames[bx]
	push	word ptr [bp+songListStringP+2]
	push	word ptr [bp+songListStringP]
	STRCAT(songListStringP)
	PUSH_STACK_ADDRESS(songListString)
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_12], ax
l_next:
	inc	[bp+counter]
	cmp	[bp+counter], 8
	jge	l_loopEnter

	mov	ax, bitMask16bit+16h
	or	[bp+var_12], ax
	cmp	[bp+songPlayingFlag], 0
	jz	short l_getUserInput
	PUSH_OFFSET(s_stopPlayingSong)
	PRINTSTRING
l_getUserInput:
	push	[bp+var_12]
	CALL(getKey)
	mov	[bp+var_14], ax
	cmp	ax, 1Bh
	jz	short loc_22C76
	cmp	ax, 119h
	jnz	short loc_22C7B
loc_22C76:
	mov	ax, 0FFFFh
	jmp	short l_return
loc_22C7B:
	cmp	[bp+songPlayingFlag], 0
	jz	short loc_22C96
	cmp	[bp+var_14], 'S'
	jnz	short loc_22C96
	push	[bp+partySlotNumber]
	CALL(song_stopPlaying, near)
	mov	ax, 0FFFFh
	jmp	short l_return
loc_22C96:
	cmp	[bp+var_14], 10Eh
	jl	short loc_22CB3
	mov	ax, [bp+var_16]
	add	ax, 10Eh
	cmp	ax, [bp+var_14]
	jl	short loc_22CB3
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+si+var_22C]
	jmp	short l_return
loc_22CB3:
	cmp	[bp+var_14], '0'
	jle	short l_badInput
	mov	ax, [bp+var_16]
	add	ax, '0'
	cmp	ax, [bp+var_14]
	jl	short l_badInput
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+si+var_72]
	jmp	short l_return
l_badInput:
	jmp	short l_getUserInput
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
song_getSong endp

