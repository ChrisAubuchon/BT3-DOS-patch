; This function	returns	non-zero if the	chronomancer
; quest	flag has been set in slotNumber
; Attributes: bp-based frame

review_isQuestComplete proc far

	slotNumber=	word ptr  6
	questByte= word ptr	 8

	FUNC_ENTER
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, [bp+questByte]
	mov	cl, 3
	sar	ax, cl
	add	bx, ax
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+questByte]
	and	bx, 7
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	and	ax, cx
	FUNC_EXIT
	retf
review_isQuestComplete endp
