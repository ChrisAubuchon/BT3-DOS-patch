; This function replaces the '3' in the disk3 offset
; to a '1'. Not really useful in a hard drive installation
;

disk1Swap proc far

	arg_0= word ptr	 6

	FUNC_ENTER

	cmp	[bp+arg_0], 0
	jz	short l_return
	lfs	bx, disk3
	mov	byte ptr fs:[bx+5], '1'
l_return:
	mov	sp, bp
	pop	bp
	retf
disk1Swap endp
