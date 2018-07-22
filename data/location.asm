s_timeEarlyMorning	db 'early morning.',0
s_timeMidMorning	db 'mid morning.',0
s_timeNoon		db 'noon.',0
s_timeAfternoon		db 'afternoon.',0
s_timeDusk		db 'dusk.',0
s_timeEvening		db 'evening.',0
s_timeMidnight		db 'midnight.',0
s_timeAfterMidnight	db 'after midnight.',0

s_locationRefugeeCamp	db ' refugee camp of Skara Brae.',0
s_locationCityGates	db ' city gates.',0
s_locationCityEntrance	db ' entrance to the city.',0
s_locationIceKeep	db ' great ice keep.',0
s_locationForest	db ' entrance of the forest.',0

s_youreIn		db 'You',27h,'re in ',0
			db    0
s_spAndsp		db ' and ',0
			db    0
s_itsNow		db 0Ah,0Ah, 'It',27h,'s now ',0

g_timeOfDayList		dd s_timeEarlyMorning		;   0
			dd s_timeMidMorning		;   1
			dd s_timeNoon			;   2
			dd s_timeAfternoon		;   3
			dd s_timeDusk			;   4
			dd s_timeEvening		;   5
			dd s_timeMidnight		;   6
			dd s_timeAfterMidnight		;   7

s_ofAtThe		db ' /of\at\ the',0
			db    0

g_locationStrings	dd s_locationRefugeeCamp		; 0
			dd s_locationCityGates			; 1
			dd s_locationCityEntrance		; 2
			dd s_locationIceKeep			; 3
			dd s_locationForest			; 4

g_locationDeltaNorth	db 0Ch		;   0
			db 0Ah		;   1
			db 7		;   2
			db 0Fh		;   3
			db 6		;   4
			db 6		;   5
			db 7		;   6
			db 9		;   7
			db 0Ah		;   8
			db 0Fh		;   9

g_locationDeltaEast	db 0Fh		;   0
			db 0		;   1
			db 6		;   2
			db 8		;   3
			db 0Ah		;   4
			db 9		;   5
			db 0		;   6
			db 8		;   7
			db 5		;   8
			db 1		;   9
divert(`-1')
define(`CAMP', `0')
define(`CITYGATES', `1')
define(`CITYENTRANCE', `2')
define(`ICEKEEP', `3')
define(`FOREST', `4')
divert`'dnl
g_locationReferenceMap		db CAMP			; 0
				db CITYGATES		; 1
				db CITYENTRANCE		; 2
				db CITYGATES		; 3
				db ICEKEEP		; 4
				db CITYENTRANCE		; 5
				db CITYGATES		; 6
				db CITYENTRANCE		; 7
				db FOREST		; 8
				db CITYGATES		; 9
undefine(`CAMP', `CITYGATES', `CITYENTRANCE', `ICEKEEP', `FOREST')dnl

divert(`-1')
define(`EARLYMORNING', `0')
define(`MIDMORNING', `1')
define(`NOON', `2')
define(`AFTERNOON', `3')
define(`DUSK', `4')
define(`EVENING', `5')
define(`MIDNIGHT', `6')
define(`AFTERMIDNIGHT', `7')
divert`'dnl
g_locationTimeMap		db AFTERMIDNIGHT		;  0
				db AFTERMIDNIGHT		;  1
				db AFTERMIDNIGHT		;  2
				db AFTERMIDNIGHT		;  3
				db EARLYMORNING			;  4
				db EARLYMORNING			;  5
				db EARLYMORNING			;  6
				db MIDMORNING			;  7
				db MIDMORNING			;  8
				db MIDMORNING			;  9
				db MIDMORNING			; 10
				db NOON				; 11
				db NOON				; 12
				db NOON				; 13
				db AFTERNOON			; 14
				db AFTERNOON			; 15
				db DUSK				; 16
				db DUSK				; 17
				db DUSK				; 18
				db EVENING			; 19
				db EVENING			; 20
				db EVENING			; 21
				db MIDNIGHT			; 22
				db MIDNIGHT			; 23
undefine(`EARLYMORNING',`MIDMORNING',`NOON',`AFTERNOON',`DUSK',`EVENING',`MIGNIGHT',`AFTERMIDNIGHT')dnl
