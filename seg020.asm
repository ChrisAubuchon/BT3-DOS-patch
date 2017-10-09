; Segment type:	Regular
seg020 segment word public 'DATA' use16
	assume cs:seg020
;org 7
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
algn_2AD17:
align 2
decompBytes23 dw 0
decompBytes01 dw 0
word_2AD1C dw 0
word_2AD1E dw 0
byte_2AD20 db 200h dup(0)	   ; 0
_decompBufIndex	dw 0
_decompByteMask	dw 0
byte_2AF24 db 0F05h dup(0)	   ; 0
word_2BE29 dw 0
word_2BE2B dw 0
word_2BE2D dw 0
align 2
seg020 ends
