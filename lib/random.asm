random	proc far
	cli
	in	al, 40h		; Timer	8253-5 (AT: 8254.2).
	mov	ah, al
	in	al, 40h		; Timer	8253-5 (AT: 8254.2).
	add	al, ah
	sti
	add	ax, randomSeed
	mov	randomSeed, ax
	retf
random	endp
