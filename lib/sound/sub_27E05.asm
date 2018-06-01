sub_27E05 proc far
	mov	ah, al
	and	ah, 1
	add	ah, 3
	call	music_driver
	retf
sub_27E05 endp
