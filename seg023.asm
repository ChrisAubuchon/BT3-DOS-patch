; Segment type:	Regular
seg023 segment para public 'DATA' use16
	assume cs:seg023
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing

include(`gfx/bigpic/graphicsData.asm')
monsterBuf db 480h dup(0)	   ; 0
byte_3BA68 db 11C4h dup(0)	   ; 0
iconLight db 474h dup(0)	  ; 0
iconCompass db 820h dup(0)	    ; 0
iconAreaEnchant	db 550h	dup(0)		; 0
iconShield db 1E0h dup(0)	   ; 0
iconLevitation db 640h dup(0)	       ; 0

include(`io/text/characterBitmasks.asm')

minimap_squareToDraw db 8, 8, 8, 89h, 8, 8, 8, 8;	0
seg023 ends
