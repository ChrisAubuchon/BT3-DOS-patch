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

s_nl		db  0Ah,0
s_displayQuestion	db 'What type of display do you wish to use?',0
s_videoOption1	db 0Ah,0Ah,'1) Composite or TV monitor.',0
s_videoOption2	db 0Ah,'2) RGB monitor.',0
s_videoOption3	db 0Ah,'3) EGA monitor.',0
s_videoOption4	db 0Ah,'4) Tandy computer with RGB monitor.',0
s_videoQuestion	db 0Ah,0Ah
		db 'Please enter the appropriate number for your system type:',0
s_soundQuestion db 'What type of sound output device do you wish to use?',0
s_soundOption1		db 0Ah,0Ah,'1) MT32.',0
s_soundOption2	db 0Ah,'2) Ad Lib.',0
s_soundOption3 db 0Ah,'3) Internal IBM speaker.',0
s_soundOption4	db 0Ah,'4) Tandy.',0
s_soundOption5		db 0Ah,'5) PS/1',0
s_soundPrompt db 0Ah,0Ah,'Please enter the appropriate number for your system type:',0
