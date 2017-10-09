; Segment type:	Regular
seg022 segment para public 'DATA' use16
	assume cs:seg022
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
characterIOBuf db 2328h	dup(0)	       ; 0
partyIOBuf dw 240h dup(0)	   ; 0
byte_31268 db 5948h dup(0)	   ; 0
seg022 ends
