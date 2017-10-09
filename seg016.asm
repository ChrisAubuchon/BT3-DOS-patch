; Segment type:	Pure code
seg016 segment byte public 'CODE' use16
	assume cs:seg016
;org 0Eh
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Attributes: bp-based frame

sub_2625E proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= dword ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
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
	cmp	ax, 31h	
	jl	short loc_2628C
	cmp	ax, 34h	
	jle	short loc_2630B
loc_2628C:
	mov	[bp+var_8], 0
	jmp	short loc_26296
loc_26293:
	inc	[bp+var_8]
loc_26296:
	cmp	[bp+var_8], 19h
	jge	short loc_262AB
	mov	ax, offset unk_4C246
	push	ds
	push	ax
	call	printf
	add	sp, 4
	jmp	short loc_26293
loc_262AB:
	mov	ax, offset aWhatTypeOfDisp
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a1CompositeOrTv
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a2RgbMonitor_
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a3EgaMonitor_
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a4TandyComputer
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset aPleaseEnterThe
	push	ds
	push	ax
	call	printf
	add	sp, 4
	call	sub_2A9D4
	mov	[bp+var_4], ax
	cmp	ax, 31h	
	jl	short loc_2628C
	cmp	ax, 34h	
	jg	short loc_2628C
loc_2630B:
	mov	ax, [bp+var_4]
	sub	ax, 31h	
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
	cmp	ax, 31h	
	jl	short loc_2633A
	cmp	ax, 34h	
	jg	short loc_2633A
	jmp	loc_263CC
loc_2633A:
	mov	[bp+var_8], 0
	jmp	short loc_26344
loc_26341:
	inc	[bp+var_8]
loc_26344:
	cmp	[bp+var_8], 19h
	jge	short loc_26359
	mov	ax, offset asc_4C312
	push	ds
	push	ax
	call	printf
	add	sp, 4
	jmp	short loc_26341
loc_26359:
	mov	ax, offset aWhatTypeOfSoundOutput
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a1Mt32_
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a2AdLib_
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a3InternalIbmSpeaker_
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a4Tandy_
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset a5Ps1
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset aPleaseEnterTheAppropr
	push	ds
	push	ax
	call	printf
	add	sp, 4
	call	sub_2A9D4
	mov	[bp+var_4], ax
	cmp	ax, 31h	
	jge	short loc_263C4
	jmp	loc_2633A
loc_263C4:
	cmp	ax, 35h	
	jle	short loc_263CC
	jmp	loc_2633A
loc_263CC:
	mov	ax, [bp+var_4]
	sub	ax, 31h	
	mov	[bp+var_2], ax
	mov	ah, byte ptr [bp+var_2]
	sub	al, al
	or	ax, [bp+var_6]
	jmp	short $+2
	mov	sp, bp
	pop	bp
locret_263E2:
	retf
sub_2625E endp

seg016 ends
