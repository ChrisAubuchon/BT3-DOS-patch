; The bigpic data consists of "cells". The first cell is the base
; image. The remaining cells are xor'd onto the previous cell.
; This function configures the remaining cells.
;
; Attributes: bp-based frame

bigpic_configureCells proc far

	arg_0= dword ptr  6

	FUNC_ENTER
	push	si

	mov	si, 1340h
l_loop:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	xor	fs:[bx+1340h], al
	inc	word ptr [bp+arg_0]
	inc	si
	cmp	si, 4D00h
	jl	short l_loop

	pop	si
	FUNC_EXIT
	retf
bigpic_configureCells endp

