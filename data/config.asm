dnl	Some library variables and configuration strings
dnl
word_42670	dw 0
word_42672	dw 0
byte_42674	db 0
byte_42675	db 0
word_42676	dw 0
aMsRunTimeLibraryCopy db 'MS Run-Time Library - Copyright (c) 1988, Microsoft Corp'
		db  11h
byte_426B1	db 0
s_comp		db 'comp',0
s_rgb		db 'rgb',0
s_ega		db 'ega',0
s_tdy		db 'tdy',0
s_thiefCfg	db 'thief.cfg',0
s_firstTitle	db 'tit0',0
s_titleScreen	db 'title',0
s_musicAll	db 'music.all',0
graphicsDrivers	dd s_comp, s_rgb, s_ega, s_tdy; 0
