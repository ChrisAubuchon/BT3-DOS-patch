; Attributes: bp-based frame

configureBT3 proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= dword ptr  8

	FUNC_ENTER(8)

	cmp	[bp+arg_0], 1
	jle	short loc_2627C
	lfs	bx, [bp+arg_2]
	lfs	bx, fs:[bx+4]
	mov	al, fs:[bx]
	cbw
	jmp	short loc_2627F
loc_2627C:
	mov	ax, 0FFh
loc_2627F:
	mov	[bp+var_4], ax
	cmp	ax, '1'
	jl	short loc_2628C
	cmp	ax, '4'
	jle	short loc_2630B
loc_2628C:

	mov	[bp+var_8], 0
l_clearScreenLoop:
	PUSH_OFFSET(s_nl)
	CALL(printf)
	inc	[bp+var_8]
	cmp	[bp+var_8], 25
	jl	short l_clearScreenLoop

loc_262AB:
	PUSH_OFFSET(s_displayQuestion)
	CALL(printf)
	PUSH_OFFSET(s_videoOption1)
	CALL(printf)
	PUSH_OFFSET(s_videoOption2)
	CALL(printf)
	PUSH_OFFSET(s_videoOption3)
	CALL(printf)
	PUSH_OFFSET(s_videoOption4)
	CALL(printf)
	PUSH_OFFSET(s_videoQuestion)
	CALL(printf)
	CALL(sub_2A9D4)
	mov	[bp+var_4], ax
	cmp	ax, '1'	
	jl	short loc_2628C
	cmp	ax, '4'	
	jg	short loc_2628C
loc_2630B:
	mov	ax, [bp+var_4]
	sub	ax, '1'	
	mov	[bp+var_6], ax
	cmp	[bp+arg_0], 2
	jle	short loc_26327
	lfs	bx, [bp+arg_2]
	lfs	bx, fs:[bx+8]
	mov	al, fs:[bx]
	cbw
	jmp	short loc_2632A
loc_26327:
	mov	ax, 0FFh
loc_2632A:
	mov	[bp+var_4], ax
	cmp	ax, '1'	
	jl	short loc_2633A
	cmp	ax, '4'	
	jle	l_return

loc_2633A:
	mov	[bp+var_8], 0
loc_26341:
	PUSH_OFFSET(s_nl)
	CALL(printf)
	inc	[bp+var_8]
	cmp	[bp+var_8], 25
	jl	short loc_26341

loc_26359:
	PUSH_OFFSET(s_soundQuestion)
	CALL(printf)
	PUSH_OFFSET(s_soundOption1)
	CALL(printf)
	PUSH_OFFSET(s_soundOption2)
	CALL(printf)
	PUSH_OFFSET(s_soundOption3)
	CALL(printf)
	PUSH_OFFSET(s_soundOption4)
	CALL(printf)
	PUSH_OFFSET(s_soundOption5)
	CALL(printf)
	PUSH_OFFSET(s_soundPrompt)
	CALL(printf)
	CALL(sub_2A9D4)
	mov	[bp+var_4], ax
	cmp	ax, '1'	
	jl	loc_2633A
	cmp	ax, '5'	
	jg	loc_2633A
l_return:
	mov	ax, [bp+var_4]
	sub	ax, '1'	
	mov	[bp+var_2], ax
	mov	ah, byte ptr [bp+var_2]
	sub	al, al
	or	ax, [bp+var_6]
	jmp	short $+2

	FUNC_EXIT
	retf
configureBT3 endp
