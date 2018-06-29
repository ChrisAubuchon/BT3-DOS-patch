; Attributes: bp-based frame

open proc far

	fileName= dword ptr  6
	fileMode= byte ptr	 0Ah

	FUNC_ENTER
	push	ds
	lds	dx, [bp+fileName]
	mov	al, [bp+fileMode]
	mov	ah, 3Dh
	int	21h		; DS:DX	-> ASCIZ filename
				; AL = access mode
				; 0 - read, 1 -	write, 2 - read	& write
	jnb	short l_return
	sub	ax, ax
	dec	ax

l_return:
	pop	ds
	FUNC_EXIT(false)
	retf
open endp
