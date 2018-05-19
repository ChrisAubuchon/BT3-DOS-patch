
; Attributes: bp-based frame

bat_monGetName proc far

	nameBuffer=	word ptr -10h
	stringBufferP= dword ptr  6
	slotNumber= word ptr	 0Ah

	FUNC_ENTER(10h)

	PUSH_STACK_ADDRESS(nameBuffer)
	MONINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], 'A'
	mov	al, byte ptr [bp+nameBuffer]
	cbw
	push	ax
	CALL(str_startsWithVowel, near)
	or	ax, ax
	jz	short l_startsWithConsonant

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], 'n'

l_startsWithConsonant:
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '
	sub	ax, ax
	push	ax
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	PUSH_STACK_ADDRESS(nameBuffer)
	PLURALIZE(stringBufferP)
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '
	mov	ax, word ptr [bp+stringBufferP]
	mov	dx, word ptr [bp+stringBufferP+2]

	FUNC_EXIT
	retf
bat_monGetName endp
