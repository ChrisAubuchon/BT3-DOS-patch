; Attributes: bp-based frame

review_setTitle proc far

	bigpicNumber= word ptr	-8
	boardActiveFlag= word ptr	-6
	titleString= dword ptr	-4

	FUNC_ENTER(8)

	mov	ax, 0Ch
	push	ax
	CALL(quest_partyNotHasFlagSet)
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	mov	[bp+boardActiveFlag], cx
	or	cx, cx
	jz	short l_useReviewBoard

	mov	ax, bigpic_destroyedBuilding
	jmp	short l_checkTitle

l_useReviewBoard:
	mov	ax, bigpic_reviewBoard

l_checkTitle:
	mov	[bp+bigpicNumber], ax
	cmp	[bp+boardActiveFlag], 0
	jz	short l_useReviewTitle

	mov	ax, offset s_building
	jmp	short l_setTitle

l_useReviewTitle:
	mov	ax, offset s_reviewBoard

l_setTitle:
	mov	word ptr [bp+titleString], ax
	mov	word ptr [bp+titleString+2], ds
	push	[bp+bigpicNumber]
	CALL(bigpic_drawPictureNumber)

	PUSH_STACK_DWORD(titleString)
	CALL(setTitle)

	cmp	[bp+boardActiveFlag], 0
	jz	short l_return
	CALL(text_clear)
	PRINTOFFSET(s_desertedReviewBoard)

	mov	ax, 0FFh
	push	ax
	mov	ax, 3Eh	
	push	ax
	CALL(_updateFlags)
	IOWAIT

l_return:
	FUNC_EXIT
	retf
review_setTitle endp
