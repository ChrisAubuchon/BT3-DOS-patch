; Attributes: bp-based frame
;

cleanupAndExit proc far
	musicBufferP= word ptr	-4
	loopCounter= word ptr	-2

	FUNC_ENTER(6)
	CALL(sound_stop)
	CALL(restoreHardware)
	sub	ax, ax
	push	ax
	CALL(vid_setMode, far)

	mov	[bp+loopCounter], 0
l_freeMusicLoop:
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:musicBufs._offset[bx]
	mov	dx, gs:musicBufs._segment[bx]
	mov	[bp+musicBufferP], ax
	or	ax, dx
	jz	short l_freeMusicLoopNext

	push	dx
	push	[bp+musicBufferP]
	CALL(_freeMaybe)

l_freeMusicLoopNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 8
	jl	short l_freeMusicLoop

loc_10550:
	mov	ax, 1
	push	ax
	CALL(sub_28424, far)
	FUNC_EXIT
	retf
cleanupAndExit endp
