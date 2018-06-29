random_2d16 proc far
	FUNC_ENTER
	push	si

	CALL(random)
	and	ax, 15
	mov	si, ax
	CALL(random)
	and	ax, 15
	add	ax, si
	add	ax, 2

	pop	si
	FUNC_EXIT
	retf
random_2d16 endp
