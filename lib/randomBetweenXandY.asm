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

	FUNC_ENTER(6)

	mov	ax, [bp+_high]
	sub	ax, [bp+_low]
	mov	[bp+var_4], ax
	or	ax, ax
	jg	short loc_1D246
	mov	ax, [bp+_low]
	jmp	short loc_1D26E
loc_1D246:
	push	[bp+var_4]
	CALL(getRndDiceMask, near)
	mov	[bp+_mask], ax
loc_1D253:
	CALL(random)
	and	ax, [bp+_mask]
	mov	[bp+var_6], ax
	mov	ax, [bp+var_4]
	cmp	[bp+var_6], ax
	jg	short loc_1D253
	mov	ax, [bp+var_6]
	add	ax, [bp+_low]
	jmp	short $+2
loc_1D26E:
	FUNC_EXIT
	retf
randomBetweenXandY endp
