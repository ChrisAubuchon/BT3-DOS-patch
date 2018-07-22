define(`NONE', `0FFh')dnl
define(`WALL', `0')dnl
define(`DOOR', `4')dnl
minimap_bitmaskOffsetList	db NONE		;   0
				db WALL		;   1
				db DOOR		;   2
				db 8		;   3
				db DOOR		;   4
				db WALL		;   5
				db WALL		;   6
				db DOOR		;   7
				db WALL		;   8
				db WALL		;   9
				db DOOR		;  10
				db 8		;  11
				db DOOR		;  12
				db WALL		;  13
				db WALL		;  14
				db DOOR		;  15

; If this flag is non-zero then the minimap draws a dot on each
; square the party has visited. It's hardcoded to zero with no
; way to change it except reassembling.
;
g_minimapShowVisited	dw 0
undefine(`NONE', `WALL', `DOOR')dnl
