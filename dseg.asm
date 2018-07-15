include(`data/config.asm')
s_stuckEllipsis	db 'Stuck....',0
s_facing		db 'facing ',0
byte_42716	db 0, 2, 20h, 22h
s_pausing	db 'pausing',0
		db    0
s_whoToDrop db 'Who will you drop?',0
		db    0
s_cantDropCharacter db 'You can',27h,'t drop a party member.',0
		db    0

include(`data/location.asm')

s_whoUsesItem db 'Who will use an item?',0
s_UseOn		db 'Use on ',0
s_powerless	db 'Powerless.',0
		db    0
s_confirmRestore db 'Do you wish to restore your last saved game?',0
		db    0
s_confirmSave db 'Do you wish to save your game?',0
		db    0
s_savingTheGame	db 'Saving the game.',0
		db    0
s_gameHasBeenSaved	db 'Your game has been saved to disk.',0Ah, 0Ah
			db 'Do you wish to exit to DOS?',0
s_helpMessage1	db 'HELP for those in need:',0Ah, 0Ah
			db '1-7 = Player info',0Ah
			db 'Arrows = Move, turn',0Ah
			db '? = Where are we',0Ah
			db 'N = New march order',0Ah
			db 'S = Save the game',0Ah
			db 'T = Time out',0Ah
			db 'V = Sound on/off',0Ah,0
s_helpMessage2	db 'More HELP:',0Ah, 0Ah
			db 'B = Play a Bard tune',0Ah
			db 'C = Cast a spell',0Ah
			db 'F1-F7 = Cast a spell',0Ah
			db 'E = Ascend portal',0Ah
			db 'W = Descend portal',0Ah
			db 'P = Party combat',0Ah
			db 'D = Drop special party member',0Ah
			db 'U = Use an item',0Ah,0
s_newOrder	db 'New Order:',0Ah,0Ah,0
		db    0
s_gtChar		db '>'
byte_42AF5	db 78h				; XXX - Doesn't seem to be used
		db 20h
		db 0
s_useThisOrder	db 0Ah,'Use this order?',0
s_gameSav	db 'game.sav',0
s_cantOpenGameSave	db 'Can',27h,'t open game save file',0
			db    0
g_soundActiveFlag	dw 1
s_confirmQuit	db 'Quit the game?',0
s_loseProgressConfirm	db 'You will lose your game status.',0Ah
		db 0Ah, 0Ah, 0Ah
		db '  Do you wish to quit?',0
align 2

s_campMenuString	db 'Thou art in the Camp of Skara Brae.'
		db 0Ah
		db 0Ah
		db '@Add a member',0Ah
		db '@Remove a member',0Ah
		db '@Rename a member',0Ah
		db '@Create a member',0Ah
		db '@Transfer characters',0Ah
		db '@Delete a member',0Ah
		db '@Save the party',0Ah
		db '@Leave the game',0Ah
		db '@Enter wilderness',0
s_saveAndExit	db 'Press <RETURN> to save off all char'
		db 'acters and end game play. Or press '
		db 'ESC to go back.',0
s_genderOptions	db 'Do you wish your character to be',0Ah
		db 'Male or',0Ah
		db 'Female?',0
align 2
s_raceOptions	db 'Select a race for your new character:',0Ah,0Ah
		db '1) Human',0Ah
		db '2) Elf',0Ah
		db '3) Dwarf',0Ah
		db '4) Hobbit',0Ah
		db '5) Half-Elf',0Ah
		db '6) Half-Orc',0Ah
		db '7) Gnome',0
align 2
s_nameYourCharacter	db 'Name your new character --',0
align 2
s_whichPartyMemberToRemove	db 'Select which party member to remove or...',0
s_removeAll	db 'Remove them all!',0
align 2
s_askPartyName	db 'Name to save party under?',0
s_deleteWho	db 'Delete Who?',0
s_currentlyInParty	db ' is currently in the party. Remove from the party first.',0
align 2
s_confirmDelete	db 'Are you sure you want to delete ',0
align 2
s_noCharsOnDisk	db 'There are no characters on this disk.',0
s_whoJoins	db 'Who shall join?',0
s_alreadyInParty	db ' is already in the party.',0
s_nameAlreadyExists	db 'There is already a character with that name in the party.',0
align 2
s_rosterIsFull	db 'The roster is full.',0
s_noOneHereNamedThat	db 'There',27h,'s no one here named that!',0
s_renameWho	db 'Rename Who?',0
aYouCanTRenameA	db 'You can',27h,'t rename a party list!',0
align 2
s_whatIs		db 'What is ',0
align 2
s_newName	db 27h,'s new name?',0
align 2

include(`data/character/classes.asm')
s_ruinTitle	db 'The Ruin',0
g_campActionFunctions	dd camp_addMember
		dd camp_removeMember
		dd camp_renameMember
		dd camp_createMember
		dd transferCharacter
		dd camp_deleteMember
		dd camp_saveParty
		dd camp_saveAndExit
		dd camp_exit
s_thievesInf	db	'thieves.inf',0
s_partiesInf	db	'parties.inf',0

include(`building/tavern/data.asm')
include(`building/temple/data.asm')

s_pronounHe		db 'he',0
s_pronounShe		db 'she',0
s_pronounIt		db 'it',0
s_pronounHim		db 'him',0
s_pronounHer		db 'her',0
s_pronounHis		db 'his',0
s_pronounIts		db 'its',0
g_pronounList	dd s_pronounHe
		dd s_pronounShe
		dd s_pronounIt
		dd s_pronounHim
		dd s_pronounHer
		dd s_pronounIt
		dd s_pronounHis
		dd s_pronounHer
		dd s_pronounIts
fgtrXPReq	dd 2000, 4000, 7000, 10000, 15000, 20000; 0
		dd 30000, 50000, 80000,	110000,	150000,	200000;	6
wizdXPReq	dd 20000, 50000, 80000, 120000, 160000, 200000; 0
		dd 250000, 300000, 400000, 600000, 900000; 6
		dd 1300000		; 11
sorcXPReq	dd 7000, 15000, 25000, 40000,	60000, 80000; 0
		dd 100000, 130000, 170000, 220000, 300000; 6
		dd 400000		; 11
magiXPReq	dd 1800, 4000, 6000, 10000, 14000, 19000; 0
		dd 29000, 50000, 90000,	120000,	170000,	230000;	6
archXPReq	dd 70000, 140000, 240000, 340000, 540000; 0
		dd 740000, 1000000, 1400000, 1800000, 2200000; 5
		dd 2600000, 3000000	; 10
geomXPReq	dd 100000, 225000, 400000, 650000, 950000; 0
		dd 1400000, 1800000, 2200000, 2600000, 3000000;	5
		dd 3400000, 3800000	; 10
classXPReqs	dd fgtrXPReq, wizdXPReq, sorcXPReq,	magiXPReq; 0
		dd magiXPReq, fgtrXPReq, fgtrXPReq, fgtrXPReq; 4
		dd fgtrXPReq, magiXPReq, archXPReq, archXPReq; 8
		dd geomXPReq		; 12
s_emptyBuilding	db 'You are in an empty building.',0
s_building	db 'Building',0
align 2
s_storageMenu	db 'The party is inside a storage building.',0Ah
		db 'Who wishes to inspect?',0Ah
		db 0Ah, 0Ah, 0Ah
		db 'ESC to exit building',0
align 2
s_would		db 'Would ',0
align 2
s_likeToPickup	db ' like to pickup...',0
align 2
s_buildingIsEmpty	db 'The building is empty.',0
align 2
aPickUp___	db 'Pick up...',0
align 2
s_allFull	db 'All full!',0
s_youPickUpItem	db 'You pick up the item.',0

a_inventoryStf	db 'inventor.stf',0
align 2
aWildwal_grp	db	'wildwal.grp',0
aSkara_grp	db 'skara.grp',0
aGdung_grp	db 'gdung.grp',0
aDisk1		db 'Disk 1',0
s_diskTwo		db 'Disk 2',0
aDisk3		db 'Disk 3',0
aMaps_lo	db 'maps.lo',0
aMaps_hi	db 'maps.hi',0
aMonsterl	db 'monsterl',0
aMonsterh	db 'monsterh',0
aLow_pic	db 'low.pic',0
aHi_pic		db 'hi.pic',0
align 2
s_insertDisk	db 'Please insert disk ',0
minimap_bitmaskOffsetList	db 0FFh, 0, 4, 8, 4, 0, 0, 4; 0
		db 0, 0, 4, 8, 4, 0, 0,	4; 8
s_statusAbbreviations	db 'Old PsndNutsPossParaDeadSton',0
			db    0
statusBitmaskList	db stat_old, stat_poisoned, stat_nuts, stat_possessed; 0
		db stat_paralyzed, stat_dead, stat_stoned, 0; 4
classAbbreviations	db 'WaWiSoCoMaRoBaPaHuMoArChGeMnIl',0
			db    0
word_43F12	dw 0
mouseBoxes	mouseBox_t < 0Fh,  0Ah,  6Ah,  7Ah>	; Bigpic Window
		mouseBox_t <   6, 0A8h,  66h, 132h>	; Text Window
		mouseBox_t < 90h,  0Ch, 0C7h, 132h>	; Roster Area
		db    0
		db    0
map_graphicsTable	dd aWildwal_grp, aSkara_grp; 0
		dd aSkara_grp, aGdung_grp; 2
		dd aGdung_grp, aGdung_grp; 4
byte_43F4A	db 8 dup(0)
disk1		dw offset aDisk1
dseg_0		dw seg dseg
disk2		dd s_diskTwo
disk3		dd aDisk3
mapFiles	dd aMaps_lo, aMaps_hi
monsterFiles	dd	aMonsterl, aMonsterh
levelPathTable	levelFile_t	<lev_monsterl, 0>; 0
		levelFile_t <lev_monsterl, 1>;	1
		levelFile_t <lev_monsterl, 2>;	2
		levelFile_t <lev_monsterl, 3>;	3
		levelFile_t <lev_monsterl, 4>;	4
		levelFile_t <lev_monsterh, 0>;	5
		levelFile_t <lev_monsterh, 1>;	6
		levelFile_t <lev_monsterh, 2>;	7
		levelFile_t <lev_monsterh, 3>;	8
		levelFile_t <lev_monsterh, 4>;	9
		levelFile_t <lev_monsterl, 5>;	10
		levelFile_t <lev_monsterl, 6>;	11
		levelFile_t <lev_monsterl, 7>;	12
		levelFile_t <lev_monsterl, 8>;	13
		levelFile_t <lev_monsterl, 9>;	14
		levelFile_t <lev_monsterl, 10>; 15
		levelFile_t <lev_monsterl, 11>; 16
		levelFile_t <lev_monsterl, 12>; 17
		levelFile_t <lev_monsterl, 13>; 18
		levelFile_t <lev_monsterl, 14>; 19
		levelFile_t <lev_monsterl, 15>; 20
		levelFile_t <lev_monsterl, 16>; 21
		levelFile_t <lev_monsterl, 17>; 22
		levelFile_t <lev_monsterl, 18>; 23
		levelFile_t <lev_monsterl, 19>; 24
		levelFile_t <lev_monsterl, 20>; 25
		levelFile_t <lev_monsterl, 21>; 26
		levelFile_t <lev_monsterl, 22>; 27
		levelFile_t <lev_monsterl, 23>; 28
		levelFile_t <lev_monsterl, 24>; 29
		levelFile_t <lev_monsterl, 25>; 30
		levelFile_t <lev_monsterl, 26>; 31
		levelFile_t <lev_monsterl, 27>; 32
		levelFile_t <lev_monsterl, 28>; 33
		levelFile_t <lev_monsterh, 5>;	34
		levelFile_t <lev_monsterh, 6>;	35
		levelFile_t <lev_monsterh, 7>;	36
		levelFile_t <lev_monsterh, 8>;	37
		levelFile_t <lev_monsterh, 9>;	38
		levelFile_t <lev_monsterh, 10>; 39
		levelFile_t <lev_monsterh, 11>; 40
		levelFile_t <lev_monsterh, 12>; 41
		levelFile_t <lev_monsterh, 13>; 42
		levelFile_t <lev_monsterh, 14>; 43
		levelFile_t <lev_monsterh, 15>; 44
		levelFile_t <lev_monsterh, 16>; 45
		levelFile_t <lev_monsterh, 17>; 46
		levelFile_t <lev_monsterh, 18>; 47
		levelFile_t <lev_monsterh, 19>; 48
		levelFile_t <lev_monsterh, 20>; 49
		levelFile_t <lev_monsterl, 29>; 50
		levelFile_t <lev_monsterl, 30>; 51
		levelFile_t <lev_monsterh, 21>; 52
		levelFile_t <lev_monsterh, 22>; 53
		levelFile_t <lev_monsterh, 23>; 54
		levelFile_t <lev_monsterh, 24>; 55
		levelFile_t <lev_monsterh, 25>; 56
		levelFile_t <lev_monsterh, 26>; 57
		levelFile_t <lev_monsterh, 27>; 58
		levelFile_t <lev_monsterh, 28>; 59
		levelFile_t <lev_monsterh, 29>; 60
		levelFile_t <lev_monsterh, 30>; 61
		levelFile_t <lev_monsterl, 31>; 62
		levelFile_t <lev_monsterl, 32>; 63
		levelFile_t <lev_monsterl, 33>; 64
		levelFile_t <lev_monsterl, 34>; 65
		levelFile_t <lev_monsterh, 31>; 66
		levelFile_t <lev_monsterh, 32>; 67
		levelFile_t <lev_monsterh, 33>; 68
		levelFile_t <lev_monsterh, 34>; 69
		levelFile_t <lev_monsterh, 35>; 70
lowPic		dd aLow_pic
		dd aHi_pic
bigpicIndex	db 0, 1, 2, 3	    ; 0
		db 4, 5, 6, 7		; 4
		db 8, 9, 10, 11		; 8
		db 12, 13, 14, 15	; 12
		db 16, 17, 18, 19	; 16
		db 20, 21, 255,	255	; 20
		db 22, 255, 23,	255	; 24
		db 255,	24, 25,	255	; 28
		db 26, 27, 255,	255	; 32
		db 255,	255, 28, 29	; 36
		db 255,	255, 255, 30	; 40
		db 255,	255, 31, 32	; 44
		db 33, 34, 35, 36	; 48
		db 37, 38, 39, 40	; 52
		db 41, 42, 43, 44	; 56
		db 255,	45, 255, 46	; 60
		db 255,	255, 255, 255	; 64
		db 255,	47, 48,	49	; 68
		db 255,	255, 50, 255	; 72
		db 255,	255, 51, 52	; 76
		db 255,	255, 255, 53	; 80
		db 255,	255, 255, 255	; 84
		db 255,	255, 255, 0	; 88
		db 255,	1, 255,	2	; 92
		db 255,	3, 4, 255	; 96
		db 255,	255, 5,	6	; 100
		db 255,	255, 255, 255	; 104
		db 255,	7, 8, 9		; 108
		db 255,	10, 255, 255	; 112
		db 11, 255, 255, 12	; 116
		db 13, 255, 14,	15	; 120
		db 16, 17, 18, 255	; 124
		db 19, 20, 21, 255	; 128
		db 22, 23, 255,	255	; 132
		db 24, 255, 255, 25	; 136
		db 26, 27, 28, 29	; 140
		db 255,	255, 255, 255	; 144
		db 30, 31, 32, 255	; 148
		db 33, 34, 35, 36	; 152
		db 37, 255, 255, 255	; 156
		db 38, 39, 255,	40	; 160
		db 41, 42, 43, 44	; 164
		db 45, 255, 46,	255	; 168
		db 47, 48, 255,	49	; 172
s_yesNo		db 'Yes',0Ah,'No',0
		db    0
word_440BC	dw 0
_str_Loalphabet	db ' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g'; 0
		db 'h', 'i', 'k', 'l', 'm', 'n', 'o', 'p'; 8
		db 'r', 's', 't', 'u', 'v', 'w', 'y', '.'; 16
		db '"', 27h, ',', '!', 0Ah, 0; 24
_str_Hialphabet	db 'j', 'q', 'x', 'z', '0', '1', '2', '3'; 0
		db '4', '5', '6', '7', '8', '9', '0', '1'; 8
		db '2', '3', '4', '5', '6', '7', '8', '9'; 16
		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'; 24
		db 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P'; 32
		db 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X'; 40
		db 'Y', 'Z', '(', ')', '/', '\', '#', '*'; 48
		db '?', '<', '>', ':', ';', '-', '%', 0; 56
s_esc		db 'ESC',0
s_u		db '%U',0
s_victory		db 'vict',0
s_bardscr	db 'bardscr',0
s_iconFilePath	db 'icons.bin',0
s_getPictureError	db 'picture get error',0
bigpicIndexMultiplier	dw 2
word_4414E	dw 0FFh
aNorth		db 'north',0
aEast		db 'east',0
aSouth		db 'south',0
aWest		db 'west',0
g_printPartyFlag	dw 1
g_mouseLineMaskList	dw 1		; 0
		dw 2		; 1
		dw 4		; 2
		dw 8		; 3
		dw 10h		; 4
		dw 20h		; 5
		dw 40h		; 6
		dw 80h		; 7
		dw 100h		; 8
		dw 200h		; 9
		dw 400h		; 10
		dw 800h		; 11
		dw 1000h	; 12
		dw 2000h	; 13
		dw 4000h	; 14
		dw 8000h	; 15
byteMaskList	db 80h, 40h, 20h, 10h   ; 0
		db 8, 4, 2, 1		; 4
flagMaskList	db 7Fh, 0BFh, 0DFh, 0EFh; 0
		db 0F7h, 0FBh, 0FDh, 0FEh; 4
diceMaskList	db 1, 3		     ; 0
		db 7, 15		; 2
		db 31, 63		; 4
		db 127,	255		; 6
dirStringList	dd aNorth, aEast, aSouth,	aWest
dirDeltaN	dw 0FFFFh, 0,	1, 0	  ; 0
dirDeltaE	dw 0,	1, 0, 0FFFFh	  ; 0
northDelta	viewStruct <253, 3>	   ; 0
		viewStruct <254, 3>	; 1
		viewStruct <255, 3>	; 2
		viewStruct <0, 3>	; 3
		viewStruct <1, 3>	; 4
		viewStruct <2, 3>	; 5
		viewStruct <3, 3>	; 6
		viewStruct <253, 2>	; 7
		viewStruct <254, 2>	; 8
		viewStruct <255, 2>	; 9
		viewStruct <0, 2>	; 10
		viewStruct <1, 2>	; 11
		viewStruct <2, 2>	; 12
		viewStruct <3, 2>	; 13
		viewStruct <254, 1>	; 14
		viewStruct <255, 1>	; 15
		viewStruct <0, 1>	; 16
		viewStruct <1, 1>	; 17
		viewStruct <2, 1>	; 18
		viewStruct <255, 0>	; 19
		viewStruct <1, 0>	; 20
southDelta	viewStruct <3, 253>	   ; 0
		viewStruct <2, 253>	; 1
		viewStruct <1, 253>	; 2
		viewStruct <0, 253>	; 3
		viewStruct <255, 253>	; 4
		viewStruct <254, 253>	; 5
		viewStruct <253, 253>	; 6
		viewStruct <3, 254>	; 7
		viewStruct <2, 254>	; 8
		viewStruct <1, 254>	; 9
		viewStruct <0, 254>	; 10
		viewStruct <255, 254>	; 11
		viewStruct <254, 254>	; 12
		viewStruct <253, 254>	; 13
		viewStruct <2, 255>	; 14
		viewStruct <1, 255>	; 15
		viewStruct <0, 255>	; 16
		viewStruct <255, 255>	; 17
		viewStruct <254, 255>	; 18
		viewStruct <1, 0>	; 19
		viewStruct <255, 0>	; 20
eastDelta	viewStruct <3, 3>	  ; 0
		viewStruct <3, 2>	; 1
		viewStruct <3, 1>	; 2
		viewStruct <3, 0>	; 3
		viewStruct <3, 255>	; 4
		viewStruct <3, 254>	; 5
		viewStruct <3, 253>	; 6
		viewStruct <2, 3>	; 7
		viewStruct <2, 2>	; 8
		viewStruct <2, 1>	; 9
		viewStruct <2, 0>	; 10
		viewStruct <2, 255>	; 11
		viewStruct <2, 254>	; 12
		viewStruct <2, 253>	; 13
		viewStruct <1, 2>	; 14
		viewStruct <1, 1>	; 15
		viewStruct <1, 0>	; 16
		viewStruct <1, 255>	; 17
		viewStruct <1, 254>	; 18
		viewStruct <0, 1>	; 19
		viewStruct <0, 255>	; 20
westDelta	viewStruct <253, 253>	  ; 0
		viewStruct <253, 254>	; 1
		viewStruct <253, 255>	; 2
		viewStruct <253, 0>	; 3
		viewStruct <253, 1>	; 4
		viewStruct <253, 2>	; 5
		viewStruct <253, 3>	; 6
		viewStruct <254, 253>	; 7
		viewStruct <254, 254>	; 8
		viewStruct <254, 255>	; 9
		viewStruct <254, 0>	; 10
		viewStruct <254, 1>	; 11
		viewStruct <254, 2>	; 12
		viewStruct <254, 3>	; 13
		viewStruct <255, 254>	; 14
		viewStruct <255, 255>	; 15
		viewStruct <255, 0>	; 16
		viewStruct <255, 1>	; 17
		viewStruct <255, 2>	; 18
		viewStruct <0, 255>	; 19
		viewStruct <0, 1>	; 20
g_wild_deltaList	dd northDelta, eastDelta, southDelta,	westDelta; 0
g_tile_quadrantWidthList	db 3, 3, 3, 3, 3, 3,	3, 1, 1, 1; 0
		db 1, 1, 1, 6, 6, 6, 6,	6, 6, 6; 10
		db 10, 10, 10, 10, 10, 10, 2, 2, 2, 2; 20
		db 10, 10, 10, 10, 10, 10, 10, 10, 10, 10; 30
		db 10, 3, 3, 3,	3, 18, 18, 18, 10, 10; 40
		db 10, 10, 10, 10, 6, 6, 32, 32, 32, 11; 50
		db 11, 0		; 60
g_tile_quadrantScaleFactor	db 6, 6, 6, 6, 6, 6,	6, 6
		db 6, 6, 6, 6, 6, 12, 12, 12
		db 12, 12, 12, 12, 64, 64, 64, 64
		db 64, 64, 14, 14, 14, 14, 20, 20
		db 20, 20, 20, 64, 64, 64, 64, 64
		db 64, 20, 20, 20, 20, 36, 36, 36
		db 64, 64, 64, 64, 64, 64, 36, 36
		db 64, 64, 64, 64, 64, 0
g_tile_quadrantAspectOffsetList	db 2, 2, 2, 2, 2 	; 0
		db 2, 2, 0, 0, 0 	; 5
		db 0, 0, 0, 2, 2	; 10
		db 2, 2, 2, 2, 2	; 15
		db 0, 0, 0, 2, 2	; 20
		db 2, 0, 0, 0, 0	; 25
		db 2, 2, 2, 2, 2	; 30
		db 0, 0, 0, 2, 2	; 35
		db 2, 0, 0, 0, 0	; 40
		db 2, 2, 2, 0, 0	; 45
		db 0, 2, 2, 2, 0	; 50
		db 0, 2, 2, 2, 0	; 55
		db 0, 0			; 60
g_wild_viewSquareIndexList	db 1, 2, 3, 4
		db 5, 9, 11, 9
		db 10, 11, 15, 17
		db 15, 16, 17, 19
		db 20, 0
byte_44344	db 0, 255, 1, 1	   ; 0
		db 2, 255, 255,	1	; 4
		db 3, 255, 1, 1		; 8
		db 2, 255, 255,	1	; 12
byte_44354	db 0, 0FFh, 0FFh, 0FFh  ; 0
		db 0FFh, 0, 0FFh, 0FFh	; 4
		db 0FFh, 0FFh, 0FFh, 0FFh; 8
		db 0FFh, 0, 0FFh, 0FFh	; 12
dun_deltaNorth	viewStruct <253,	4>     ; 0
		viewStruct <254, 4>	; 1
		viewStruct <255, 4>	; 2
		viewStruct <0, 4>	; 3
		viewStruct <1, 4>	; 4
		viewStruct <2, 4>	; 5
		viewStruct <3, 4>	; 6
		viewStruct <253, 3>	; 7
		viewStruct <254, 3>	; 8
		viewStruct <255, 3>	; 9
		viewStruct <0, 3>	; 10
		viewStruct <1, 3>	; 11
		viewStruct <2, 3>	; 12
		viewStruct <3, 3>	; 13
		viewStruct <254, 2>	; 14
		viewStruct <255, 2>	; 15
		viewStruct <0, 2>	; 16
		viewStruct <1, 2>	; 17
		viewStruct <2, 2>	; 18
		viewStruct <255, 1>	; 19
		viewStruct <0, 1>	; 20
		viewStruct <1, 1>	; 21
		viewStruct <255, 0>	; 22
		viewStruct <0, 0>	; 23
		viewStruct <1, 0>	; 24
		viewStruct <255, 3>	; 25
		viewStruct <0, 3>	; 26
		viewStruct <1, 3>	; 27
		viewStruct <255, 2>	; 28
		viewStruct <0, 2>	; 29
		viewStruct <1, 2>	; 30
		viewStruct <255, 1>	; 31
		viewStruct <0, 1>	; 32
		viewStruct <1, 1>	; 33
dun_deltaSouth	viewStruct <3, 252>     ; 0
		viewStruct <2, 252>	; 1
		viewStruct <1, 252>	; 2
		viewStruct <0, 252>	; 3
		viewStruct <255, 252>	; 4
		viewStruct <254, 252>	; 5
		viewStruct <253, 252>	; 6
		viewStruct <3, 253>	; 7
		viewStruct <2, 253>	; 8
		viewStruct <1, 253>	; 9
		viewStruct <0, 253>	; 10
		viewStruct <255, 253>	; 11
		viewStruct <254, 253>	; 12
		viewStruct <253, 253>	; 13
		viewStruct <2, 254>	; 14
		viewStruct <1, 254>	; 15
		viewStruct <0, 254>	; 16
		viewStruct <255, 254>	; 17
		viewStruct <254, 254>	; 18
		viewStruct <1, 255>	; 19
		viewStruct <0, 255>	; 20
		viewStruct <255, 255>	; 21
		viewStruct <1, 0>	; 22
		viewStruct <0, 0>	; 23
		viewStruct <255, 0>	; 24
		viewStruct <1, 253>	; 25
		viewStruct <0, 253>	; 26
		viewStruct <255, 253>	; 27
		viewStruct <1, 254>	; 28
		viewStruct <0, 254>	; 29
		viewStruct <255, 254>	; 30
		viewStruct <1, 255>	; 31
		viewStruct <0, 255>	; 32
		viewStruct <255, 255>	; 33
dun_deltaEast	viewStruct <4, 3>	      ;	0
		viewStruct <4, 2>	; 1
		viewStruct <4, 1>	; 2
		viewStruct <4, 0>	; 3
		viewStruct <4, 255>	; 4
		viewStruct <4, 254>	; 5
		viewStruct <4, 253>	; 6
		viewStruct <3, 3>	; 7
		viewStruct <3, 2>	; 8
		viewStruct <3, 1>	; 9
		viewStruct <3, 0>	; 10
		viewStruct <3, 255>	; 11
		viewStruct <3, 254>	; 12
		viewStruct <3, 253>	; 13
		viewStruct <2, 2>	; 14
		viewStruct <2, 1>	; 15
		viewStruct <2, 0>	; 16
		viewStruct <2, 255>	; 17
		viewStruct <2, 254>	; 18
		viewStruct <1, 1>	; 19
		viewStruct <1, 0>	; 20
		viewStruct <1, 255>	; 21
		viewStruct <0, 1>	; 22
		viewStruct <0, 0>	; 23
		viewStruct <0, 255>	; 24
		viewStruct <3, 1>	; 25
		viewStruct <3, 0>	; 26
		viewStruct <3, 255>	; 27
		viewStruct <2, 1>	; 28
		viewStruct <2, 0>	; 29
		viewStruct <2, 255>	; 30
		viewStruct <1, 1>	; 31
		viewStruct <1, 0>	; 32
		viewStruct <1, 255>	; 33
dun_deltaWest	viewStruct <252, 253>   ;	0
		viewStruct <252, 254>	; 1
		viewStruct <252, 255>	; 2
		viewStruct <252, 0>	; 3
		viewStruct <252, 1>	; 4
		viewStruct <252, 2>	; 5
		viewStruct <252, 3>	; 6
		viewStruct <253, 253>	; 7
		viewStruct <253, 254>	; 8
		viewStruct <253, 255>	; 9
		viewStruct <253, 0>	; 10
		viewStruct <253, 1>	; 11
		viewStruct <253, 2>	; 12
		viewStruct <253, 3>	; 13
		viewStruct <254, 254>	; 14
		viewStruct <254, 255>	; 15
		viewStruct <254, 0>	; 16
		viewStruct <254, 1>	; 17
		viewStruct <254, 2>	; 18
		viewStruct <255, 255>	; 19
		viewStruct <255, 0>	; 20
		viewStruct <255, 1>	; 21
		viewStruct <0, 255>	; 22
		viewStruct <0, 0>	; 23
		viewStruct <0, 1>	; 24
		viewStruct <253, 255>	; 25
		viewStruct <253, 0>	; 26
		viewStruct <253, 1>	; 27
		viewStruct <254, 255>	; 28
		viewStruct <254, 0>	; 29
		viewStruct <254, 1>	; 30
		viewStruct <255, 255>	; 31
		viewStruct <255, 0>	; 32
		viewStruct <255, 1>	; 33
g_dun_deltaList	dd dun_deltaNorth, dun_deltaEast, dun_deltaSouth, dun_deltaWest	; 3
byte_44484	db 0, 1, 2, 2, 2, 0,	3, 4; 0
		db 3, 3, 4, 4, 4, 0, 3,	4; 8
byte_44494	db 3Dh, 38h,	2Dh, 1Eh, 0Dh, 0, 2, 2,	2, 2; 0
		db 2, 2, 2, 16h, 16h, 4, 4, 16h, 16h, 6; 10
		db 6, 6, 6, 6, 6, 6, 2Ch, 2Ah, 2Ch, 38h; 20
		db 36h,	38h, 18h, 8, 8,	18h, 0Ah, 0Ah, 0Ah; 30
		db 0Ah,	0Ah, 30h, 2Eh, 30h, 3Ch, 3Ah, 3Ch; 39
		db 0Ch,	0Ch, 0Ch, 0Ch, 0Eh, 0Eh, 0Eh, 34h; 47
		db 32h,	34h, 40h, 3Eh, 40h, 10h, 10h, 12h; 55
		db 12h,	12h, 14h, 14h, 0; 63
g_quadrantRightFlagList	db 0, 0, 0, 0	   ; 0
		db 0, 0, 0, 0		; 4
		db 0, 0, -1, -1		; 8
		db -1, 0, 0, 0		; 12
		db 0, 0, 0, 0		; 16
		db 0, 0, -1, 0		; 20
		db 0, -1, 0, 0		; 24
		db -1, -1, 0, 0		; 28
		db 0, 0, 0, 0		; 32
		db 0, -1, 0, 0		; 36
		db -1, 0, 0, -1		; 40
		db -1, 0, 0, 0		; 44
		db 0, 0, -1, 0		; 48
		db 0, -1, 0, -1		; 52
		db 0, 0, 0, 0		; 56
		db -1, 0		; 60
byte_44516	db 0, 1, 2, 3, 4, 5,	6, 1, 2, 3, 3, 4, 5; 0
		db 7, 8, 9, 0Ah, 0Bh, 0Ch, 0Dh,	19h, 1Ah; 13
		db 1Bh,	19h, 1Ah, 1Bh, 9, 0Ah, 0Ah, 0Bh; 22
		db 0Eh,	0Fh, 10h, 11h, 12h, 1Ch, 1Dh, 1Eh; 30
		db 1Ch,	1Dh, 1Eh, 0Fh, 10h, 10h, 11h, 13h; 38
		db 14h,	15h, 1Fh, 20h, 21h, 1Fh, 20h, 21h; 46
		db 14h,	14h, 16h, 17h, 18h, 17h, 17h, 0; 54
byte_44554	db 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 0, 0, 0; 0
		db 4, 4, 4, 4, 4, 4, 4,	4, 4, 4, 0, 0, 0; 13
		db 8, 8, 0, 0, 4, 4, 4,	4, 4, 4, 4, 4, 0; 26
		db 0, 0, 8, 8, 0, 0, 4,	4, 4, 4, 4, 4, 0; 39
		db 0, 0, 8, 0, 4, 4, 4,	8, 0, 0; 52
g_tile_quadrantCoordinates	coordinate_t <12, 42>	   ; 0
		coordinate_t <15, 42>	; 1
		coordinate_t <18, 42>	; 2
		coordinate_t <21, 42>	; 3
		coordinate_t <24, 42>	; 4
		coordinate_t <27, 42>	; 5
		coordinate_t <30, 42>	; 6
		coordinate_t <5, 38>	; 7
		coordinate_t <12, 38>	; 8
		coordinate_t <26, 38>	; 9
		coordinate_t <29, 38>	; 10
		coordinate_t <31, 38>	; 11
		coordinate_t <39, 38>	; 12
		coordinate_t <254, 38>	; 13
		coordinate_t <5, 38>	; 14
		coordinate_t <17, 44>	; 15
		coordinate_t <24, 44>	; 16
		coordinate_t <31, 44>	; 17
		coordinate_t <33, 38>	; 18
		coordinate_t <40, 38>	; 19
		coordinate_t <13, 33>	; 20
		coordinate_t <21, 33>	; 21
		coordinate_t <31, 33>	; 22
		coordinate_t <13, 55>	; 23
		coordinate_t <21, 55>	; 24
		coordinate_t <31, 55>	; 25
		coordinate_t <255,	38>	; 26
		coordinate_t <23, 38>	; 27
		coordinate_t <31, 38>	; 28
		coordinate_t <42, 38>	; 29
		coordinate_t <2, 42>	; 30
		coordinate_t <12, 42>	; 31
		coordinate_t <23, 42>	; 32
		coordinate_t <34, 42>	; 33
		coordinate_t <45, 42>	; 34
		coordinate_t <4, 21>	; 35
		coordinate_t <20, 21>	; 36
		coordinate_t <34, 21>	; 37
		coordinate_t <4, 63>	; 38
		coordinate_t <20, 63>	; 39
		coordinate_t <34, 63>	; 40
		coordinate_t <3, 35>	; 41
		coordinate_t <19, 35>	; 42
		coordinate_t <33, 35>	; 43
		coordinate_t <48, 35>	; 44
		coordinate_t <0, 35>	; 45
		coordinate_t <18, 35>	; 46
		coordinate_t <37, 35>	; 47
		coordinate_t <0, 8>	; 48
		coordinate_t <17, 4>	; 49
		coordinate_t <44, 8>	; 50
		coordinate_t <0, 77>	; 51
		coordinate_t <17, 77>	; 52
		coordinate_t <44, 77>	; 53
		coordinate_t <12, 22>	; 54
		coordinate_t <37, 22>	; 55
		coordinate_t <235, 22>	; 56
		coordinate_t <11, 22>	; 57
		coordinate_t <43, 22>	; 58
		coordinate_t <0, 0>	; 59
		coordinate_t <44, 0>	; 60
byte_4460C	db 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0; 0
		db 0, 0, 0FFh, 0FFh, 0FFh, 0, 0, 0, 0, 0; 13
		db 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0FFh, 0FFh; 23
		db 0FFh, 0, 0, 0, 0, 0,	0, 0, 0, 0FFh, 0FFh; 33
		db 0, 0FFh, 0FFh, 0FFh,	0, 0, 0, 0, 0, 0; 44
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 54
		db 0			; 61
g_wild_squareTopologyIndex	db 30, 31, 32, 33
		db 34, 42, 43, 45
		db 46, 47, 54, 55
		db 56, 57, 58, 59
		db 60, 0
include(`data/buildings/storage/inventory.asm')
bigpicLightOffset dw 0,	460h, 818h, 9A0h, 8C0h;	0
bigpicLightSize	dw 1340h, 0A80h, 620h, 348h, 1C0h; 0
g_iconXOffset	db 80, 92, 108, 124, 136, 0; 0
g_iconHeight	db 19, 26, 17, 20, 16, 0; 0
g_iconWidth	db 12, 16, 16, 12, 20, 0; 0
g_iconDataPointers	dd	iconLight, iconCompass,	iconAreaEnchant, iconShield, iconLevitation; 0
g_iconCellDataLength	dw 0E4h, 1A0h, 110h,	0F0h, 140h; 0
byte_44718	db 0, 0, 0, 0, 0, 0	   ; 0
g_iconAnimationDelay	db 2, 0, 4, 0, 3, 0	   ; 0
g_iconCurrentDelay db 0, 0, 0,	0, 0, 0	    ; 0
g_iconClearIndex	db 4, 4, 4, 1, 4, 0	   ; 0
g_iconCurrentCell	db 0, 0, 0, 0, 0, 0

include(`data/spells/names.asm')

s_spellPoints	db 'Spell Points:',0
s_expr		db 'Expr:',0
s_gold		db 'Gold:',0
s_poolGold	db 0Ah,0Ah
		db '     Pool  gold',0Ah
		db '     Trade gold',0
s_tradeGoldToWhom	db 'Trade gold to whom?',0
s_howMuchGoldToTrade	db 'How much gold will you trade?',0
align 2
s_done		db 'Done!',0
s_inventory	db 'Inventory',0
s_inventoryVarString	db ' Do you wish to:',0Ah
		db 0Ah,0Ah,0Ah
		db '@Trade the item',0Ah
		db '@Discard the item',0Ah
		db '@Equip the item',0Ah
		db '@Unequip the item',0Ah
		db '@Identify the item',0
align 2
s_itsFilledWith	db 0Ah,'It',27h,'s filled with ',0
s_triesToIdentify	db ' tries to identify the item...',0Ah
		db 'and /succeed\fail\s!!',0
align 2
s_whoDoes	db 'Who does ',0
s_wantToGiveItTo	db ' want to give it to?',0
align 2
s_dontKnowAnySpells	db 'You don',27h,'t know any spells.',0
align 2
s_knownSpells	db 'Known spells',0
align 2
s_rogueAbilities	db 'Rogue abilities',0
s_disarmTraps	db 'Disarm traps ',0
s_identifyChest	db 'Identify chest ',0
s_identifyItem	db 'Identify item ',0
align 2
s_hideInShadows	db 'Hide in shadows ',0
align 2
s_criticalHit	db 'Critical hit ',0
s_bardAbilities	db 'Bard abilities',0
align 2
s_tunesLeft	db 'Number of tunes left: ',0
align 2
s_hunterAbilities	db 'Hunter abilities',0
align 2
s_pocketsAreEmpty db 'Your pockets are empty.',0
s_attributeAbbreviations	db 'StIQDxCnLkHP',0
align 2

include(`data/items/strings.asm')
include(`data/items/baseCount.asm')
include(`data/items/damageDice.asm')
include(`data/items/bonuses.asm')
include(`data/items/genericTypes.asm')
include(`data/items/equip.asm')
include(`data/items/equippedEffectList.asm')
include(`data/items/spellNumber.asm')
include(`data/character/races.asm')
include(`data/character/genders.asm')

s_isAn		db ' is a/n \ ',0
align 2
s_level		db 'Level',0
g_acDexterityBonus db 1, 1, 2, 2		 ; 0
		db 3, 3, 3, 4		; 4
		db 4, 4, 4, 4		; 8
		db 5, 5, 5, 5		; 12
		db 5, 0			; 16
g_itemFlagCharacters	db ' ', '|', '^', '?', 0, 0; 0 ; This is a list of characters used in the inventory
			; string for flags.
			
			
			
g_inventoryActionFunctions	dd inventory_trade, inventory_discard, inventory_equip, inventory_unequip, inventory_identify;	0
s_escToContinue	db 'ESC to continue',0
s_thereAreStairs	db 'There are stairs here, going /up\down\. ',0Ah
		db 'Do you wish to take them?',0
align 2
s_whoWantsToGetThe	db 'Who wants to get the ',0
align 2
s_gotThe		db ' got the ',0
s_youDontHaveEnoughGold	db 'You don',27h,'t have enough gold',0
s_zounds		db 'Zounds',0
s_percentD		db '%d',0Ah,0
s_percentX		db '%x',0Ah,0
s_badOpcode	db 'bad opcode',0
vm_functionList	dd mfunc_downStairs ;	0
		dd mfunc_upStairs	; 1
		dd mfunc_utility		; 2
		dd mfunc_teleport	; 3
		dd mfunc_battle		; 4
		dd mfunc_clearPrintString ; 5
		dd mfunc_clearSpecial		; 6
		dd mfunc_drawBigpic	; 7
		dd mfunc_setTitle	; 8
		dd mfunc_waitForIo	; 9
		dd mfunc_clearText ; a
		dd mfunc_ifFlag		; b
		dd mfunc_ifNotFlag	; c
		dd mfunc_makeDoor		; d
		dd mfunc_setFlag	; e
		dd mfunc_clearFlag	; f
		dd mfunc_ifCurSpellEQ	; 10
		dd mfunc_setMapRval	; 11
		dd mfunc_printString	; 12
		dd mfunc_doNothing	; 13
		dd mfunc_ifLiquid	; 14
		dd mfunc_getItem	; 15
		dd mfunc_ifPartyHasItem	; 16
		dd mfunc_ifPartyNotHasItem	; 17
		dd mfunc_ifSameSquare	; 18
		dd mfunc_ifYesNo	; 19
		dd mfunc_goto		; 1a
		dd mfunc_battleNoCry	; 1b
		dd mfunc_setSameSquareFlag	; 1c
		dd mfunc_turnAround	; 1d
		dd mfunc_removeItem	; 1e
		dd mfunc_incrementRegister	; 1f
		dd mfunc_decrementRegister	; 20
		dd mfunc_ifRegisterClear	; 21
		dd mfunc_ifRegisterSet	; 22
		dd mfunc_drainHp	; 23
		dd mfunc_ifInBox	; 24
		dd mfunc_setLiquid	; 25
		dd mfunc_addToContainer	; 26
		dd mfunc_subtractFromContainer	; 27
		dd mfunc_addToRegister	; 28
		dd mfunc_subtractFromRegister ; 29
		dd mfunc_setDirection	; 2a
		dd mfunc_readString	; 2b
		dd mfunc_ifStringEquals	; 2c
		dd mfunc_parseNumber	; 2d
		dd mfunc_getCharacter	; 2e
		dd mfunc_ifGiveGold	; 2f
		dd mfunc_addGold		; 30
		dd mfunc_ifRegisterLt	; 31
		dd mfunc_ifRegisterEq	; 32
		dd mfunc_ifRegisterGe	; 33
		dd mfunc_learnSpell	; 34
		dd mfunc_setRegister	; 35
		dd mfunc_ifHasItem	; 36
		dd mfunc_packInventory	; 37
		dd mfunc_addMonster	; 38
		dd mfunc_ifMonsterInParty	; 39
		dd mfunc_clearPrintOffset ; 3a
		dd mfunc_ifIsNight	; 3b
		dd mfunc_removeMonster	; 3c
;		dd mfunc_buggedIfQuestFlagSet		; 3d
		dd mfunc_notImplemented		; 3d
		dd mfunc_ifQuestFlagNotSet		; 3e
		dd mfunc_setQuestFlag ; 3f
		dd mfunc_clearQuestFlag		; 40
		dd mfunc_partyUnderLevel		; 41
		dd mfunc_ifWildFace ; 42
		dd mfunc_setWildFace	; 43
		dd mfunc_ifIsClass	; 44
		dd mfunc_printOffset ; 45
		dd mfunc_clearTeleport	; 46
s_notImplemented	db 'this function is not implemented',0
align 2
aKilling	db ', killing ',0
aPoisoning	db ', poisoning ',0
aDraining	db ', draining ',0
aCrazing	db ', crazing ',0
aWithering	db ', withering ',0
aPossessing 	db ', possessing ',0
aStoning	db ', stoning ',0
aCriticallyHitt	db ', critically hitting ',0
aStealing	db ', stealing ',0
aPhazing	db ', phazing ',0
aSwingsAt	db 'swings at',0
aSlashesAt	db 'slashes at',0
aKicksAt	db 'kicks at',0
aPunchesAt	db 'punches at',0
aClawsAt	db 'claws at',0
aTearsAt	db 'tears at',0
aBitesAt	db 'bites at',0
aGnawsOn	db 'gnaws on',0
aStabsAt	db 'stabs at',0
aSlicesAt	db 'slices at',0
aSlams		db 'slams',0
aStrikesAt	db 'strikes at',0
aGropesAt	db 'gropes at',0
aReachesToward	db 'reaches toward',0
aPeersAt	db 'peers at',0
aStaresAt	db 'stares at',0
s_dissentionInYourRanks	db 'Dissention in your ranks...',0Ah
db 0Ah,0
s_willThereBeAnEnd	db '"Will there ever be an end to them?" you shout. You see ',0
s_enjoyYourNextLife	db '"Enjoy your next life!" you snarl. You see ',0
s_yourBattlecry	db 'Your battlecry is heard by all as you face ',0
s_yourOnslaught	db 'Your onslaught is greeted with laughter, you face ',0
s_notAgainYouMoan	db '"Not again!" you moan as you face ',0
s_gimmeABreak	db '"Gimme a break! Where do they come from?" You see ',0
align 2
specialAttString dd aKilling, aPoisoning, aDraining, aCrazing, aWithering; 0
		dd aPossessing,	aStoning, aCriticallyHitt, aStealing, aPhazing;	5
breathAttack	breathAtt_t <0, 0, 0, 0, 0, 41h, 1>; 0
		db    0
s_youStillFace	db 'You still face ',0
s_continueQuestion	db 'Do you wish to continue?',0Ah,0
s_butMisses	db ', but misses!',0Ah,0Ah,0
s_periodNlNl	db '.', 0Ah, 0Ah,0
s_exclBlankLine		db '!',0Ah, 0Ah,0
s_jumpsIntoShadows	db ' jumps into the shadows, ',0
s_andSucceeds	db 'and succeeds!',0Ah,0Ah,0
s_butIsDiscovered db 'but is discovered!',0Ah,0Ah,0
		db    0
s_summonsHelp	db ' summons help and ',0
		db    0
s_noneAppears	db 'none appears...',0Ah,0Ah,0
s_anotherJoins db	'another joins the fray!',0Ah,0Ah,0
s_the		db	'The ',0
		db    0
s_advances	db ' advance/s\!',0Ah,0Ah,0
		db    0
s_butMisses_0	db ', but misses',0
		db    0
s_willYourGallantBand db	'Will your gallant band choose to:',0Ah
		db '@Fight bravely',0Ah
		db '@Advance ahead',0Ah
		db '@Run away',0Ah,0
		db    0
s_thePartyAdvances db 0Ah,0Ah,'The party advances!',0Ah,0Ah,0
s_hasTheseOptions db ' has these options this battle round:',0Ah,0Ah
		db '@Attack foes ',0
		db    0
s_attackDistString	db '10',27h,0
s_characterOptionsString db 0Ah
		db '@Defend',0Ah
		db '@Party attack',0Ah
		db '@Cast a spell',0Ah
		db '@Use an item',0Ah
		db '@Hide in shadows',0Ah
		db '@Bard Song',0Ah,0
		db    0
s_selectAnOption db 0Ah,0Ah,'Select an option.',0
s_nlUseOn	db 0Ah,'Use on ',0
		db    0
s_youCantUseThatItem db	'You can',27h,'t use that item.',0
		db    0
s_attack	db 0Ah,'Attack ',0
		db    0
s_useTheseCommands db 'Use these commands?',0Ah,0Ah,0
s_andHits	db ', and hits ',0
s_timesFor	db ' times for ',0
s_andHitsFor	db ', and hits for ',0
s_firesBreathes	db ' /fir\breath\es ',0
		db    0
s_lost		db ' lost ',0
		db    0
s_voice		db ' voice!',0Ah,0Ah,0
s_plays	db ' plays...',0Ah,0Ah,0
s_hostilePartyMembers db	'hostile party members!',0Ah,0Ah,0
		db    0
s_comma	db ',',0
s_and		db 'and ',0
		db 0
s_party		db 'Party',0
s_sorryBud	db 'Sorry, Bud',0
		db    0
s_partyHasExpired db	'Alas, your party has expired, but gone to adventurer heaven.',0
		db    0
include(`data/character/monkDamage.asm')
monMeleeAttString dd aSwingsAt		  ; 0
		dd aSlashesAt		; 1
		dd aKicksAt		; 2
		dd aPunchesAt		; 3
		dd aClawsAt		; 4
		dd aTearsAt		; 5
		dd aBitesAt		; 6
		dd aGnawsOn		; 7
		dd aStabsAt		; 8
		dd aSlicesAt		; 9
		dd aSlams		; 10
		dd aStrikesAt		; 11
		dd aGropesAt		; 12
		dd aReachesToward	; 13
		dd aPeersAt		; 14
		dd aStaresAt		; 15
itemLevMask	db 0, 81h, 81h, 81h, 81h, 81h, 81h,	81h; 0
		db 81h,	81h, 81h, 81h, 81h, 81h, 81h, 81h; 8
		db 81h,	81h, 81h, 81h, 81h, 81h, 0C1h, 41h; 16
		db 41h,	41h, 41h, 41h, 41h, 41h, 41h, 41h; 24
		db 41h,	41h, 41h, 41h, 41h, 41h, 41h, 41h; 32
		db 41h,	41h, 41h, 41h, 41h, 41h, 41h, 31h; 40
		db 31h,	31h, 31h, 31h, 31h, 31h, 31h, 31h; 48
		db 31h,	31h, 31h, 31h, 31h, 31h, 31h, 31h; 56
		db 31h,	31h, 31h, 31h, 31h, 31h, 31h, 31h; 64
		db 31h,	19h, 19h, 19h, 19h, 19h, 19h, 19h; 72
		db 19h,	19h, 19h, 19h, 19h, 19h, 19h, 19h; 80
		db 19h,	19h, 19h, 19h, 19h, 19h, 19h, 19h; 88
		db 19h,	19h, 19h, 19h, 19h, 19h, 19h, 19h; 96
		db 19h,	19h, 19h, 19h, 19h, 19h, 19h, 19h; 104
		db 0, 0, 0, 0, 0, 0, 0FFh, 0; 112
		db 0, 0, 0, 0, 0, 0FFh,	9, 9; 120
		db 9, 9, 9, 9, 9, 9, 9,	0; 128
		db 0, 0, 9, 9, 9, 9, 9,	9; 136
		db 9, 0, 0, 0, 0, 0, 0,	0; 144
		db 0, 0, 0, 0, 0, 0, 5,	5; 152
		db 0, 0, 0, 0, 0, 9, 9,	9; 160
		db 9, 0, 0, 3, 3, 41h, 9, 11h; 168
		db 5, 1, 0, 0, 0, 9, 9,	9; 176
		db 9, 9, 9, 9, 9, 9, 9,	9; 184
		db 9, 9, 9, 7Fh, 5, 5, 5, 5; 192
		db 5, 5, 5, 5, 5, 5, 5,	5; 200
		db 5, 5, 5, 5, 5, 3, 3,	3; 208
		db 3, 3, 3, 3, 3, 3, 3,	1Dh; 216
		db 0, 0, 0, 0, 0, 0, 0,	0; 224
		db 0, 0, 0, 0, 0, 0, 0,	0; 232
		db 1, 1, 1, 1, 1, 1, 1,	1; 240
		db 1, 0, 0, 0, 0, 0, 0,	0; 248
g_battleCryList	dd s_dissentionInYourRanks	; 0
		dd s_willThereBeAnEnd	; 1
		dd s_enjoyYourNextLife	; 2
		dd s_yourBattlecry	; 3
		dd s_yourOnslaught	; 4
		dd s_notAgainYouMoan	; 5
		dd s_gimmeABreak	; 6
s_memberOneToSeven	db 'member #(1-7)',0
s_memberOne	db 'member #(1)',0
s_or		db ' or ',0
		db    0
vowelList	db 'A', 'E', 'I', 'O', 'U', 0               ; 4
g_classBaseAttackPriority	db 5, 7, 7, 3	   ; 0
		db 3, 0, 0, 5		; 4
		db 5, 0Ah, 0Fh,	0Fh	; 8
		db 16h			; 12
s_badDiceMaskRange db 'Bad dice mask range',0
		db    0
g_batPartyOptionFunctions	dd bat_partyFightAction
		dd bat_partyAdvanceAction
		dd bat_partyRunAction
g_batCharOptionFunctions	dd bat_charAttackAction, bat_charDefendAction; 0
		dd bat_charPartyAttackAction, bat_charCastAction; 2
		dd bat_charUseAction, bat_charHideAction;	4
		dd bat_charSingAction		; 6
g_classToHitBonus	db 3, 1, 1, 1, 1, 0, 0, 3, 3, 4, 1, 1, 4, 0
g_monsterAcBonusList	db 3, 2, 0, 0FEh	   ; 0
g_monsterAdvanceSpeedAcBonusList	db 0FFh, 0FFh, 0FFh, 0, 0, 0, 0, 0, 1, 1
s_experiencePoinsForV db ' experience points for valor and battle knowledge, and ',0
s_theyDisbelieve	db 'They disbelieve!',0Ah,0Ah,0
		db    0
s_inGold	db ' in gold.',0Ah,0Ah,0
s_foundA		db ' found a ',0
s_eachCharacterReceives db 'Each character receives ',0
		db    0
s_thePartyDisbelieves db 'The party disbelieves...',0Ah,0Ah,0
		db    0

include(`battle/chest/data.asm')

poisonDmg	db 1, 2, 4, 8, 0Ah, 10h, 14h, 18h; 0
s_treasure	db 'Treasure',0
aFried		db 'fried',0
aFrozen		db 'frozen',0
aShocked	db 'shocked',0
aDrained	db 'drained',0
aBurnt		db 'burnt',0
aChoked		db 'choked',0
aSteamed	db 'steamed',0
aBlasted	db 'blasted',0
aHit		db 'hit',0
aNuked		db 'nuked',0
aLessThirsty_	db 'less thirsty.',0Ah,0Ah,0
aHicHappier_	db '(hic) happier.',0Ah,0Ah,0
aRefreshed	db 'refreshed!',0Ah,0Ah,0
aTerrible_	db 'terrible.',0Ah,0Ah,0
aYouCanOnlyCast	db 'You can only cast that in combat',0Ah,0Ah,0
align 2
s_atTheParty	db 'at the party...',0Ah,0Ah,0
s_partyTooFarAway	db 'But the party was too far away!',0Ah,0Ah,0
s_at		db 'at ',0
s_some		db 'some ',0
s_elipsisNl	db '...',0Ah,0Ah,0
s_one		db 'One ',0
align 2
s_repelledAttack	db 'repelled the attack!',0Ah,0Ah,0
align 2
s_wasTooFarAway db 'was too far away!',0Ah,0Ah,0
s_is		db 'is ',0
a_for		db	' for ',0
s_pointsOfDamage	db ' point/\s\ of damage',0
align 2
s_capitalAnd		db	'And ',0
align 2
s_partyFreezes	db 'and the party freezes',0
s_butItHadNoEffect	db 'but it had no effect!',0Ah,0Ah,0
s_closer		db 'closer',0
align 2
s_fartherAway	db 'farther away',0
align 2
s_andTheFoesAre	db 'and the foes are ',0
align 2
s_theParty	db 'the party!',0
align 2
s_earthSwallows	db 'and the earth swallows up ',0
align 2
s_whichItem	db 'Which item?',0
s_spellAborted	db 'Spell aborted.',0
align 2
s_itemIdentified	db 'Item has been identified!',0
s_dopplganger	db 'Dopplganger',0
s_ateIt		db 'ate it.',0Ah,0Ah,0
s_drinksAndFeels	db 'drinks and feels ',0
drinkStringList	dd aLessThirsty_, aHicHappier_, aRefreshed, aTerrible_, aTerrible_;	0
s_cantFindUse	db 'can',27h,'t seem to find a use for the item.',0Ah,0Ah,0
align 2
s_invokesFigurine	db 'invokes a figurine ',0
s_isReenergized	db 'is re-energized!',0Ah,0Ah,0
align 2
s_castsWeapon	db 'casts a weapon ',0
s_breathes	db 'breathes ',0
s_teleportMenu	db 'Teleport',0Ah
		db '<Use arrow keys and SPC to select>',0Ah
		db 'North:',0Ah
		db 'East :',0Ah,0
s_downUp		db '/Down\Up  \ :',0Ah,0
align 2
s_confirmTeleport	db 0Ah,'Teleport?',0Ah,0Ah,0
align 2
s_cancelTeleport	db 'Teleport cancelled!',0
s_failedTeleport	db 'Teleport failed!',0
align 2
s_successfulTeleport	db 'Teleport successful!',0
align 2

include(`data/spells/scry.asm')
include(`data/spells/castFlags.asm')
include(`data/spells/effectData.asm')
include(`data/spells/extraData.asm')
include(`data/spells/spellPoints.asm')
breathEffectStr	dd aFried, aFrozen, aShocked, aDrained, aBurnt; 0
		dd aChoked, aSteamed, aBlasted, aHit, aNuked;	5

include(`data/spells/damage.asm')
include(`data/items/useableWeapons.asm')
include(`data/items/figurines.asm')
s_castAt		db 'Cast at ',0
		db    0
s_whoWillCast	db 'Who will cast a spell?',0
		db    0
s_dontKnowThatSpell db 'You don',27h,'t know that spell!',0
		db    0
s_noSpellByThatName	db 'No spell by that name.', 0
s_notEnoughSppt	db 'Not enough spell points!',0
		db    0
s_spellToCast db	'Spell to cast:',0
		db    0
aWhichMagicArtShallYou db 'Which magic art shall you invoke?',0
		db ') ',0
		db    0
s_castsASpell	db 'casts a spell',0
s_butItFizzled	db 'but it fizzled!',0
s_butItFizzledNl	db 'but it fizzled!',0Ah,0Ah,0
s_makesLight	db 'makes a light',0
mageSpellIndex	db 255, 42, 28, 0       ; 0 ; This array	is an index into another array for
		db 14, 255, 255, 255	; 4 ; determining the spells that a magic user has.
		db 255,	255, 56, 70	; 8
		db 84, 255, 255, 0	; 12
s_notSpellcaster	db 'Thou art not a spellcaster',0
		db    0
include(`data/spells/light.asm')
classSavingBonus	db 0, 0Ah, 0Ah, 5	   ; 0
		db 5, 0, 0, 5		; 4
		db 0, 0, 11h, 11h	; 8
		db 16h,	0		; 12
word_484CC	dw 1Eh
		db  1Eh
		db    0
		db    7
		db    0
include(`data/spells/batch.asm')
include(`data/spells/geomancer.asm')
include(`data/spells/functions.asm')

aSirRobinSTune	db 'Sir Robin',27h,'s Tune',0
aSafetySong	db 'Safety Song',0
aSanctuaryScore	db 'Sanctuary Score',0
aBringaroundBal	db 'Bringaround Ballad',0
aRhymeOfDuotime	db 'Rhyme of Duotime',0
aWatchwoodMelod	db 'Watchwood Melody',0
aKielSOverture	db 'Kiel',27h,'s Overture',0
aMinstrelShield	db 'Minstrel Shield',0
s_whoWillPlay	db 'Who will play?',0
align 2
s_notBard	db 'Not a bard!',0
s_notUsingInstrument	db 'You aren',27h,'t using an instrument!',0
s_dryThroat	db 'Your throat is dry!',0
songNames	dd aSirRobinSTune, aSafetySong, aSanctuaryScore, aBringaroundBal; 0
		dd aRhymeOfDuotime, aWatchwoodMelod, aKielSOverture, aMinstrelShield; 4
s_stopPlayingSong	db 'Stop playing a song',0
g_instrumentType	db 14h dup(0), 1, 14h dup(0), 2, 0Ch dup(0), 2, 16h dup(0), 1
		db 34h dup(0), 2, 4Eh dup(0), 2, 3, 6 dup(0), 1, 4 dup(0)
		db 3, 21h dup(0)
aGillesGillsFor	db 'Gilles Gills for ',0
aDivineInterven	db 'Divine Intervention for ',0
aGotterdamuru_0	db 'Gotterdamurung for ',0
aStrength_	db 'strength.',0
aIntelligence_	db 'intelligence.',0
aDexterity_	db 'dexterity.',0
aConstitution_	db 'constitution.',0
aLuck_		db 'luck.',0
aWizard_0	db 'Wizard',0Ah,0
aSorcerer_0	db 'Sorcerer',0Ah,0
aConjurer_0	db 'Conjurer',0Ah,0
aMagician_0	db 'Magician',0Ah,0
aArchmage_0	db 'Archmage',0Ah,0
aChronomancer_0	db 'Chronomancer',0Ah,0
spellLevelCost	dw 100, 1000, 2000, 4000, 7000, 10000, 20000; 0
g_spellLevelData	spellAdvance <0, 3>	   ; 0
		spellAdvance <3, 3>	; 1
		spellAdvance <6, 3>	; 2
		spellAdvance <9, 2>	; 3
		spellAdvance <11, 2>	; 4
		spellAdvance <13, 2>	; 5
		spellAdvance <15, 4>	; 6
		spellAdvance <19, 3>	; 7
		spellAdvance <22, 3>	; 8
		spellAdvance <25, 3>	; 9
		spellAdvance <28, 2>	; 10
		spellAdvance <30, 2>	; 11
		spellAdvance <32, 2>	; 12
		spellAdvance <34, 4>	; 13
		spellAdvance <38, 3>	; 14
		spellAdvance <41, 3>	; 15
		spellAdvance <44, 3>	; 16
		spellAdvance <47, 2>	; 17
		spellAdvance <49, 2>	; 18
		spellAdvance <51, 2>	; 19
		spellAdvance <53, 4>	; 20
		spellAdvance <57, 2>	; 21
		spellAdvance <59, 2>	; 22
		spellAdvance <61, 2>	; 23
		spellAdvance <63, 2>	; 24
		spellAdvance <65, 2>	; 25
		spellAdvance <67, 2>	; 26
		spellAdvance <69, 2>	; 27
		spellAdvance <71, 2>	; 28
		spellAdvance <73, 1>	; 29
		spellAdvance <74, 1>	; 30
		spellAdvance <75, 1>	; 31
		spellAdvance <76, 1>	; 32
		spellAdvance <77, 1>	; 33
		spellAdvance <78, 1>	; 34
		spellAdvance <79, 3>	; 35
		spellAdvance <82, 2>	; 36
		spellAdvance <86, 2>	; 37
		spellAdvance <90, 2>	; 38
		spellAdvance <94, 2>	; 39
		spellAdvance <98, 2>	; 40
		spellAdvance <102, 2>	; 41
		spellAdvance <106, 3>	; 42
		spellAdvance <109, 3>	; 43
		spellAdvance <112, 2>	; 44
		spellAdvance <114, 2>	; 45
		spellAdvance <116, 2>	; 46
		spellAdvance <118, 2>	; 47
		spellAdvance <120, 2>	; 48
g_spellsForSalePrice	dd 10000, 50000, 50000	 ; 0
s_hallOfWizards	db	'Thou art in the hall of wizards. Would thou like...',0Ah,0Ah
		db 'Advancement',0Ah
		db 'Spell Acquiring',0Ah
		db 'Buy a new spell',0Ah
		db 'Exit the hall',0
		db    0
aTheGuildEldersPrepare	db 'The Guild elders prepare to weigh thy merits.',0Ah,0Ah
		db 'Who shall be reviewed?',0
aTheGuildEldersDeemTha	db 'The Guild elders deem that ',0
s_cannotBeRaisedLevels_	db ' cannot be raised levels.',0
s_eldersTeachLore	db 'The Elders teach you the lore.',0
		db    0
s_buySpellPrompt	db 'Who seeks the special knowledge of the mystic arts?',0
s_thouMayLearn	db 'Thou may learn ',0
g_spellsForSaleList	dd aGillesGillsFor, aDivineInterven; 0
			dd aGotterdamuru_0	; 2
s_inGoldWhoWillPay	db ' in gold. Who will pay?',0
s_lastOfTheGuildElders	db 'The last of the guild elders is here. Would you like...',0Ah,0Ah
		db 'Advancement',0Ah
		db 'Spell Acquiring',0Ah
		db 'Class Change',0Ah
		db 'Talk to the elder',0Ah
		db 'Exit the guild',0
align 2
s_elderWeighsMerits	db 'The Guild elder prepares to weigh your merits.',0Ah,0Ah
		db 'Who shall be reviewed?',0
align 2
s_elderDeadCharacter	db '"Hmmm... Should I make you into a zombie perhaps?!?"',0
align 2
s_guildElderDeems	db 'The Guild elder deems that ',0
s_cannotBeRaised	db ' cannot be raised levels.',0
s_stillNeedeth	db ' still needeth ',0
s_experiencePoints	db ' experience points prior to advancement.',0
align 2
s_hathEarnedLevel	db ' hath earned a level of advancement...',0
align 2
s_plusOneTo		db	'+1 to ',0
align 2
fullAttributeString	dd aStrength_, aIntelligence_, aDexterity_;	0
			dd aConstitution_, aLuck_; 3
s_whoSeeksKnowledge	db 'Who seeks knowledge of the mystic arts?',0
s_learnedAllSpells	db 'Thou hath learned all the spells in thy art.',0
align 2
s_cannotAcquireNewSpells	db 'Thou cannot acquire new spells yet.'
		db 0
s_spellLevel	db ' spell level ',0
s_willCost	db ' will cost ',0
s_notEnoughGoldNl	db 'Not enough gold.',0Ah,0
s_elderTeachersLore	db 'The Elder teaches you the lore.',0
s_whichMageSeeksChange	db 'Which mage seeks to change classes?'
		db 0
s_cannotChangeClass	db 'Thou cannot change class.',0
s_mustKnowThreeSpellLevels	db 'You must know at least 3 spell levels in your present art first.',0
align 2
s_doesntQualifyForNewClass	db 'Thee doesn',27h,'t qualify for any new class.',0
s_newClassPrompt	db 0Ah,'Which class shall thee become?',0
s_convertChronomancerPrompt	db 'Thee understands the sacrifice, dost thou not? Thee will be stripped of all thy spells and knowledge thereof. Thee will be more powerful than ever before, but more vulnerable as well.',0
s_dostThouAccept	db 'Dost thou accept this sacrifice?',0Ah,0Ah,0
align 2
s_arboriaSpellText	db '"Know this, the spell to enter Arboria is invoked by uttering ARBO and the spell to return is ENIK. Be wary, for the spells only work in one place in the land."',0
align 2
s_arboriaSpellLocation	db '"There is a large grove of trees just south of Skara Brae. The spell will work there."',0
align 2
s_beginsNewProfession	db 'Now thou begins thy new profession.'
		db 0
s_desertedReviewBoard	db 'The old review board is deserted.',0
magicUserString	dd aWizard_0, aSorcerer_0, aConjurer_0,	aMagician_0; 0
		dd aArchmage_0,	aChronomancer_0; 4
s_thouArtNotASpellcaster	db 'Thou art not a spell caster!',0
align 2
s_whoSpeaksToElder	db 'Who wishs to speak with the elder?',0
align 2
s_gelidiaSpellText	db '"Gelidia, the land of cold, is entered by uttering GELI and the spell to return is ECUL."',0
s_gelidiaSpellLocation	db 'To the north is Cold Peak, your passage to Gelidia is there.',0
align 2
s_lucenciaSpellText	db '"Lucencia is entered by uttering LUCE and the spell to return is ILEG."',0
s_lucenciaSpellLocation	db 'To the east is a crystal spring, your passage to Lucencia is there.',0
s_kinestiaSpellText	db '"Kinestia, the dimension of machines, is reached by casting KINE. OBRA will bring you back."',0
align 2
s_kinestiaSpellLocation	db '"To the south-west is an old mine, you may reach Kinestia from there."'
db 0
align 2
s_tenebrosiaSpellText	db '"Tenebrosia can be reached by uttering OLUK and the spell to return is ECEA."',0
s_tenebrosiaSpellLocation	db '"To the southeast is Shadow Rock, your passage to Tenebrosia is there."',0
s_tarmitiaSpellText	db '"Tarmitia is entered by uttering AECE and the spell to return is KULO."',0
s_tarmitiaSpellLocation	db '"To the south is a vale, your passage to Tarmitia is there."',0
align 2
s_timeIsRunningOut	db '"Hurry! Time is running out!"',0
s_teachOnlyChronomancer	db '"I',27h,'ll teach only a Chronomancer the special magic that you need to journey on your quest."',0
align 2
s_seekOutBrilhasti	db '"Seek out Brilhasti ap Tarj!"',0
align 2
s_questAwardXp_1	db 'The old man awards each member 600000 experience points.',0
align 2
s_questAwardXp_2	db 'With a wave of his hand, the old man re-energizes all magic users.',0
align 2
s_questBrilhasti_1	db 'The old man in the Review Board scratches his head. "Yes, you are the prophesied ones, but you have come too early. No matter."',0
s_questBrilhasti_2	db '"Beneath Skara Brae you will find one of Tarjan',27h,'s devotees. Brilhasti ap Tarj is a foul Necromancer, and his life impedes my efforts to stave off disaster."',0
align 2
s_questBrilhasti_3	db '"You may enter the Catacombs under the Mad God',27h,'s Temple by uttering his master',27h,'s name... ',27h,'Tarjan"',0
align 2
s_questBrilhasti_4	db '"Destroy Brilhasti ap Tarj, then return to me for your true quest."',0
s_questValarian_1	db '"Welcome ye children of the prophecy. Upon your shoulders falls a great weight, for you must embark on what will be your greatest adventure ever."',0
align 2
s_questValarian_2	db '"That which has laid waste to Skara Brae is an ancient evil recently released. It threatens to destroy all reality and time as it has wrought havoc on Skara Brae."',0
s_questValarian_3	db '"If you cannot stop it, it will consume the universe. If you do stop it, you will be rewarded beyond all your dreams."',0
align 2
s_questValarian_4	db '"Prepare thyselves, and hasten to the place of trees, for it is most like the first dimension you must sojourn in to blunt the evil."',0
s_questValarian_5	db '"Aboria, the home of Valarian the bold, is reached through using powerful magic that only a Chronomancer can control."',0
align 2
s_questValarian_6	db '"Bring to me Valarian',27h,'s Bow and The Arrows of Life if Valarian will not return here with you."',0
align 2
s_questValarian_7	db '"Yes, and be on the lookout for an ally, for you are not the first I have sent on this quest. Though your paths are different, they may cross, and you will do well together."',0
align 2
s_questLanatir_1	db 'The old man takes the news of Valarian',27h,'s death hard, but he summons a smile to his lips and breathes deeply.',0
align 2
s_questLanatir_2	db '"You have done well, children, and I take well the news that Hawkslayer has survived this long. Now you are bound for a place far distant."',0
s_questLanatir_3	db '"It is the dimension of magic. It is known as Gelidia and if your Chronomancer is able, I will share the spells to get you there and back again."',0
s_questLanatir_4	db '"Bring Lanatir with you, or, if you cannot convince him to come, coax from him the Wand of Power and the Sphere of Lanatir."',0
align 2
s_questAlliria_1	db 'The old man appears visibly shaken by the news of Lanatir',27h,'s death. After a long silence he stares off into space and mumbles, "Is it to be that way then?"',0
align 2
s_questAlliria_2	db 'His eyes focus upon you again, and a grim look washes over his features. "Now you are bound for Lucencia."',0
align 2
s_questAlliria_3	db '"I dare not hope Alliria lives, so I want you to recover the Crown of Truth and the Belt of Alliria. Beware, for she had a jealous consort, and he will protect her as best he can."',0
algn_49F1F:
align 2
s_questFerofist_1	db 'The old man',27h,'s look of grim determination withstands news of Alliria',27h,'s death, but the information saps some of his strength.',0
s_questFerofist_2	db '"Quickly then, my children, to distant Kinestia!"',0
s_questFerofist_3	db '"You must return here with The Hammer of Wrath and Ferofist',27h,'s Helm. I know Ferofist yet lives, but I cannot be sure of how long he will survive."',0
s_questFerofist_4	db '"Hurry, the pace quickens, and the outlook is horrible if you fail!"',0
align 2
s_questSceadu_1	db 'The old man',27h,'s eyes narrow as you tell of Ferofist',27h,'s end. "An alliance with the dark one, did he say? It is well he realized his folly in the end."',0
align 2
s_questSceadu_2	db 'He pauses a second, and you see utter weariness send a tremor through him. "Now to Tenebrosia for all of you."',0
align 2
s_questSceadu_3	db '"Remember, in the land where night is day and day is night, nothing is as you know it to be. Paradox lives there - trust no one but yourselves."',0
align 2
s_questSceadu_4	db '"From there I require the Helm of Justice and Sceadu',27h,'s Cloak."',0
align 2
s_questWerra_1	db '"No!" the old man cries out, "not Sceadu as well. The dark one is utterly mad. Still," the old man smiles, "he burns the chaff while I sow the seed."',0
s_questWerra_2	db '"Off with you to Tarmitia, the land of unceasing warfare. A myriad of ages meld together there, and your success depends upon your ability to adapt."',0
s_questWerra_3	db '"Bring me Werra',27h,'s Shield and the Strifespear."',0
align 2
s_questWerra_4	db 'His eyes lose their focus. "It is almost done, the circle is almost joined."',0
align 2
s_questTarjan_1	db '"I know," the old man gurgles, "Werra lies dead." Blood bubbles up on his lips and joins the dark stains on the rest of his clothing. "I, too, have been slain by the Mad One."',0
s_questTarjan_2	db '"Gather up the prizes you have won, the special ones, those I requested. Hawkslayer has already ventured into Malefia, the land of EVIL."',0
s_questTarjan_3	db '"I have placed the prizes in the storage building near the entrance of Skara Brae."',0
s_questTarjan_4	db '"Get yourselves hence and help him. Destroy the Mad God Tarjan before he destroys all reality!!"',0
align 2
s_questTarjan_5	db 'With those final words, the old man slumps over, and his body dissolves into a mist that a slight breeze stirs and blows away.',0
align 2
hpLevelBonusMask db 0Fh, 7, 7, 3, 3, 7,	0Fh, 0Fh, 0Fh, 7; 0 ; This array holds the mask	for bonus hit points for
		db 7, 7, 7, 0		; 10 ; each class at level-up time.
g_mageConversionCheckFunctions	dd mage_convertWizardCheck, mage_convertSorcererCheck; 0
		dd mage_convertConjurorCheck, mage_convertMagicianCheck; 2
		dd mage_convertArchmageCheck, mage_convertChronomancerCheck; 4

; Conversion table for key input to class for review_changeMageClass
g_convertListToMageClass	db 1, 2, 3, 4, 0Ah, 0Bh ; 0
s_reviewBoard	db 'Review Board',0
		db    0
questFuncs	dd review_questBrilhasti, review_questValarian; 0
		dd review_questLanatir, review_questAlliria; 2
		dd review_questFerofist,	review_questSceadu; 4
		dd review_questWerra, review_questTarjan;	6
g_questMaskList	db 0, 1, 40h, 10h, 4, 1, 40h, 10h; 0
g_questByteList	db 1, 1, 0, 0, 0, 0,	1, 1; 0
s_guild		db 'Guild',0
s_victoryMessage_1	db '"Welcome, brave heroes. You have succeeded in destroying the threat to all reality. As you know, to do this, you slipped the bonds of time, and traveled forbidden routes'
		db 'through that which has forever been. You pressed your struggle forward despite danger and death, and you accomplished that which the gods themselves were unable to do."'
		db 0Ah,0Ah
		db 'His praise washes over you like a warm ocean wave, and you feel strength infuse your body.',0
s_victoryMessage_2	db '"In doing what you have done, you have proved youself worthy of nothing less than the ultimate reward." He closes his eyes and raises his hands. '
		db '"The death of the gods tore reality asunder, but you bound it up again. The gods of old are dead, therefore I accept you as my new children. You shall be gods yourselves!"'
		db 0Ah,0Ah,0
s_victoryMessage_3	db 'His eyes open again and you look up on infinity. At once you see Skara Brae restored to its former beauty. You see beyond it and the Six cities of the Plains. '
		db 'You see the whole world and each of its cultures, and you realize all of it is now your domain.',0Ah,0Ah,0
s_victoryMessage_4	db '"And so it came to pass that eight new stars burned in the night sky. The least of these, the Companion star, was named Hawkslayer after a hero of legend. '
		db 'The other seven, together known as the Company of Heroes, are each named for one of the New Gods. Each night they can be seen is betokened a good night, and '
		db 'adventurers know these gods smile especially upon them..."',0Ah,'-- excerpt from The Gospel of the New Gods (Chap I, Verses 5-9)',0Ah,0Ah,0Ah,0
s_victoryMessage_5	db 'Your party will now alter time back to the refugee camp.',0Ah
		db 'Who knows what new challenges await you in the future!',0
aATrapIsNear	db 'A trap is near!',0
aThereAreStai_0	db 'There are stairs near...',0
aSomethingSpeci	db 'Something special is near...',0
aASpinnerIsNear	db 'A spinner is near...',0
aYourSpellsWave	db 'Your spells waver...',0
aSomethingAhead	db 'Something ahead...',0
aOdd___		db 'Odd...',0
aAwfullyQuietAh	db 'Awfully quiet ahead...',0
s_stoneBlockTrap	db 'stone block!',0
s_tripwireTrap	db 'tripwire!',0
s_pitTrap		db 'pit!',0
s_spikedPitTrap	db 'spiked pit!',0
s_poisonGasTrap	db 'poison gas cloud!',0
s_punjiStakeTrap	db 'punji stakes!',0
s_crossbowTrap	db 'crossbow bolts!',0
s_shockwaveTrap	db 'shock wave!',0
s_acidBathTrap	db 'acid bath!',0
s_mindZapTrap	db 'mind zap!',0
s_poisonSprayTrap	db 'poison spray!',0
s_poisonSpikedPitTrap	db 'poison spiked pit!',0
s_mageZapTrap	db 'mage zap!',0
s_decapitatorTrap	db 'decapitator!',0
s_timedWarstrikeTrap	db 'timed warstrike!',0
s_shockSphereTrap	db 'shock sphere!',0
s_crushingWallsTrap	db 'crushing walls!',0
s_rollingBallTrap	db 'rolling ball!',0
s_basiliskSnareTrap	db 'basilisk snare!',0
s_witherStrikeTrap	db 'wither strike!',0
s_sledgehammerTrap	db 'sledgehammer!',0
s_earthquakeTrap	db 'earthquake!',0
s_deathstrikeTrap	db 'deathstrike!',0
s_bonkersTrap	db 'bonkers!',0
s_wandererText	db 'A wandering creature offers to join your party. You can:'
		db 0Ah,0Ah
		db '@Allow it to join',0Ah
		db '@Fight it',0Ah
		db '@Leave in peace',0
s_titleText db 'Come hear the tale of Skara Brae - A god returned to have his way. Creatures of darkness, spawn of night, The Mad One',27h,'s kin destroyed the'
		db ' site. Defenders fell, their bane come true, Garth, Roscoe, Kylearan too! As doom approached, the helpless fled. It did no good, the streets'
		db ' ran red. Survivors few, they sit and mope, with but one final ray of hope: ',27h,'Cross time and space, the legends say, Heroes, at last! To steal the day! ',0
		db    0
victoryMessageList	dd s_victoryMessage_1	; 0
		dd s_victoryMessage_2	; 1
		dd s_victoryMessage_3	; 2
		dd s_victoryMessage_4	; 3
		dd s_victoryMessage_5	; 4
align 2
s_explosion	db 0Ah,'An explosion!',0
align 2
s_darkness	db 0Ah,'Darkness!',0
align 2
s_portalAbove	db 0Ah,'There is a portal above you.',0
s_portalBelow	db 0Ah,'There is a portal below.',0
s_soundOfSilence	db 0Ah,'The sound of silence...',0
align 2
detectMessages	dd aATrapIsNear	       ; 0
		dd aThereAreStai_0	; 1
		dd aSomethingSpeci	; 2
		dd aASpinnerIsNear	; 3
		dd aYourSpellsWave	; 4
		dd aSomethingAhead	; 5
		dd aOdd___		; 6
		dd aAwfullyQuietAh	; 7
s_hitTrap	db 'TRAP! You',27h,'ve hit a ',0
trapTypeString	dd s_stoneBlockTrap, s_tripwireTrap, s_pitTrap
		dd s_spikedPitTrap, s_poisonGasTrap, s_punjiStakeTrap
		dd s_crossbowTrap, s_shockwaveTrap, s_acidBathTrap
		dd s_mindZapTrap, s_poisonSprayTrap, s_poisonSpikedPitTrap
		dd s_mageZapTrap, s_decapitatorTrap,  s_timedWarstrikeTrap
		dd s_shockSphereTrap, s_crushingWallsTrap, s_rollingBallTrap
		dd s_basiliskSnareTrap, s_witherStrikeTrap, s_sledgehammerTrap
		dd s_earthquakeTrap, s_deathstrikeTrap, s_bonkersTrap
trapSpecialAttackValue	db 0, 0, 0, 0	   ; 0
		db 0, 1, 0, 0		; 4
		db 0, 0, 0, 0		; 8
		db 3, 1, 1, 0		; 12
		db 0, 0, 0, 0		; 16
		db 0, 0, 0, 0		; 20
		db 6, 4, 0, 0		; 24
		db 0, 7, 4, 0		; 28
byte_4B258	db 20h dup(0)

; Trap indices by (dungeon level & 7). 0-3 = dungeon level 1, 4-7 = 2, etc
;
g_trapIndexByLevel	db 0, 1, 2, 0	   ; 0
			db 3, 4, 5, 0		; 4
			db 6, 7, 8, 0		; 8
			db 9, 10, 11, 0		; 12
			db 12, 13, 14, 0	; 16
			db 15, 16, 17, 0	; 20
			db 18, 19, 20, 0	; 24
			db 21, 22, 23, 0	; 28
trapSaveList	trapSave_t < 0Fh, 0Fh	>
		trapSave_t < 0Eh, 0	>
		trapSave_t < 13h, 13h	>
		trapSave_t < 13h, 0	>
		trapSave_t < 15h, 14h	>
		trapSave_t < 14h, 0	>
		trapSave_t < 18h, 18h	>
		trapSave_t < 17h, 0	>
		trapSave_t < 26h, 26h	>
		trapSave_t < 28h, 0	>
		trapSave_t < 27h, 28h	>
		trapSave_t < 28h, 0	>
		trapSave_t < 2Ah, 29h	>
		trapSave_t < 2Ah, 0	>
		trapSave_t < 2Bh, 2Eh	>
		trapSave_t < 2Bh, 0	>
detectByteStartList	db 0, 2, 4, 0		; This array has the starting index into the detectByte
						; array for the detect spell type
detectByte	db 0, 0FFh, 0, 0FFh	   ; 0 ; This array holds the flag byte	to detect certain
		db 0, 0, 0, 1		; 4 ; types of squares
		db 1, 1, 1, 1		; 8
		db 1, 0FFh		; 12
detectMask	db 10h, 0, 1, 0	   ; 0 ; This array holds the bitmasks to detect certain
		db 10h,	1, 4, 1		; 4 ; types of squares
		db 2, 4, 8, 10h		; 8
		db 20h,	0		; 12
detectMsgIndex	db 0, 0, 1, 0	       ; 0
		db 0, 1, 2, 3		; 4
		db 4, 5, 6, 7		; 8
		db 5, 0			; 12
specialSquareFunctionList	dd dunsq_battleCheck,	dunsq_doTrap, dunsq_doDarkness;	0
		dd dunsq_doSpinner, dunsq_antiMagic, dunsq_drainHp; 3
		dd dunsq_somethingOdd, dunsq_doSilence,	dunsq_regenSppt; 6
		dd dunsq_drainSppt, dunsq_monHostile, dunsq_doStuck; 9
		dd dunsq_regenHP, dunsq_explosion, dunsq_portalAbove; 12
		dd dunsq_portalBelow
specialSquareByteIndexList	db 0, 0, 0		   ; 0
		db 1, 1, 1		; 3
		db 1, 1, 1		; 6
		db 1, 1, 2		; 9
		db 2, 2, 0		; 12
		db 0			; 15
specialSquareMaskList	db 80h, 10h, 8	   ; 0
		db 1, 2, 4		; 3
		db 8, 10h, 20h		; 6
		db 40h,	80h, 80h	; 9
		db 40h,	10h, 40h	; 12
		db 20h			; 15
g_wandererFunctionTable	dd wanderer_join
		dd wanderer_fight
		dd wanderer_leave
aDragonDragonWh	db 'Dragon, dragon,',0Ah
		db 'Why do you lair?',0Ah
		db 'Unfurl your wings, Take to the air!',0Ah
		db 'Soar high above, Far away fly,',0Ah
		db 'Or is that where, You wish to die?',0
aHawkslayerHawk	db 'Hawkslayer, Hawkslayer,',0Ah
		db 'Why do you ask? Killing me is a difficult task. My claws are sharp, my fangs sharper yet, And my breath flames, let us not forget.',0
aDragonDragonTh	db 'Dragon, dragon,',0Ah
		db 'Thou art quite strong. Your scales are bright and talons are long, But a duty I have and it is clear: Whatever it takes, I will drive you from here.',0
aHawkslayerHa_0	db 'Hawkslayer, Hawkslayer,',0Ah
		db 'Such a brief life. Have you no wish to again see your wife? Imagine her tears and grief and despair, Walk away from this fight, you have not a prayer.',0
aDragonDragonHo	db 'Dragon, dragon,',0Ah
		db 'How wise thou art.',0Ah
		db 'A massive beast with such a kind heart.',0Ah
		db 'I do wish to kiss my wife and my heir,',0Ah
		db '"Pray, fly to the mountains and await me there.',0
aHawkslayerHa_1	db 'Hawkslayer, Hawkslayer,',0Ah
		db 'I thought you were brave. Here I await you, deep in this cave. Come, little man, and I',27h,'ll eat your brain, Then ravage Lucencia again and again.',0
aDragonDragonGr	db 'Dragon, dragon,',0Ah
		db 'Great is your heart. Massive your body, but you are not smart. The rumble you hear and the dust in the air? I',27h,'ve closed the cave off and trapped you in there.',0
aHawkslayerHa_2	db 'Hawkslayer, Hawkslayer,',0Ah
		db 'Others will come.',0Ah
		db 'I will wait but I will not succumb.',0Ah
		db 'Hero you are, and incredibly sly,',0Ah
		db 'But the future I know and a hero you',27h,'ll die...',0
aHeWasBornWithT	db 'He was born with the red, red rose, Sign of his blood, was the link to the past.',0
aInBattleHeWonT	db 'In battle, he won the blue, blue rose, Blossom of his valor, his weapons were cast.',0
aSheWasForHimTh	db 'She was for him the yellow, yellow rose, Her spirit divine, his love would always last.',0
aHisPledgeHeMad	db 'His pledge he made o',27h,'er the white, white rose, And she accepted it as sooth, and remained his steadfast.',0
aSoHeMadeForHer	db 'So he made for her the rainbow rose, Like Alliria',27h,'s beauty, a blossom unsurpassed.',0
aMadGodBadGodTh	db 'Mad god, bad god,',0Ah
		db 'Thrust from the sky,',0Ah
		db 'Foolish god, ghoulish god.',0Ah
		db 'We can',27h,'t hear you cry.',0
aRudeGodCrudeGo	db 'Rude god, crude god,',0Ah
		db 'Why must you terrify?',0Ah
		db 'Error god, terror god,',0Ah
		db 'Do not your future scry.',0
aCleverGodNever	db 'Clever god, never god,',0Ah
		db 'Your time is nigh.',0Ah
		db 'Dire god, liar god,',0Ah
		db 'Why won',27h,'t you just die?',0
aInTheLandOfNoT	db 'In the land of no time,',0Ah
		db 'The Clock within burns like a flame,',0
aLockingEachInH	db 'Locking each in his own crime:',0Ah
		db 'One can only leave when he came.',0
s_bardHallGreeting	db 'Welcome and be happy o',27h,' weary travelers! Step to the stage and listen to my tales.',0Ah,0Ah
		db 'You can:',0Ah,0Ah
		db 'Listen to the bard',0Ah
		db 'Exit the hall',0
align 2
s_songTitleList	db 'These are the songs I know...',0Ah,0Ah
		db '@Dragon Song',0Ah
		db '@Flower Ballad',0Ah
		db '@Kiel',27h,'s Overture',0Ah
		db '@Gale of Gods',0Ah
		db '@Evil',27h,'s Bane',0Ah
		db '@Minstrel Shield',0
off_4BC98	dd aDragonDragonWh
		dd aHawkslayerHawk
		dd aDragonDragonTh
		dd aHawkslayerHa_0
		dd aDragonDragonHo
		dd aHawkslayerHa_1
		dd aDragonDragonGr
		dd aHawkslayerHa_2
off_4BCB8	dd aHeWasBornWithT
		dd aInBattleHeWonT
		dd aSheWasForHimTh
		dd aHisPledgeHeMad
		dd aSoHeMadeForHer
off_4BCCC	dd aMadGodBadGodTh
		dd aRudeGodCrudeGo
		dd aCleverGodNever
off_4BCD8	dd aInTheLandOfNoT
		dd aLockingEachInH
s_bardSmiles	db 'The bard smiles and says, "That one will cost thee for your bards will learn the magic of my song."',0
s_itWillCostYou	db '"It will cost you ',0
align 2
s_bardPlaysSong	db 'The bard plays the song and you memorize the lines.',0
s_bardsHall	db 'Bard',27h,'s Hall',0
bardSongLineCount	dw 8, 5, 0, 3, 2, 0    ; 0
bardSongLyrics	dd off_4BC98	       ; 0
		dd off_4BCB8		; 1
		dd offset word_42670	; 2
		dd off_4BCCC		; 3
		dd off_4BCD8		; 4
align 8
bardSongPrice	dd 30000, 60000       ;	0
byte_4BDF0	db 1, 2     ; 0
s_noRoomForSummon db 'but no room for a summoning!',0Ah,0Ah,0
		db    0
s_andA		db 'and a ',0
		db    0
s_appears	db ' appears!',0Ah,0Ah,0
include(`data/monsters/summonData.asm')
s_nl	db  0Ah
		db    0
s_displayQuestion	db 'What type of display do you wish to use?',0
s_videoOption1	db 0Ah,0Ah
		db '1) Composite or TV monitor.',0
s_videoOption2	db 0Ah,'2) RGB monitor.',0
s_videoOption3	db 0Ah,'3) EGA monitor.',0
s_videoOption4	db 0Ah,'4) Tandy computer with RGB monitor.',0
s_videoQuestion	db 0Ah,0Ah
		db 'Please enter the appropriate number for your system type:',0
s_soundQuestion db 'What type of sound output device do you wish to use?',0
s_soundOption1		db 0Ah,0Ah,'1) MT32.',0
s_soundOption2	db 0Ah,'2) Ad Lib.',0
s_soundOption3 db 0Ah,'3) Internal IBM speaker.',0
s_soundOption4	db 0Ah,'4) Tandy.',0
s_soundOption5		db 0Ah,'5) PS/1',0
s_soundPrompt db 0Ah,0Ah,'Please enter the appropriate number for your system type:',0
s_diskToTransferFrom	db 'Disk to transfer characters from?',0
s_whoShallTransfer	db 'Who shall transfer?',0
s_characterAlreadyExists	db 'This character already exists',0
s_noCharactersFoundOn	db 'No characters found on',0
		db    0
s_noPartiesFoundOn	db 'No parties found on',0
s_transferVersionPrompt	db 'Transfer characters from:',0Ah
		db '1) Bards I',0Ah
		db '2) Bards II',0Ah
		db '3) Bards III',0Ah
		db 'E) Exit',0
bi_inventoryMap	db 0, 1, 2, 3, 4, 5, 6,	7, 6, 9; 0
		db 0Ah,	0Bh, 0Ch, 0Dh, 0Eh, 0Fh, 10h, 11h, 12h,	13h; 10
		db 14h,	14h, 14h, 17h, 18h, 19h, 1Ah, 0, 1Ch, 1Dh; 20
		db 1Eh,	1Fh, 20h, 21h, 22h, 23h, 0, 25h, 0, 0; 30
		db 28h,	0, 29h,	2Ah, 0,	2Ch, 2Dh, 2Eh, 2Fh, 30h; 40
		db 31h,	0, 32h,	33h, 0,	0, 34h,	0, 36h,	0; 50
		db 37h,	1Bh, 39h, 0, 3Bh, 3Ch, 0, 3Eh, 3Fh, 40h; 60
		db 41h,	42h, 0,	45h, 0,	0, 46h,	47h, 59h, 49h; 70
		db 0, 4Bh, 0, 0, 4Eh, 0, 4Fh, 51h, 0, 53h; 80
		db 54h,	55h, 0,	57h, 0,	5Ah, 5Bh, 0, 0,	5Eh; 90
		db 5Fh,	58h, 0,	0, 0, 0, 43h, 0, 62h, 0; 100
		db 64h,	64h, 0,	59h, 6Ch, 0, 0,	0, 0, 0; 110
		db 0, 0, 0, 0, 0, 0, 0,	0; 120
bii_inventoryMap db 0, 1, 2, 3,	4, 5, 6, 7, 8, 9; 0
		db 10, 11, 12, 13, 14, 15, 16, 17, 18, 19; 10
		db 20, 21, 22, 23, 24, 25, 26, 27, 28, 29; 20
		db 30, 31, 32, 33, 34, 35, 36, 37, 38, 39; 30
		db 40, 41, 42, 43, 44, 45, 46, 47, 48, 49; 40
		db 50, 51, 52, 53, 54, 55, 56, 57, 58, 59; 50
		db 60, 61, 62, 63, 64, 65, 66, 67, 68, 69; 60
		db 70, 71, 72, 73, 74, 75, 76, 77, 78, 79; 70
		db 80, 81, 82, 83, 84, 85, 86, 87, 88, 89; 80
		db 90, 91, 92, 93, 94, 95, 96, 97, 98, 99; 90
		db 100,	101, 102, 103, 104, 105, 106, 107, 108,	109; 100
		db 110,	111, 0,	0, 0, 0, 0, 0, 0, 0; 110
		db 0, 0, 0, 0, 0, 0, 0,	0; 120
bii_classMap	db 0, 7, 5, 6, 8, 9, 3, 4,	2, 1, 0Ah; 0
		db 0Dh,	0Eh		; 11
s_tpw		db '*.tpw',0
s_tw		db '*.tw',0
oldCharFilters	dd s_tpw, s_tw	       ; 0
aAcorns		db 'Acorns',0
aArrowsOfLife	db 'Arrows of Life',0
aMalefia	db 'Malefia',0
aValarian	db 'Valarian',0
aLanatir	db 'Lanatir',0
aFerofist	db 'Ferofist',0
aSceadu		db 'Sceadu',0
aWerra		db 'Werra',0
aTarjan		db 'Tarjan',0
aSkaraBrae	db 'Skara Brae',0
s_unterbrae	db 'UnterBrae',0
aArboria	db 'Arboria',0
aGelidia	db 'Gelidia',0
aLucencia	db 'Lucencia',0
aKinestia	db 'Kinestia',0
aTenebrosia	db 'Tenebrosia',0
aTarmitia	db 'Tarmitia',0
aCieraBrannia	db 'Ciera Brannia',0
aCelariaBree	db 'Celaria Bree',0
aBlackScar	db 'Black Scar',0
aDarkCopse	db 'Dark Copse',0
aNowhere	db 'Nowhere',0
aFesteringPit	db 'Festering Pit',0
aSacredGrove	db 'Sacred Grove',0
aIceKeep	db 'Ice Keep',0
aShadowCanyon	db 'Shadow Canyon',0
aTarQuarry	db 'Tar Quarry',0
aColdPeak	db 'Cold Peak',0
aCrystalSpring	db 'Crystal Spring',0
aOldDwarfMine	db 'Old Dwarf Mine',0
aShadowRock	db 'Shadow Rock',0
aSulphurSprings	db 'Sulphur Springs',0
aWarriorsVale	db 'Warriors Vale',0
aBrilhasti	db 'Brilhasti',0
s_urmech		db 'Urmech',0
aTslotha	db 'Tslotha',0
aCyanis		db 'Cyanis',0
aTheOldMan	db 'The Old Man',0
aHawkslayer	db 'Hawkslayer',0
aVioletMountain	db 'Violet Mountains',0
aCrystalPalace	db 'Crystal Palace',0
aCatacombs	db 'Catacombs',0
aTunnels	db 'Tunnels',0
aWorkshop	db 'Workshop',0
aWizardSGuild	db 'Wizard',27h,'s Guild',0
align 2
s_copyProtectIntro	db 'To traverse time and space, you must first recite the alignment value of ',0
s_comms_capitalAnd		db ', and ',0
align 2
s_commaSpace	db ', ',0
align 2
s_period		db '.',0
aYouHaveFailedT	db 'You have failed to recite the proper alignment pattern!',0
g_cpLocationFour	dd s_itemArefolia, aAcorns ; 0
		dd aArrowsOfLife, s_itemCrystalKey; 2
		dd s_itemCrownOfTruth, s_itemStrifespear; 4
		dd s_itemRainbowRose, s_itemCrystalLens; 6
		dd s_itemSmokeyLens, s_itemBlackLens;	8
		dd s_itemShadowDoor, s_itemShadowLock; 10
		dd s_itemWineskin,	s_itemNightspear; 12
		dd s_itemHammerOfWrath, s_itemWandOfPower; 14
g_cpLocationOne	dd aMalefia, aValarian  ; 0
		dd aLanatir, s_alliria	; 2
		dd aFerofist, aSceadu	; 4
		dd aWerra, aTarjan	; 6
		dd aSkaraBrae, s_unterbrae; 8
		dd aArboria, aGelidia	; 10
		dd aLucencia, aKinestia	; 12
		dd aTenebrosia,	aTarmitia; 14
g_cpLocationTwo	dd aCieraBrannia, aCelariaBree; 0
		dd aBlackScar, aDarkCopse; 2
		dd aNowhere, aFesteringPit; 4
		dd aSacredGrove, aIceKeep; 6
		dd aShadowCanyon, aTarQuarry; 8
		dd aColdPeak, aCrystalSpring; 10
		dd aOldDwarfMine, aShadowRock; 12
		dd aSulphurSprings, aWarriorsVale; 14
g_cpLocationThree	dd aBrilhasti, s_urmech  ; 0
		dd aTslotha, aCyanis	; 2
		dd aTheOldMan, aHawkslayer; 4
		dd s_scrapwood, s_bardsHall; 6
		dd s_staggerInn, s_hicHaven; 8
		dd aVioletMountain, aCrystalPalace; 10
		dd aCatacombs, aTunnels	; 12
		dd aWorkshop, aWizardSGuild; 14
byte_4CA18	db 0, 4		   ; 0
		db 18,	23		; 2
		db 37,	49		; 4
		db 51,	70		; 6
		db 84,	98		; 8
		db 102,	112		; 10
		db 131,	133		; 12
		db 145,	151		; 14
byte_4CA28	db 0Dh			; 0
		db 7			; 1
		db    0			; 2
		db    2			; 3
		db    6			; 4
		db    9			; 5
		db  0Fh			; 6
		db    3			; 7
		db    5			; 8
		db  0Ch			; 9
		db  0Ah			; 10
		db    1			; 11
		db  0Eh			; 12
		db    8			; 13
		db    4			; 14
		db  0Bh			; 15
byte_4CA38	db 1
		db  0Fh
		db  7Fh
		db 0FFh
		db    0
		db    0
		db    0

include(`lib/d3cmp/data.asm')

randomSeed	dw 0
g_locationNumber dw	0
dunLevelIndex	dw 0
g_dunLevelNum	dw 0
g_sqNorth	dw 0
g_sqEast		dw 0
g_direction	dw 0
inDungeonMaybe	dw 0
g_mapRval dw 0
g_sameSquareFlag	dw 0
g_curSpellNumber	dw 0
g_gameProgressFlags	db 7 dup(0)     ; 0
byte_4EE71	db 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
g_vm_registers	dw 20h dup(0)	    ; 0
g_currentHour	db 0
lightDistance	db 0
g_songDuration	db 0
lightDuration		db 0
compassDuration		db 0
detectDuration		db 0
shieldDuration		db 0
levitationDuration	db 0
g_detectType		db 0
g_levelNumber	db 0
g_levelFlags	db 0
g_dunWidth	db 0
g_dunHeight	db 0
g_monsterGroupCount	db 0
g_partyAttackFlag	db 0
shieldAcBonus	db 0
byte_4EECC	db 0
minimapWallBitmasks db	0FFh,	0,	0,	0,	0,	0,	0,	0	; 0
		; 11111111
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		db	1,	1,	1,	1,	1,	1,	1,	1	; 1
		; 00000001
		; 00000001
		; 00000001
		; 00000001
		; 00000001
		; 00000001
		; 00000001
		; 00000001
		db	0,	0,	0,	0,	0,	0,	0,	0FFh	; 2
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 11111111
		db	80h,	80h,	80h,	80h,	80h,	80h,	80h,	80h	; 3
		; 10000000
		; 10000000
		; 10000000
		; 10000000
		; 10000000
		; 10000000
		; 10000000
		; 10000000
		db	6Bh,	8,	0,	0,	0,	0,	0,	0	; 4
		; 01101011
		; 00001000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		db	1,	1,	0,	6,	6,	0,	1,	1	; 5
		; 00000001
		; 00000001
		; 00000000
		; 00000110
		; 00000110
		; 00000000
		; 00000001
		; 00000001
		db	0,	0,	0,	0,	0,	0,	8,	6Bh	; 6
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00001000
		; 01101011
		db	80h,	80h,	0, 	30h,	30h,	0,	80h,	80h	; 7
		; 10000000
		; 10000000
		; 00000000
		; 00110000
		; 00110000
		; 00000000
		; 10000000
		; 10000000
		db	55h,	0,	0,	0,	0,	0,	0,	0	; 8
		; 01010101
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		db	1,	1,	0,	1,	1,	0,	1,	1	; 9
		; 00000001
		; 00000001
		; 00000000
		; 00000001
		; 00000001
		; 00000000
		; 00000001
		; 00000001
		db	0,	0,	0,	0,	0,	0,	0,	55h	; 10
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 00000000
		; 01010101
		db	80h,	80h,	0,	80h,	80h,	0,	80h,	80h	; 11
		; 10000000
		; 10000000
		; 00000000
		; 10000000
		; 10000000
		; 00000000
		; 10000000
		; 10000000
		db	0,	0,	8,	1Ch,	1Ch,	8,	0,	0	; 12
		; 00000000
		; 00000000
		; 00001000
		; 00011100
		; 00011100
		; 00001000
		; 00000000
		; 00000000
		db 0, 66h, 3Ch, 18h, 18h, 3Ch, 66h, 0; 13 - minimap_X
		; 00000000
		; 01100110
		; 00111100
		; 00011000
		; 00011000
		; 00111100
		; 01100110
		; 00000000
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 14
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		db 0, 0
s_faster		db 0Ah,'<Faster...>',0Ah,0
s_slower		db 0Ah,'<Slower...>',0Ah,0
txtDelayTable	db 1, 4, 7, 0Bh, 0Eh, 11h, 14h, 17h, 1Ah, 1Dh
txtDelayIndex	db 7
_clockTicks	dw 0
word_4EF49	dw 0
byte_4EF4B	db 0
byte_4EF4C	db 0
byte_4EF4D	db 0
align 4
byte_4EF50	db 0
byte_4EF51	db 0
byte_4EF52	db 0
byte_4EF53	db 0
spell_mouseClicked	db 0
mouse_moved	db 0
mouse_x		dw 0DCh
mouse_y		dw 0
word_4EF59	dw 0
word_4EF5B	dw 0
byte_4EF5D	db 0
byte_4EF5E	db 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Ah
		db    0
		db    0
		db    0
		db    0
		db    0
word_4EF6F	dw 3F8h
		db    4
		db    0
		db    0
		db 0B8h	; ¸
		db    1
		db    0
		db    0
		db    0
byte_4EF79	db 1
byte_4EF7A	db 0
align 2
word_4EF7C	dw 0
word_4EF7E	dw 0
off_4EF80	dw offset sub_2843B
word_4EF82	dw 0
		dw seg dseg
		db 4Ch dup(0)
off_4EFD2	dw offset word_4EF82
aC_file_info	db ';C_FILE_INFO',0
dword_4EFE1	dd 0
		db 8 dup(0)
word_4EFED	dw 0
		db 4 dup(0)
word_4EFF3	dw 0
word_4EFF5	dw 0
		db 0
byte_4EFF8	db 0
align 2
word_4EFFA	dw 14h
byte_4EFFC	db 3 dup(81h), 2 dup(1), 0Fh dup(0)
word_4F010	dw 0
word_4F012	dw 0
word_4F014	dw 0
word_4F016	dw 0
word_4F018	dw 0
off_4F01A	dd unk_4F01E
unk_4F01E	db  43h	; C
		db    0
		db    0
		db    0
byte_4F022	db 0
byte_4F023	db 0
dword_4F024	dd 0
unk_4F028	db	0
		db    0
word_4F02A	dw 0
dword_4F02C	dd 0FFFFFFFFh
word_4F030	dw (offset dseg_end+102h)
dword_4F032	dd 0
byte_4F036	db 0, 16h, 2 dup(2), 18h
		db 0Dh, 9, 3 dup(0Ch), 7; 5
		db 8, 2 dup(16h), 0FFh, 12h; 11
		db 0Dh, 12h, 2, 0FFh    ; 16
word_4F04A	dw 0
byte_4F04C	db 200h dup(0)
byte_4F24C	db 200h dup(0)
byte_4F44C	db 200h dup(0)
off_4F64C	dw offset byte_4F04C
		dw seg dseg
		db    0
		db    0
		dd byte_4F04C
		db    1
		db    0
byte_4F658	db 0Ah dup(0), 2, 1
byte_4F664	db 0Ah dup(0), 2 dup(2), 0Ah dup(0), 84h, 3, 0Ah dup(0), 2, 4
		db 0A8h dup(0)
byte_4F730	db 0Ch dup(0)
byte_4F73C	db 1, 2 dup(0), 2, 74h dup(0)
word_4F7B4	dw offset byte_4F730
seg_4F7B6	dw seg dseg
word_4F7B8	dw 0
aNull		db '(null)',0
aNull_0		db '(null)',0
asc_4F7C8	db '+- #',0
align 2
word_4F7CE	dw 0
word_4F7D0	dw 0
align 4
word_4F7D4	dw 0
align 4
word_4F7D8	dw 0
word_4F7DA	dw 0
word_4F7DC	dw 0
word_4F7DE	dw 2000h
word_4F7E0	dw 0
byte_4F7E2	db 0
align 2
off_4F7E4	dd sub_284E6
off_4F7E8	dd sub_284E6
off_4F7EC	dd sub_284E6
off_4F7F0	dd sub_284E6
off_4F7F4	dd sub_284E6
		db    0
		db    0
		db    0
		db    0
		db    1
		db    1
		db    0
sscanf_charFlags	db 32, 32, 32, 32, 32, 32, 32, 32
		db 32, 40, 40, 40, 40, 40, 32, 32
		db 32, 32, 32, 32, 32, 32, 32, 32
		db 32, 32, 32, 32, 32, 32, 32, 32
		db 72, 16, 16, 16, 16, 16, 16, 16
		db 16, 16, 16, 16, 16, 16, 16, 16
		db 132,	132, 132, 132, 132, 132, 132, 132
		db 132,	132, 16, 16, 16, 16, 16, 16
		db 16, 129, 129, 129, 129, 129,	129, 1
		db 1, 1, 1, 1, 1, 1, 1,	1
		db 1, 1, 1, 1, 1, 1, 1,	1
		db 1, 1, 1, 16,	16, 16,	16, 16
		db 16, 130, 130, 130, 130, 130,	130, 2
		db 2, 2, 2, 2, 2, 2, 2,	2
		db 2, 2, 2, 2, 2, 2, 2,	2
		db 2, 2, 2, 16,	16, 16,	16, 32
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0
word_4F900	dw 0FFFFh
align 4
unk_4F904	db	0
db    0
word_4F906	dw 0
dword_4F908	dd 0
dword_4F90C	dd 0
off_4F910	dd sub_28846
seg027_41	dw seg seg027
dseg_x		dw seg dseg
seg027_x	dw seg	seg027
seg022_x	dw seg	seg022
seg023_x	dw seg seg023
aNmsg		db '<<NMSG>>',0
align 2
aR6000StackOver	db 'R6000',0Dh,0Ah
		db '- stack overflow',0Dh,0Ah,0
		db    3
		db    0
		db  52h	; R
		db  36h	; 6
		db  30h	; 0
		db  30h	; 0
		db  33h	; 3
		db  0Dh
		db  0Ah
		db  2Dh	; -
		db  20h
		db  69h	; i
		db  6Eh	; n
		db  74h	; t
		db  65h	; e
		db  67h	; g
		db  65h	; e
		db  72h	; r
		db  20h
		db  64h	; d
		db  69h	; i
		db  76h	; v
		db  69h	; i
		db  64h	; d
		db  65h	; e
		db  20h
		db  62h	; b
		db  79h	; y
		db  20h
		db  30h	; 0
		db  0Dh
		db  0Ah
		db    0
		db    9
		db    0
		db  52h	; R
		db  36h	; 6
		db  30h	; 0
		db  30h	; 0
		db  39h	; 9
		db  0Dh
		db  0Ah
		db  2Dh	; -
		db  20h
		db  6Eh	; n
		db  6Fh	; o
		db  74h	; t
		db  20h
		db  65h	; e
		db  6Eh	; n
		db  6Fh	; o
		db  75h	; u
		db  67h	; g
		db  68h	; h
		db  20h
		db  73h	; s
		db  70h	; p
		db  61h	; a
		db  63h	; c
		db  65h	; e
		db  20h
		db  66h	; f
		db  6Fh	; o
		db  72h	; r
		db  20h
		db  65h	; e
		db  6Eh	; n
		db  76h	; v
		db  69h	; i
		db  72h	; r
		db  6Fh	; o
		db  6Eh	; n
		db  6Dh	; m
		db  65h	; e
		db  6Eh	; n
		db  74h	; t
		db  0Dh
		db  0Ah
		db    0
		db 0FCh	; ü
		db    0
		db  0Dh
		db  0Ah
		db    0
		db 0FFh
		db    0
		db  72h	; r
		db  75h	; u
		db  6Eh	; n
		db  2Dh	; -
		db  74h	; t
		db  69h	; i
		db  6Dh	; m
		db  65h	; e
		db  20h
		db  65h	; e
		db  72h	; r
		db  72h	; r
		db  6Fh	; o
		db  72h	; r
		db  20h
		db    0
		db    2
		db    0
		db  52h	; R
		db  36h	; 6
		db  30h	; 0
		db  30h	; 0
		db  32h	; 2
		db  0Dh
		db  0Ah
		db  2Dh	; -
		db  20h
		db  66h	; f
		db  6Ch	; l
		db  6Fh	; o
		db  61h	; a
		db  74h	; t
		db  69h	; i
		db  6Eh	; n
		db  67h	; g
		db  20h
		db  70h	; p
		db  6Fh	; o
		db  69h	; i
		db  6Eh	; n
		db  74h	; t
		db  20h
		db  6Eh	; n
		db  6Fh	; o
		db  74h	; t
		db  20h
		db  6Ch	; l
		db  6Fh	; o
		db  61h	; a
		db  64h	; d
		db  65h	; e
		db  64h	; d
		db  0Dh
		db  0Ah
		db    0
		db    1
		db    0
		db  52h	; R
		db  36h	; 6
		db  30h	; 0
		db  30h	; 0
		db  31h	; 1
		db  0Dh
		db  0Ah
		db  2Dh	; -
		db  20h
		db  6Eh	; n
		db  75h	; u
		db  6Ch	; l
		db  6Ch	; l
		db  20h
		db  70h	; p
		db  6Fh	; o
		db  69h	; i
		db  6Eh	; n
		db  74h	; t
		db  65h	; e
		db  72h	; r
		db  20h
		db  61h	; a
		db  73h	; s
		db  73h	; s
		db  69h	; i
		db  67h	; g
		db  6Eh	; n
		db  6Dh	; m
		db  65h	; e
		db  6Eh	; n
		db  74h	; t
		db  0Dh
		db  0Ah
		db    0
		db 0FFh
		db 0FFh
		db 0FFh
		db    0
g_tavernSayingBase	dw 0
tav_drunkLevel	db 8 dup(0)	       ; 0
curStrByte	db ?
align 2
dataBufOff	dw ?
dataBufSeg	dw ?
bitsLeft	dw ?
_str_capFlag	dw	?
align 4
word_4FD6C	dw ?
sscanf_structP	dd ?
word_4FD72	dw ?
word_4FD74	dw ?
sscanf_argSizeFlag	dw ?
sscanf_charListFlag	dw ?
word_4FD7A	dw ?
dword_4FD7C	dd ?
sscanf_bufp	dd ?
word_4FD84	dw ?
sscanf_buf	db 100h dup(?)
sscanf_minWidth dw ?
sscanf_noAssign dw ?
word_4FE8A	dw ?
word_4FE8C	dw ?
_sscanf_floatBuf	db 42h dup(?)
word_4FED0	dw ?
word_4FED2	dw ?
word_4FED4	dw ?
dword_4FED6	dd ?
word_4FEDA	dw ?
word_4FEDC	dw ?
word_4FEDE	dw ?
word_4FEE0	dw ?
byte_4FEE2	db 0Ch dup(?)
word_4FEEE	dw ?
dword_4FEF0	dd ?
word_4FEF4	dw ?
word_4FEF6	dw ?
word_4FEF8	dw ?
word_4FEFA	dw ?
word_4FEFC	dw ?
word_4FEFE	dw ?
word_4FF00	dw ?
word_4FF02	dw ?
word_4FF04	dw ?
word_4FF06	dw ?
byte_4FF08	db 15Eh dup(?)
word_50066	dw ?
word_50068	dw ?
byte_5006A	db 4 dup(?)
dseg_end	db ?
		db ?
align 8
