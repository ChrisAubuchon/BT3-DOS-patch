; Attributes: bp-based frame

bat_monTarjanSpecial proc far

	counter =	word ptr -2

	FUNC_ENTER(2)
	mov	[bp+counter], 0

l_loop:
	inc	[bp+counter]
	mov	ax, 15h
	push	ax
	mov	ax, 80h
	push	ax
	CALL(summon_execute)

	cmp	[bp+counter], 0Ah
	jl	l_loop

	FUNC_EXIT
	retf
bat_monTarjanSpecial endp
