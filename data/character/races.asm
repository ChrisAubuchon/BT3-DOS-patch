s_human		db 'Human',0
s_elf		db 'Elf',0
s_dwarf		db 'Dwarf',0
s_hobbit	db 'Hobbit',0
s_halfElf	db 'Half-Elf',0
s_halfOrc	db 'Half-Orc',0
s_gnome		db 'Gnome',0

g_raceString	dd s_human		; 0
		dd s_elf		; 1
		dd s_dwarf		; 2
		dd s_hobbit		; 3
		dd s_halfElf		; 4
		dd s_halfOrc		; 5
		dd s_gnome		; 6

dnl	Base attributes are done by race and gender
dnl		1. Race is the index into this array
dnl		2. Gender determines which set of attributes to use. Males use the first 5 values
dnl		   and females use the last 5. The two sets of values are identical so I don't know
dnl		   why this was done.
dnl
dnl	The attributes are in this order: St, Iq, Dx, Dn, Lk
dnl
g_raceBaseAttributes	startingAttrBase <10,  6,  8,  8,  5, 10,  6,  8,  8,  5>		;   0
			startingAttrBase < 8,  9,  9,  6,  6,  8,  9,  9,  6,  6>		;   1
			startingAttrBase <12,  6,  7, 10,  3, 12,  6,  7, 10,  3>		;   2
			startingAttrBase < 4,  6, 12,  5, 10,  4,  6, 12,  5, 10>		;   3
			startingAttrBase < 9,  8,  9,  7,  6,  9,  8,  9,  7,  6>		;   4
			startingAttrBase <11,  3,  8, 11,  4, 11,  3,  8, 11,  4>		;   5
			startingAttrBase < 9, 10,  7,  3,  4,  9, 10,  7,  3,  4>		;   6

dnl	Race index to determince availabe starting classes
dnl
dnl	Order of classes: Wa, Wi, So, Co, Ma, Ro, Ba, Pa, Hu, Mo
dnl
dnl	Not sure why wizard and sorcerer are even options...
dnl
g_raceStartingClasses	startingClass_t	<1, 0, 0, 1, 1, 1, 1, 1, 1, 1>		;   0
			startingClass_t	<1, 0, 0, 1, 1, 1, 1, 1, 0, 1>		;   1
			startingClass_t	<1, 0, 0, 0, 0, 1, 1, 1, 1, 1>		;   2
			startingClass_t	<1, 0, 0, 1, 1, 1, 1, 0, 0, 1>		;   3
			startingClass_t	<1, 0, 0, 1, 1, 1, 1, 0, 0, 1>		;   4
			startingClass_t	<1, 0, 0, 1, 1, 1, 0, 0, 1, 0>		;   5
			startingClass_t	<1, 0, 0, 1, 1, 1, 0, 0, 1, 1>		;   6
