define(`TRANSPARENT', `0')dnl
define(`OPAQUE', `0FFh')dnl
g_transparentFaces	db TRANSPARENT		;   0
			db OPAQUE		;   1
			db OPAQUE		;   2
			db OPAQUE		;   3
			db OPAQUE		;   4
			db TRANSPARENT		;   5
			db OPAQUE		;   6
			db OPAQUE		;   7
			db OPAQUE		;   8
			db OPAQUE		;   9
			db OPAQUE		;  10
			db OPAQUE		;  11
			db OPAQUE		;  12
			db TRANSPARENT		;  13
			db OPAQUE		;  14
			db OPAQUE		;  15
undefine(`TRANSPARENT', `OPAQUE')
