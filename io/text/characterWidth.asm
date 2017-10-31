; Attributes: bp-based frame

text_characterWidth	proc far

	inCharacter= byte ptr	 6

	FUNC_ENTER
	mov	al, [bp+inCharacter]
	cbw

	cmp	ax, 'i'
	jz	l_returnThree
	cmp	ax, ' '
	jz	l_returnSix
	cmp	ax, 'm'
	jz	l_returnEight
	cmp	ax, 'a'
	jl	l_returnEight
	cmp	ax, 'z'
	jle	l_returnSix

l_returnEight:
	mov	ax, 8
	jmp	short l_return

l_returnThree:
	mov	ax, 3
	jmp	short l_return

l_returnSix:
	mov	ax, 6

l_return:
	FUNC_EXIT
	retf
text_characterWidth	endp
