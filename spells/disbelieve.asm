; Attributes: bp-based frame

sp_disbelieve proc far

	var_2= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(2)
	push	si

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	or	gs:g_disbelieveFlags, al

	cmp	gs:g_disbelieveFlags, disb_disruptill
	jb	l_return

	mov	[bp+var_2], 0
l_loopEnter:
	CHARINDEX(ax, STACKVAR(spellCaster), si)
	cmp	gs:(party.specAbil+3)[si], 0
	jz	short l_nextChar
	mov	ax, 0Ch
	push	ax
	PUSH_OFFSET(s_dopplganger)
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(memcpy)
l_nextChar:
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_loopEnter
	jmp	short l_return

l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	test	spellEffectFlags[bx], disb_nosummon
	jz	short l_monDisbelieve
	or	gs:g_disbelieveFlags, disb_nosummon
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

