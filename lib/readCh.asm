_readChFromKeyboard proc far
	sub	ax, ax
	int	16h		; KEYBOARD - call(read) CHAR FROM BUFFER, WAIT IF EMPTY
				; Return: AH = scan code, AL = character
	retf
_readChFromKeyboard endp
