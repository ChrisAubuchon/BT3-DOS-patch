; This function	returns	a random number	between	the
; low and the high
;
; Attributes: bp-based frame
randomBetweenXandY proc	far

	var_6= word ptr	-6
	var_4= word ptr	-4
	_mask= word ptr	-2
	_low= word ptr	6
	_high= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, [bp+_high]
	sub	ax, [bp+_low]
	mov	[bp+var_4], ax
	or	ax, ax
	jg	short loc_1D246
	mov	ax, [bp+_low]
	jmp	short loc_1D26E
loc_1D246:
	push	[bp+var_4]
	push	cs
	call	near ptr getRndDiceMask
	add	sp, 2
	mov	[bp+_mask], ax
loc_1D253:
	call	random
	and	ax, [bp+_mask]
	mov	[bp+var_6], ax
	mov	ax, [bp+var_4]
	cmp	[bp+var_6], ax
	jg	short loc_1D253
	mov	ax, [bp+var_6]
	add	ax, [bp+_low]
	jmp	short $+2
loc_1D26E:
	mov	sp, bp
	pop	bp
	retf
randomBetweenXandY endp
