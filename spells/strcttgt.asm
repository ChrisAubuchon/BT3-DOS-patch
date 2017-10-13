; Attributes: bp-based frame

strcatTargetName proc far

	monName=	word ptr -10h
	destString= dword ptr  6
	targetIndexNumber= word ptr	 0Ah
	targetCount= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	cmp	[bp+targetIndexNumber], 80h
	jge	short l_monTarget
	getCharP	[bp+targetIndexNumber], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+destString+2]
	push	word ptr [bp+destString]
	do_strcat	destString
	jmp	l_return

l_monTarget:
	and	[bp+targetIndexNumber], 3
	lea	ax, [bp+monName]
	push	ss
	push	ax
	getMonP	[bp+targetIndexNumber], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	std_call	decryptName, 8

	cmp	[bp+targetCount], 0
	jz	short l_monSingular
	strcat_offset	aSome, destString
	jmp	short l_pluralize

l_monSingular:
	dword_appendChar	 destString, 'a'
	mov	al, byte ptr [bp+monName]
	cbw
	push	ax
	std_call	str_startsWithVowel, 2
	or	ax, ax
	jz	short l_appendSpace
	dword_appendChar	destString, 'n'

l_appendSpace:
	dword_appendChar	destString, ' '

l_pluralize:
	push	[bp+targetCount]
	push	word ptr [bp+destString+2]
	push	word ptr [bp+destString]
	lea	ax, [bp+monName]
	push	ss
	push	ax
	do_pluralize destString
l_return:
	mov	ax, word ptr [bp+destString]
	mov	dx, word ptr [bp+destString+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
strcatTargetName endp
