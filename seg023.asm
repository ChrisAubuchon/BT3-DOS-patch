; Segment type:	Regular
seg023 segment para public 'DATA' use16
	assume cs:seg023
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing

include(`gfx/bigpic/graphicsData.asm')
monsterBuf db 480h dup(0)	   ; 0
byte_3BA68 db 11C4h dup(0)	   ; 0
include(`data/gfx/icons/dataBuffers.asm')
include(`data/text/characterBitmasks.asm')
seg023 ends
