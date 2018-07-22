aWildwal_grp	db 'wildwal.grp',0
aSkara_grp	db 'skara.grp',0
aGdung_grp	db 'gdung.grp',0

map_graphicsTable       dd aWildwal_grp		;   0
			dd aSkara_grp		;   1
	                dd aSkara_grp		;   2
			dd aGdung_grp		;   3
			dd aGdung_grp		;   4
			dd aGdung_grp		;   5

s_diskOne	db 'Disk 1',0
s_diskTwo	db 'Disk 2',0
s_diskThree	db 'Disk 3', 0
s_maps_lo	db 'maps.lo',0
s_maps_hi	db 'maps.hi',0
s_monsterl	db 'monsterl',0
s_monsterh	db 'monsterh',0
s_lowPic	db 'low.pic',0
s_hiPic		db 'hi.pic',0
s_insertDisk	db 'Please insert disk ',0
byte_43F4A	db 8 dup(0)
disk1		dw offset s_diskOne
dseg_0		dw seg dseg
disk2		dd s_diskTwo
disk3		dd s_diskThree

mapFiles	dd s_maps_lo
		dd s_maps_hi

monsterFiles	dd s_monsterl
		dd s_monsterh

g_bigpicFileList	dd s_lowPic
			dd s_hiPic

s_victory	db 'vict',0
s_bardscr	db 'bardscr',0
s_iconFilePath	db 'icons.bin',0
