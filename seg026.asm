; Segment type:	Regular
seg026 segment para public 'DATA' use16
	assume cs:seg026
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
g_currentSongBuffer db 1A30h dup(0)	   ; 0
seg026 ends
