; Attributes: bp-based frame

mouse_draw proc far
	FUNC_ENTER
	cmp	gs:g_hideMouseInBigpicFlag, 0
	jz	short l_showMouse
	CALL(mouse_inBigpic, near)
	or	ax, ax
	jz	short l_return

l_showMouse:
	call	far ptr	gfx_enableMouseIcon

l_return:
	FUNC_EXIT
	retf
mouse_draw endp
