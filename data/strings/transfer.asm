s_characterAlreadyExists	db 'This character already exists',0
s_diskToTransferFrom	db 'Disk to transfer characters from?',0
s_whoShallTransfer	db 'Who shall transfer?',0
s_noCharactersFoundOn	db 'No characters found on',0
s_noPartiesFoundOn	db 'No parties found on',0
s_transferVersionPrompt	db 'Transfer characters from:',0Ah
			db '1) Bards I',0Ah
			db '2) Bards II',0Ah
			db '3) Bards III',0Ah
			db 'E) Exit',0

s_tpw		db '*.tpw',0
s_tw		db '*.tw',0

g_oldCharacterFilters	dd s_tpw	;   0
			dd s_tw		;   1
