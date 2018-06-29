; Attributes: bp-based frame

close proc far

	fileHandle= word ptr	 6

	FUNC_ENTER
	mov	bx, [bp+fileHandle]
	mov	ah, 3Eh
	int	21h		; DOS -	2+ - call(close) A FILE WITH HANDLE
				; BX = file handle
	jnb	short l_return
	sub	ax, ax
	dec	ax

l_return:
	FUNC_EXIT(false)
	retf
close endp
