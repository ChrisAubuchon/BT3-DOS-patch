monStruSize = 30h

getMonIndex	macro srcreg, mult
	mov	srcreg, monStruSize
	imul	mult
	endm

getMonP		macro mult, dest
	getMonIndex ax, mult
	mov	dest, ax
	endm
