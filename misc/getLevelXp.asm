; This function	gets the XP requirements for a
; given	level
;
; XP calculation is:
;   if level > 11
;     add "(level * 400,00) - 4,400,000" to
;   the class specific values for levels 2-11

; DWORD - var_2 & var_4

; Attributes: bp-based frame

getLevelXp proc far

	var_8= dword ptr -8
	var_4= word ptr	-4
	var_2= word ptr	-2
	playerNo= word ptr  6
	level= word ptr	 8

	FUNC_ENTER(8)
	push	si

	; For levels higher than 11, the xp calculation is
	; (level * 400,000) - 4,400,000
	cmp	[bp+level], 11
	jle	short l_levelUnderTwelve
	mov	ax, 1A80h		; 400,000
	mov	dx, 6
	push	dx
	push	ax
	mov	ax, [bp+level]
	cwd
	push	dx
	push	ax
	CALL(_level32bitMult)
	sub	ax, 2380h		; 4,400,000
	sbb	dx, 43h	
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	[bp+level], 11
	jmp	short l_classSpecificXp

l_levelUnderTwelve:
	sub	ax, ax
	mov	[bp+var_2], ax
	mov	[bp+var_4], ax

l_classSpecificXp:
	CHARINDEX(ax, STACKVAR(playerNo), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr classXPReqs[bx]
	mov	dx, word ptr (classXPReqs+2)[bx]
	mov	word ptr [bp+var_8], ax
	mov	word ptr [bp+var_8+2], dx
	mov	bx, [bp+level]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+var_8]
	mov	ax, fs:[bx+si]
	mov	dx, fs:[bx+si+2]
	add	ax, [bp+var_4]
	adc	dx, [bp+var_2]

	pop	si
	FUNC_EXIT
	retf
getLevelXp endp
