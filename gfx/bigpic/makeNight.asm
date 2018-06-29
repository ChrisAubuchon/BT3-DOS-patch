byte_27E86 db 0, 1, 2, 3, 4, 5,	6, 7; 0
db 8, 9, 0Ah, 0, 0Ch, 0Dh, 0Eh,	0Fh; 8
byte_27E96 db 0, 10h, 20h, 30h,	40h, 50h, 60h, 70h; 0
db 80h,	90h, 0A0h, 0, 0C0h, 0D0h, 0E0h,	0F0h; 8

; Attributes: bp-based frame

bigpic_makeNight proc far

	bufferP= dword ptr  6

	FUNC_ENTER
	push	di
	push	ds
	push	es
	les	di, [bp+bufferP]
	mov	ax, cs
	mov	ds, ax
	assume ds:seg019
	sub	bx, bx
	mov	cx, 0F04h
	mov	dx, 1340h
	cld
loc_27EBC:
	mov	ah, es:[di]
	mov	bl, ah
	and	bl, ch
	mov	al, byte_27E86[bx]
	shr	ah, cl
	mov	bl, ah
	or	al, byte_27E96[bx]
	stosb
	dec	dx
	jnz	short loc_27EBC
	pop	es
	pop	ds
	assume ds:dseg
	pop	di
	FUNC_EXIT
	retf
bigpic_makeNight endp

