; Attributes: bp-based frame

icons_read proc far

	fd= word ptr	-2

	FUNC_ENTER(2)

l_retry:
	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_iconFilePath)
	CALL(open)
	mov	[bp+fd], ax
	cmp	ax, 0FFFFh
	jnz	l_asdf
	PRINTOFFSET(s_insertDisk)
	push	dseg_0
	push	disk1
	PRINTSTRING
	IOWAIT
l_asdf:
	push	[bp+fd]
	CALL(huf_init)
	mov	ax, 474h
	push	ax
	mov	ax, offset g_iconLight
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	mov	ax, 820h
	push	ax
	mov	ax, offset g_iconCompass
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	mov	ax, 550h
	push	ax
	mov	ax, offset g_iconAreaEnchant
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	mov	ax, 1E0h
	push	ax
	mov	ax, offset g_iconShield
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	mov	ax, 640h
	push	ax
	mov	ax, offset g_iconLevitation
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(huf_flate)
	push	[bp+fd]
	CALL(close)

	FUNC_EXIT
	retf
icons_read endp
