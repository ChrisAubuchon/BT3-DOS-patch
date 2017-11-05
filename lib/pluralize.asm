; This function copies srcString into destString depending on
; the value passed.
;
; The '/' character in srcString indicates the start of the singular
; value. The end of the singular part (and beginning of the plural)
; part is indicated by '\'. Finally, the end of the plural part is
; indicated by a '\' or NULL.
;
; E.g. 'Wol/f\ves'
;   If value
;
; The current state is saved in [bp+stringState]
; 0 - initialState: Look for '/' (singular) or '\' (plural)
; 1 - skipSingular: '/' found but value is non-zero
; 2 - copySingular: '/' found and value is zero
; 3 - copyPlural:   '\' found and value is non-zero
; 4 - skipPlural:   '\' found and value is zero
; 5 - finalState:   Copy characters until 0
;
; Attributes: bp-based frame

str_pluralize proc far

	stringState= word ptr	-2
	srcString= dword ptr  6
	destString= dword ptr  0Ah
	value= word ptr	 0Eh

	FUNC_ENTER(2)

	mov	[bp+stringState], 0
l_stateCheck:
	mov	ax, [bp+stringState]
	or	ax, ax
	jz	l_initialSingularCheck
	cmp	ax, 1
	jz	l_skipSingular
	cmp	ax, 2
	jz	l_copySingular
	cmp	ax, 3
	jz	l_copyPlural
	cmp	ax, 4
	jz	l_skipPlural
	cmp	ax, 5
	jz	l_finalState
	jmp	l_nextCharacter

l_initialSingularCheck:
	lfs	bx, [bp+srcString]		; Copy from srcString
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]		; to destString
	mov	fs:[bx], al
	cmp	al, '/'	
	jnz	short l_initialPluralCheck

	cmp	[bp+value], 0
	jz	short loc_16273
	mov	ax, 1
	jmp	short loc_16276
loc_16273:
	mov	ax, 2
loc_16276:
	mov	[bp+stringState], ax
	jmp	l_nextCharacter

l_initialPluralCheck:
	lfs	bx, [bp+destString]
	cmp	byte ptr fs:[bx], '\'
	jnz	short loc_16297
	cmp	[bp+value], 0
	jz	short loc_1628F
	mov	ax, 3
	jmp	short loc_16292
loc_1628F:
	mov	ax, 4
loc_16292:
	mov	[bp+stringState], ax
	jmp	l_nextCharacter

loc_16297:
	cmp	byte ptr fs:[bx], 0
	jz	l_nextCharacter
	inc	word ptr [bp+destString]
	jmp	l_nextCharacter

l_skipSingular:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], '\'
	jnz	short loc_162B1
	mov	[bp+stringState], 3
loc_162B1:
	jmp	l_nextCharacter

l_copySingular:
	lfs	bx, [bp+srcString]
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	mov	fs:[bx], al
	cmp	al, '\'
	jnz	short loc_162CC
	mov	[bp+stringState], 4
	jmp	l_nextCharacter
loc_162CC:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short l_nextCharacter
	inc	word ptr [bp+destString]
	jmp	short l_nextCharacter

l_copyPlural:
	lfs	bx, [bp+srcString]
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	mov	fs:[bx], al
	cmp	al, '\'	
	jnz	short loc_162F1
	mov	[bp+stringState], 5
	jmp	short loc_162FD
loc_162F1:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_162FD
	inc	word ptr [bp+destString]
loc_162FD:
	jmp	short l_nextCharacter

l_skipPlural:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], '\'
	jnz	short loc_1630D
	mov	[bp+stringState], 5
loc_1630D:
	jmp	short l_nextCharacter

l_finalState:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short l_nextCharacter
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	inc	word ptr [bp+destString]
	mov	fs:[bx], al

l_nextCharacter:
	lfs	bx, [bp+srcString]
	inc	word ptr [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jnz	l_stateCheck

l_return:
	mov	ax, word ptr [bp+destString]
	mov	dx, word ptr [bp+destString+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
str_pluralize endp
