; Segment type:	Uninitialized
seg029 segment word stack 'STACK' use16
	assume cs:seg029
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_50070 db 0FA0h dup(?)
seg029 ends

end start
