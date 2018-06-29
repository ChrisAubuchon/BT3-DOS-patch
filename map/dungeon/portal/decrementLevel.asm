; Attributes: bp-based frame

portal_decrementLevel proc far
	FUNC_ENTER

	dec	g_dunLevelNum
	jns	short l_changeLevel
	CALL(dun_setExitLocation)
	jmp	short l_return

l_changeLevel:
	CALL(dun_changeLevels)

l_return:
	FUNC_EXIT
	retf
portal_decrementLevel endp
