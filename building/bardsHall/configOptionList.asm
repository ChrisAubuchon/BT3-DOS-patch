; Set up the song list that you can learn from the Bard's Hall
;
; optionList[0] = !locationFlag
; optionList[1] = !locationFlag
; optionList[2] = !locationFlag
; optionList[3] = locationFlag
; optionList[4] = locationFlag
; optionList[5] = locationFlag
;

; Attributes: bp-based frame

bards_configOptionList proc far

	loopCounter= word ptr	-2
	locationFlag= word ptr	 6
	optionList= dword ptr  8

	FUNC_ENTER
	CHKSTK(2)
	push	si

	mov	[bp+loopCounter], 0
loc_25E2E:
	mov	bx, [bp+loopCounter]
	lfs	si, [bp+optionList]
	cmp	[bp+locationFlag], 1
	sbb	ax, ax
	neg	ax
	mov	fs:[bx+si], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short loc_25E2E

	mov	[bp+loopCounter], 3
loc_25E51:
	mov	bx, [bp+loopCounter]
	lfs	si, [bp+optionList]
	mov	al, byte ptr [bp+locationFlag]
	mov	fs:[bx+si], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 6
	jl	short loc_25E51

	pop	si
	FUNC_EXIT
	retf
bards_configOptionList endp
