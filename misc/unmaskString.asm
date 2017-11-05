; This function	copies 16 bytes	from fromBuffer	to
; toBuffer and ANDs each byte with 0x7f to remove
; the "encryption"
; Attributes: bp-based frame

unmaskString proc far

	loopCounter= word ptr	-2
	fromBuffer= dword ptr  6
	toBuffer= dword	ptr  0Ah

	FUNC_ENTER(2)

	mov	[bp+loopCounter], 0
l_loopEntry:
	lfs	bx, [bp+fromBuffer]
	mov	al, fs:[bx]
	cmp	al, 0FFh
	jz	short l_return
	or	al, al
	jz	short l_return
	inc	word ptr [bp+fromBuffer]
	mov	al, fs:[bx]
	and	al, 7Fh
	APPEND_CHAR(STACKVAR(toBuffer), al)
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 16
	jl	short l_loopEntry
l_return:
	NULL_TERMINATE(STACKVAR(toBuffer))
	mov	sp, bp
	pop	bp
	retf
unmaskString endp
