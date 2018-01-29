; Attributes: bp-based frame

_mfunc_unpackChar proc far

	FUNC_ENTER

l_extractCharacter:
	mov	ax, 5
	push	ax
	CALL(_mfunc_extractCh, near)
	or	ax, ax
	jz	short l_return
	cmp	ax, 30
	jz	short l_setCapitalFlag
	cmp	ax, 31
	jz	short l_hialphabetChar
	jmp	short l_loalphabetChar

l_setCapitalFlag:
	mov	_str_capFlag, 1
	jmp	short l_extractCharacter

l_hialphabetChar:
	mov	ax, 6
	push	ax
	CALL(_mfunc_extractCh, near)
	mov	bx, ax
	mov	al, _str_Hialphabet[bx]
	cbw
	cmp	_str_capFlag, 0
	jz	short l_return
	mov	_str_capFlag, 0
	jmp	l_returnCapital

l_loalphabetChar:
	mov	bx, ax
	mov	al, _str_Loalphabet[bx-1]
	cbw
	cmp	_str_capFlag, 0
	jz	short l_return
	mov	_str_capFlag, 0
l_returnCapital:
	push	ax
	CALL(toUpper)
l_return:
	FUNC_EXIT
	retf
_mfunc_unpackChar endp
