printSpellFizzled proc far
	FUNC_ENTER

	PUSH_OFFSET(s_butItFizzled)
	PRINTSTRING
	mov	sp, bp
	pop	bp
	retf
printSpellFizzled endp
