checkGamePort proc far
	xor	ax, ax
	cmp	g_mouseButtonClicked, al
	jz	short l_return

	mov	g_mouseButtonClicked, al
	inc	ax

l_return:
	retf
checkGamePort endp
