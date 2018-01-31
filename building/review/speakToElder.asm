; Attributes: bp-based frame

review_speakToElder proc far

	slotNumber=	word ptr -2

	FUNC_ENTER(2)

l_mainLoop:
	PUSH_OFFSET(s_whoSpeaksToElder)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	l_return

	sub	ax, ax
	push	ax
	push	[bp+slotNumber]
	CALL(review_isQuestComplete)
	or	ax, ax
	jnz	short l_checkForChronomancer
	PUSH_OFFSET(s_seekOutBrilhasti)
	PRINTSTRING(wait)
	jmp	l_mainLoop

l_checkForChronomancer:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_chronomancer
	jz	short l_checkQuests
	PUSH_OFFSET(s_teachOnlyChronomancer)
	PRINTSTRING(wait)
	jmp	short l_mainLoop

l_checkQuests:
	push	[bp+slotNumber]
	CALL(review_elderGelidia, near)
	or	ax, ax
	jnz	short l_waitAndLoop

	push	[bp+slotNumber]
	CALL(review_elderLucencia, near)
	or	ax, ax
	jnz	short l_waitAndLoop

	push	[bp+slotNumber]
	CALL(review_elderKinestia, near)
	or	ax, ax
	jnz	short l_waitAndLoop

	push	[bp+slotNumber]
	CALL(review_elderTenebrosia, near)
	or	ax, ax
	jnz	short l_waitAndLoop

	push	[bp+slotNumber]
	CALL(review_elderTarmitia, near)
	or	ax, ax
	jnz	short l_waitAndLoop
	PUSH_OFFSET(s_timeIsRunningOut)
	PRINTSTRING(clear)

l_waitAndLoop:
	IOWAIT
	jmp	l_mainLoop

l_return:
	FUNC_EXIT
	retf
review_speakToElder endp
