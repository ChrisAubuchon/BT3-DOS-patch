; Attributes: bp-based frame

icons_read proc far

	fd= word ptr	-2

	FUNC_ENTER
	CHKSTK(2)

l_retry:
	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_iconFilePath)
	CALL(open)
	mov	[bp+fd], ax
	cmp	ax, 0FFFFh
	jnz	l_asdf
	PUSH_OFFSET(s_insertDisk)
	PRINTSTRING
	push	dseg_0
	push	disk1
	PRINTSTRING
	IOWAIT
l_asdf:
	push	[bp+fd]
	CALL(huf_init)
	mov	ax, 474h
	push	ax
	mov	ax, offset iconLight
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	mov	ax, 820h
	push	ax
	mov	ax, offset iconCompass
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	mov	ax, 550h
	push	ax
	mov	ax, offset iconAreaEnchant
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	mov	ax, 1E0h
	push	ax
	mov	ax, offset iconShield
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	mov	ax, 640h
	push	ax
	mov	ax, offset iconLevitation
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	push	[bp+fd]
	CALL(close)

	FUNC_EXIT
	retf
icons_read endp
