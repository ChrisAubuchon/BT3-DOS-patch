s_scryStairs	db 'the entry stairs.',0
s_scryPortal	db 'the entry portal.',0
s_scryEntryway	db 'the entryway.',0
s_scryMountain	db 'the base of the mountain.',0
s_scryVantage	db 'a vantage point.',0
s_scryWayIn	db 'the way in.',0
s_scryExit	db 'the exit.',0

s_youFace	db 'You face ',0
s_levels		db ' level/\s',0
s_aboveBelow	db ' /above\below\',0
s_paces		db ' pace/\s',0
s_northSouth	db ' /north\south\',0
s_eastWest	db ' /east\west\',0
s_andAreAt	db ' and are at ',0
s_of		db ' of ',0
s_andAre		db ' and /\are \',0

g_scryBaseList	dd s_scryStairs		;   0
		dd s_scryPortal		;   1
		dd s_scryEntryway	;   2
		dd s_scryMountain	;   3
		dd s_scryVantage	;   4
		dd s_scryWayIn		;   5
		dd s_scryExit		;   6

g_scryDeltaNS	db 0		;   0
		db 0		;   1
		db 4		;   2
		db 2		;   3
		db 2		;   4
		db 2		;   5
		db 2		;   6
		db 9		;   7
		db 0		;   8
		db 0		;   9
		db 0		;  10
		db 0		;  11
		db 0		;  12
		db 0		;  13
		db 0		;  14
		db 0		;  15
		db 4		;  16
		db 4		;  17
		db 4		;  18
		db 4		;  19
		db 8		;  20
		db 8		;  21
		db 0		;  22
		db 0		;  23
		db 0		;  24
		db 0		;  25
		db 0		;  26
		db 0		;  27
		db 0		;  28
		db 6		;  29
		db 6		;  30
		db 0		;  31
		db 0		;  32
		db 0		;  33
		db 0		;  34
		db 0		;  35
		db 0		;  36
		db 0		;  37
		db 0		;  38
		db 0		;  39
		db 0		;  40
		db 0		;  41
		db 0		;  42
		db 0		;  43
		db 0		;  44
		db 0Eh		;  45
		db 0		;  46
		db 0Ah		;  47
		db 0		;  48
		db 0		;  49
		db 0		;  50
		db 3		;  51
		db 0		;  52
		db 0		;  53
		db 0		;  54
		db 0		;  55
		db 10h		;  56
		db 15h		;  57
		db 1		;  58
		db 1		;  59
		db 1		;  60
		db 0		;  61

g_scryDeltaEW	db 0		;   0
		db 0		;   1
		db 0Eh		;   2
		db 0		;   3
		db 0		;   4
		db 0		;   5
		db 0		;   6
		db 0		;   7
		db 0		;   8
		db 0		;   9
		db 0		;  10
		db 0		;  11
		db 4		;  12
		db 4		;  13
		db 4		;  14
		db 4		;  15
		db 0		;  16
		db 0		;  17
		db 0		;  18
		db 0		;  19
		db 2		;  20
		db 2		;  21
		db 1		;  22
		db 1		;  23
		db 9		;  24
		db 9		;  25
		db 0		;  26
		db 0		;  27
		db 0		;  28
		db 0		;  29
		db 0		;  30
		db 0		;  31
		db 0		;  32
		db 0		;  33
		db 0		;  34
		db 0		;  35
		db 0		;  36
		db 0		;  37
		db 0		;  38
		db 0		;  39
		db 0		;  40
		db 0		;  41
		db 0Ah		;  42
		db 0Ah		;  43
		db 0Ah		;  44
		db 0Bh		;  45
		db 0		;  46
		db 0		;  47
		db 6		;  48
		db 6		;  49
		db 6		;  50
		db 0Ch		;  51
		db 0Eh		;  52
		db 0Eh		;  53
		db 0Eh		;  54
		db 0Eh		;  55
		db 0Ah		;  56
		db 3		;  57
		db 1		;  58
		db 1		;  59
		db 0		;  60
		db 0		;  61

divert(`-1')
define(`STAIRS', `0')
define(`PORTAL', `1')
define(`ENTRYWAY', `2')
define(`MOUNTAIN', `3')
define(`VANTAGE', `4')
define(`WAYIN', `5')
define(`EXIT', `6')
divert`'dnl
g_scryBaseMap	db STAIRS		;  0
		db STAIRS		;  1
		db ENTRYWAY		;  2
		db STAIRS		;  3
		db STAIRS		;  4
		db STAIRS		;  5
		db STAIRS		;  6
		db ENTRYWAY		;  7
		db STAIRS		;  8
		db STAIRS		;  9
		db STAIRS		; 10
		db STAIRS		; 11
		db STAIRS		; 12
		db STAIRS		; 13
		db STAIRS		; 14
		db STAIRS		; 15
		db STAIRS		; 16
		db STAIRS		; 17
		db STAIRS		; 18
		db STAIRS		; 19
		db STAIRS		; 20
		db STAIRS		; 21
		db STAIRS		; 22
		db STAIRS		; 23
		db MOUNTAIN		; 24
		db MOUNTAIN		; 25
		db STAIRS		; 26
		db STAIRS		; 27
		db STAIRS		; 28
		db STAIRS		; 29
		db STAIRS		; 30
		db VANTAGE		; 31
		db VANTAGE		; 32
		db VANTAGE		; 33
		db VANTAGE		; 34
		db VANTAGE		; 35
		db VANTAGE		; 36
		db VANTAGE		; 37
		db VANTAGE		; 38
		db VANTAGE		; 39
		db STAIRS		; 40
		db STAIRS		; 41
		db WAYIN		; 42
		db WAYIN		; 43
		db WAYIN		; 44
		db EXIT			; 45
		db EXIT			; 46
		db EXIT			; 47
		db EXIT			; 48
		db EXIT			; 49
		db EXIT			; 50
		db PORTAL		; 51
		db STAIRS		; 52
		db STAIRS		; 53
		db STAIRS		; 54
		db STAIRS		; 55
		db ENTRYWAY		; 56
		db ENTRYWAY		; 57
		db PORTAL		; 58
		db ENTRYWAY		; 59
undefine(`STAIRS',`PORTAL',`ENTRYWAY',`MOUNTAIN',`VANTAGE',`WAYIN',`EXIT')dnl
