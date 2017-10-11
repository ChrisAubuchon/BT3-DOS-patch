; Attributes: bp-based frame

sp_disbelieve proc far

	var_2= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	or	gs:disbelieveFlags, al

	cmp	gs:disbelieveFlags, disb_disruptill
	jb	l_return

	mov	[bp+var_2], 0
l_loopEnter:
	getCharP	[bp+spellCaster], si
	cmp	gs:(roster.specAbil+3)[si], 0
	jz	short l_nextChar
	mov	ax, 0Ch
	push	ax
	mov	ax, offset aDopplganger
	push	ds
	push	ax
	lea	ax, roster._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memcpy
	add	sp, 0Ah
l_nextChar:
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_loopEnter
	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	test	spellEffectFlags[bx], disb_nosummon
	jz	short l_monDisbelieve
	or	gs:disbelieveFlags, disb_nosummon
	jmp	short l_return
l_monDisbelieve:
	mov	al, byte ptr [bp+spellCaster]
	mov	gs:monDisbelieveFlag, al
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_disbelieve endp

