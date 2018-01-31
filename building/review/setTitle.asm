; Attributes: bp-based frame
;
; DWORD var_2 & var_4

review_setTitle proc far

	bigpicNumber= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER(8)
	mov	ax, 0Ch
	push	ax
	CALL(quest_partyNotHasFlagSet)
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	mov	[bp+var_6], cx
	or	cx, cx
	jz	short loc_24150
	mov	ax, 32h	
	jmp	short loc_24153
loc_24150:
	mov	ax, 2Fh	
loc_24153:
	mov	[bp+bigpicNumber], ax
	cmp	[bp+var_6], 0
	jz	short loc_24161
	mov	ax, offset s_building
	jmp	short loc_24164

loc_24161:
	mov	ax, offset s_reviewBoard

loc_24164:
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	push	[bp+bigpicNumber]
	CALL(bigpic_drawPictureNumber)

	push	[bp+var_2]
	push	[bp+var_4]
	CALL(setTitle)

	cmp	[bp+var_6], 0
	jz	short l_return
	CALL(text_clear)
	PUSH_OFFSET(s_desertedReviewBoard)
	PRINTSTRING
	add	sp, 4
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
