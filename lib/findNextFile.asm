findNextFile proc far
	push	bp
	mov	ah, 4Fh
	int	21h		; DOS -	2+ - FIND NEXT ASCIZ (FINDNEXT)
				; [DTA]	= data block from
				; last AH = 4Eh/4Fh call
	mov	ax, 0
	jb	short l_return
	inc	ax

l_return:
	pop	bp
	retf
findNextFile endp
