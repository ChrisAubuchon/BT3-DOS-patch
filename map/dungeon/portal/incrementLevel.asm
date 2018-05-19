; Attributes: bp-based frame

portal_incrementLevel proc far
	FUNC_ENTER
	inc	g_dunLevelNum
	CALL(dun_changeLevels)
	FUNC_EXIT
	retf
portal_incrementLevel endp
