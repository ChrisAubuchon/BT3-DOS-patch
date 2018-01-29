; Attributes: bp-based frame

transferCharacter proc far

	inKey= word ptr	-2

	FUNC_ENTER(2)

l_entry:
	PUSH_OFFSET(s_transferVersionPrompt)
	PRINTSTRING(true)
	mov	ax, 3Ch	
	push	ax
	CALL(getKey)
	mov	[bp+inKey], ax
	cmp	ax, 110h
	jl	short loc_2641A
	cmp	ax, 112h
	jg	short loc_2641A
	sub	[bp+inKey], 0DFh 
loc_2641A:
	mov	ax, [bp+inKey]
	cmp	ax, dosKeys_ESC
	jz	short l_return
	cmp	ax, '1'	
	jz	short l_bt1
	cmp	ax, '2'	
	jz	short l_bt2
	cmp	ax, '3'	
	jz	short l_bt3
	cmp	ax, 'E'	
	jz	short l_return
	cmp	ax, 113h
	jz	short l_return
	jmp	short l_entry

l_bt3:
	CALL(getTransferCharacters, near)
	jmp	short l_entry

l_bt2:
	mov	ax, 1
	push	ax
	CALL(importCharacter, near)
	jmp	short l_entry

l_bt1:
	sub	ax, ax
	push	ax
	CALL(importCharacter, near)
	jmp	short l_entry

l_return:
	FUNC_EXIT
	retf
transferCharacter endp
