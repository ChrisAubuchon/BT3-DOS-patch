; Attributes: bp-based frame

random_2d8	proc far
	FUNC_ENTER
	push	si

	CALL(random)
	and	ax, 7
	mov	si, ax
	CALL(random)
	and	ax, 7
	add	ax, si
	add	ax, 2

	pop	si
	FUNC_EXIT
	retf
random_2d8	endp
