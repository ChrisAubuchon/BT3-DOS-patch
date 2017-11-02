; Attributes: bp-based frame

bards_printLyrics proc far

	loopCounter= word ptr	-2
	songNumber= word ptr	 6

	FUNC_ENTER
	CHKSTK(2)
	push	si

	CALL(text_clear)
	mov	[bp+loopCounter], 0
loc_25C8A:
	mov	si, [bp+loopCounter]
	shl	si, 1
	shl	si, 1
	mov	bx, [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	lfs	bx, bardSongLyrics[bx]
	push	word ptr fs:[bx+si+2]
	push	word ptr fs:[bx+si]
	PRINTSTRING
	IOWAIT
	inc	[bp+loopCounter]
	mov	bx, [bp+songNumber]
	shl	bx, 1
	mov	ax, [bp+loopCounter]
	cmp	bardSongLineCount[bx],	ax
	jg	short loc_25C8A
loc_25CC9:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_printLyrics endp
