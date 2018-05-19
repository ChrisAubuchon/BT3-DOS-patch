checkKeyboard proc far
	mov	ah, 1
	int	16h		; KEYBOARD - CHECK BUFFER, DO NOT CLEAR
				; Return: ZF clear if character	in buffer
				; AH = scan code, AL = character
				; ZF set if no character in buffer
	jnz	short l_haveKey

	sub	ax, ax
	jmp	short l_return

l_haveKey:
	or	ax, ax
	jnz	short l_return
	inc	ax

l_return:
	retf
checkKeyboard endp
