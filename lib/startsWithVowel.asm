; This function	returns	1 if the passed	string starts
; with a vowel.	This is	for proper use of a/an in
; strings.
; Attributes: bp-based frame

str_startsWithVowel proc far

	loopCounter= word ptr	-2
	firstLetter= word ptr	 6

	FUNC_ENTER(2)

	push	[bp+firstLetter]
	CALL(toUpper)
	mov	[bp+firstLetter], ax

	mov	[bp+loopCounter], 0
l_loop:
	mov	bx, [bp+loopCounter]
	mov	al, vowelList[bx]
	cbw
	cmp	ax, [bp+firstLetter]
	jz	short l_returnOne

	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 6
	jl	short l_loop

l_returnZero:
	sub	ax, ax
	jmp	short l_return

l_returnOne:
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
str_startsWithVowel endp
