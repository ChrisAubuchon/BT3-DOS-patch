sound_stop proc far
	mov	ah, 2
	call	music_driver
	retf
sound_stop endp
