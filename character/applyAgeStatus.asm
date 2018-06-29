; Attributes: bp-based frame

character_applyAgeStatus proc far

	attributeP= dword ptr  6
	savedAttributeP= dword ptr  0Ah
	attributeCount= word ptr	 0Eh

	FUNC_ENTER

l_loop:
	cmp	[bp+attributeCount], 0
	jl	short l_return
	lfs	bx, [bp+attributeP]
	mov	al, fs:[bx]
	lfs	bx, [bp+savedAttributeP]
	inc	word ptr [bp+savedAttributeP]
	mov	fs:[bx], al
	lfs	bx, [bp+attributeP]
	inc	word ptr [bp+attributeP]
	mov	byte ptr fs:[bx], 1
	dec	[bp+attributeCount]
	jmp	short l_loop

l_return:
	FUNC_EXIT
	retf
character_applyAgeStatus endp
