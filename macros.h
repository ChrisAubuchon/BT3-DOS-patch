charSize = 78h
monStruSize = 30h

getCharIndex	macro srcreg, mult
	mov	srcreg, charSize
	imul	mult
	endm

getCharP	macro mult, dest
	getCharIndex ax, mult
	mov	dest, ax
	endm

getMonIndex	macro srcreg, mult
	mov	srcreg, monStruSize
	imul	mult
	endm

getMonP		macro mult, dest
	getMonIndex ax, mult
	mov	dest, ax
	endm
