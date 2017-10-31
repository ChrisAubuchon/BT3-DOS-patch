; Segment type:	Regular
seg022 segment para public 'DATA' use16
	assume cs:seg022
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
g_rosterCharacterBuffer db 2328h	dup(0)	       ; 0
g_rosterPartyBuffer dw 240h dup(0)	   ; 0
g_partyBufTail db 5948h dup(0)	   ; 0
seg022 ends
