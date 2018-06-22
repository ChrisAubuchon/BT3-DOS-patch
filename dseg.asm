word_42670	dw 0
word_42672	dw 0
byte_42674	db 0
byte_42675	db 0
word_42676	dw 0
aMsRunTimeLibraryCopy db 'MS Run-Time Library - Copyright (c) 1988, Microsoft Corp'
		db  11h
byte_426B1	db 0
aComp		db 'comp',0
aRgb		db	'rgb',0
aEga		db	'ega',0
aTdy		db	'tdy',0
s_thiefCfg	db 'thief.cfg',0
s_firstTitle		db 'tit0',0
s_titleScreen		db 'title',0
s_musicAll	db 'music.all',0
s_stuckEllipsis	db 'Stuck....',0
graphicsDrivers	dd aComp, aRgb,	aEga, aTdy; 0
s_facing		db 'facing ',0
byte_42716	db 0, 2, 20h, 22h
aEarlyMorning_	db 'early morning.',0
aMidMorning_	db	'mid morning.',0
aNoon_		db 'noon.',0
aAfternoon_	db 'afternoon.',0
aDusk_		db 'dusk.',0
aEvening_	db 'evening.',0
aMidnight_	db 'midnight.',0
aAfterMidnight_	db 'after midnight.',0
aRefugeeCampOfS	db ' refugee camp of Skara Brae.',0
aCityGates_	db ' city gates.',0
aEntranceToTheC	db ' entrance to the city.',0
aGreatIceKeep_	db ' great ice keep.',0
aEntranceOfTheF	db ' entrance of the forest.',0
s_pausing	db 'pausing',0
		db    0
s_whoToDrop db 'Who will you drop?',0
		db    0
s_cantDropCharacter db 'You can',27h,'t drop a party member.',0
		db    0
s_youreIn db 'You',27h,'re in ',0
		db    0
s_spAndsp		db ' and ',0
		db    0
s_itsNow		db 0Ah,0Ah, 'It',27h,'s now ',0
timeOfDay	dd aEarlyMorning_, aMidMorning_, aNoon_, aAfternoon_,	aDusk_,	aEvening_, aMidnight_, aAfterMidnight_
s_ofAtThe	db ' /of\at\ the',0
		db    0
locationString	dd aRefugeeCampOfS, aCityGates_,	aEntranceToTheC, aGreatIceKeep_, aEntranceOfTheF; 0
byte_428A6	db 0Ch, 0Ah,	7, 0Fh,	6, 6, 7, 9; 0
		db 0Ah,	0Fh		; 8
byte_428B0	db 0Fh, 0, 6, 8, 0Ah, 9, 0, 8; 0
		db 5, 1			; 8
byte_428BA	db 0, 1, 2, 1, 3, 2,	1, 2; 0
		db 4, 1			; 8
byte_428C4	db 7, 7, 7, 7, 0, 0,	0, 1; 0
		db 1, 1, 1, 2, 2, 2, 3,	3; 8
		db 4, 4, 4, 5, 5, 5, 6,	6; 16
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
aWarrior	db 'Warrior',0
aWizard		db 'Wizard',0
aSorcerer	db 'Sorcerer',0
aConjurer	db 'Conjurer',0
aMagician	db 'Magician',0
aRogue		db 'Rogue',0
aBard		db 'Bard',0
aPaladin	db 'Paladin',0
aHunter		db 'Hunter',0
aMonk		db 'Monk',0
aArchmage	db 'Archmage',0
aChronomancer	db 'Chronomancer',0
aGeomancer	db 'Geomancer',0
aMonster	db 'Monster',0
aIllusion	db 'Illusion',0
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
; Class bigpic index. The pictures are in male, female pairs
g_classPictureNumber	db 33, 48
			db 54, 79
			db 54, 79
			db 54, 79
			db 54, 79
			db 33, 48
			db 33, 48
			db 33, 48
			db 33, 48
			db 33, 48
			db 54, 79
baseAttributes	startingAttrBase <10, 6,	8, 8, 5, 10, 6, 8, 8,	5>
		startingAttrBase <8, 9,	9, 6, 6, 8, 9, 9, 6, 6>
		startingAttrBase <12, 6, 7, 10,	3, 12, 6, 7, 10, 3>
		startingAttrBase <4, 6,	12, 5, 10, 4, 6, 12, 5, 10>
		startingAttrBase <9, 8,	9, 7, 6, 9, 8, 9, 7, 6>
		startingAttrBase <11, 3, 8, 11,	4, 11, 3, 8, 11, 4>
		startingAttrBase <9, 10, 7, 3, 4, 9, 10, 7, 3, 4>
startingClasses	startingClass_t	<1, 0, 0, 1, 1,	1, 1, 1, 1, 1>	; 0
		startingClass_t	<1, 0, 0, 1, 1,	1, 1, 1, 0, 1>	; 1
		startingClass_t	<1, 0, 0, 0, 0,	1, 1, 1, 1, 1>	; 2
		startingClass_t	2 dup(<1, 0, 0,	1, 1, 1, 1, 0, 0, 1>); 3
		startingClass_t	<1, 0, 0, 1, 1,	1, 0, 0, 1, 0>	; 5
		startingClass_t	<1, 0, 0, 1, 1,	1, 0, 0, 1, 1>	; 6
byte_4302E	db 6, 42, 42, 42, 42, 32, 0,	6, 6, 22, 2Ah
		db    0
startingInventory	db 1,	14h, 0FFh, 4, 76h, 0Ah,	1, 3, 0FFh, 1, 0Eh; 0
			db 0FFh, 1, 0Ah, 0FFh, 1, 11h, 0FFh, 1,	12h, 0FFh, 0FEh; 11
			db 1, 4, 0FFh, 1, 0Ch, 0FFh, 0,	7Dh, 0Ah, 0FEh,	1; 22
			db 4, 0FFh, 1, 0Ch, 0FFh, 1, 0Ah, 0FFh,	0FEh, 1, 10h; 33
			db 0FFh, 1, 9, 0FFh, 1,	2, 1, 0FEh; 44
g_classString	dd aWarrior		    ; 0
		dd aWizard		; 1
		dd aSorcerer		; 2
		dd aConjurer		; 3
		dd aMagician		; 4
		dd aRogue		; 5
		dd aBard		; 6
		dd aPaladin		; 7
		dd aHunter		; 8
		dd aMonk		; 9
		dd aArchmage		; 10
		dd aChronomancer	; 11
		dd aGeomancer		; 12
		dd aMonster		; 13
		dd aIllusion		; 14
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

s_templeGreeting	db 'Welcome, oh weary ones, to our humble temple.',0Ah
			db 'Dost thou wish to...',0Ah
			db 'Heal a character',0Ah
			db 'Pool thy gold',0Ah
			db 'Exit temple',0
s_whomGathersGold	db 'Whom shall gather thy gold?',0
s_hathAllTheGold	db ' now hath all the gold.',0
s_whoNeedsHealing	db 'Who needeth healing?',0
			db    0
s_isInBadShape	db	' is in bad shape, indeed. ',0
			db    0
s_templeGoldForfeit	db ' in gold. Who will forfeit the gold?',0
			db    0
s_sorryButWithoutProper	db 'Sorry, but without proper sacrifice the prayer will fail.',0
s_layHands	db 'The priests lay hands on ',0
s_elipsis		db '...',0
s_elipsisAnd		db '...and ',0
s_isHealed		db ' is healed!',0
s_drainedOfLife	db ' hath been drained of life force. ',0
			db    0
s_thouMustSacrifice	db	'Thou must sacrifice ',0
			db    0
s_dontNeedHealing	db ' does not require any healing.',0
			db    0
s_hasWounds	db ' has wounds which need tending. ',0
			db    0
s_donationWillBe	db 'The donation will be ',0
temple_healPrice	dw 0, 400, 300, 900, 1120, 220, 500, 600, 900			; 8
aHe		db 'he',0
aShe		db 'she',0
aIt		db 'it',0
aHim		db 'him',0
aHer		db 'her',0
aHis		db 'his',0
aIts		db 'its',0
pronounString	dd aHe, aShe, aIt, aHim, aHer, aIt, aHis, aHer, aIts		; 7
s_shrine		db 'Shrine',0
s_forestLawn	db 'Forest Lawn',0
s_alliria	db 'Alliria',0
s_twilightTemple	db 'Twilight Tmp',0
templeLoc	templeLoc_t <8, 1, 0,	0>; 0
		templeLoc_t <10, 4, 3, 2>; 1
		templeLoc_t <2,	7, 6, 4>; 2
		templeLoc_t <255, 255, 255, 6>;	3
templeTitles	dd s_shrine, s_forestLawn, s_alliria,	s_twilightTemple; 0
templeStatusBitmasks	db 2, 1, 10h, 40h, 20h, 8, 4, 0; 0
templeHealPriceIndex	db 2, 1, 5, 7, 6, 4,	3, 0; 0
statusHealMask	db 0FFh,	0FEh, 0FDh, 3, 3, 0EFh,	0DFh, 0BFh, 0FFh, 0		; 8
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
bitMask16bit	dw 1		; 0
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
strg_inventory	db 0C3h, 0, 1, 0C3h, 0, 1, 0C3h, 0, 1, 0C3h; 0
		db 0, 1, 0Fh, 0, 0FFh, 0Fh, 0, 0FFh, 7,	0; 10
		db 0FFh, 7, 0, 0FFh, 8,	0, 0FFh, 8, 0, 0FFh; 20
		db 16h,	0, 18h,	16h, 0,	18h, 76h, 0, 0Ah; 30
		db 2, 0, 1, 2, 0, 1, 1Eh, 0, 50h, 0CAh,	0; 39
		db 5, 0DFh, 0, 0Ah, 7Bh, 0, 0FFh, 7Ch, 0; 50
		db 18h,	73h, 0,	0FFh, 74h, 0, 0FFh, 87h; 59
		db 0, 0FFh, 88h, 0, 0FFh, 98h, 0, 0FFh,	99h; 67
		db 0, 0FFh, 9Ch, 0, 0FFh, 9Dh, 0, 0FFh;	76
bigpicLightOffset dw 0,	460h, 818h, 9A0h, 8C0h;	0
bigpicLightSize	dw 1340h, 0A80h, 620h, 348h, 1C0h; 0
iconXOffset	db 80, 92, 108, 124, 136, 0; 0
iconHeight	db 19, 26, 17, 20, 16, 0; 0
iconWidth	db 12, 16, 16, 12, 20, 0; 0
iconDataList	dd	iconLight, iconCompass,	iconAreaEnchant, iconShield, iconLevitation; 0
word_4470E	dw 0E4h, 1A0h, 110h,	0F0h, 140h; 0
byte_44718	db 0, 0, 0, 0, 0, 0	   ; 0
iconAnimationDelay	db 2, 0, 4, 0, 3, 0	   ; 0
iconCurrentDelay db 0, 0, 0,	0, 0, 0	    ; 0
iconClearIndex	db 4, 4, 4, 1, 4, 0	   ; 0
iconCurrentCell	db 0, 0, 0, 0, 0, 0
aMafl		db 'MAFL',0
aMageFlame	db 'Mage Flame',0
aArfi		db 'ARFI',0
aArcFire	db 'Arc Fire',0
aTrzp		db 'TRZP',0
aTrapZap	db 'Trap Zap',0
aFrfo		db 'FRFO',0
aFreezeFoes	db 'Freeze Foes',0
aMaco		db 'MACO',0
aKielSCompass	db 'Kiel',27h,'s Compass',0
aWohl		db 'WOHL',0
aWordOfHealing	db 'Word of Healing',0
aLere		db 'LERE',0
aLesserRev_	db 'Lesser Rev.',0
aLevi		db 'LEVI',0
aLevitation	db 'Levitation',0
aWast		db 'WAST',0
aWarstrike	db 'Warstrike',0
aInwo		db 'INWO',0
aInstantWolf	db 'Instant Wolf',0
aFlre		db 'FLRE',0
aFleshRestore	db 'Flesh Restore',0
aGrre		db 'GRRE',0
aGreaterRev_	db 'Greater Rev.',0
aShsp		db 'SHSP',0
aShockSphere	db 'Shock-Sphere',0
aFlan		db 'FLAN',0
aFleshAnew	db 'Flesh Anew',0
aMale		db 'MALE',0
aMajorLev_	db 'Major Lev.',0
aRegn		db 'REGN',0
aRegeneration	db 'Regeneration',0
aApar		db 'APAR',0
aApportArcane	db 'Apport Arcane',0
aFafo		db 'FAFO',0
aFarFoe		db 'Far Foe',0
aInsl		db 'INSL',0
aInstantSlayer	db 'Instant Slayer',0
aVopl		db 'VOPL',0
aVorpalPlating	db 'Vorpal Plating',0
aQufi		db 'QUFI',0
aQuickFix	db 'Quick Fix',0
aScsi		db 'SCSI',0
aScrySight	db 'Scry Sight',0
aHowa		db 'HOWA',0
aHolyWater	db 'Holy Water',0
aMaga		db 'MAGA',0
aMageGauntlets	db 'Mage Gauntlets',0
aAren		db 'AREN',0
aAreaEnchant	db 'Area Enchant',0
aMysh		db 'MYSH',0
aMysticShield	db 'Mystic Shield',0
aOgst		db 'OGST',0
aOgreStrength	db 'Ogre Strength',0
aStfl		db 'STFL',0
aStarflare	db 'Starflare',0
aSpto		db 'SPTO',0
aSpectreTouch	db 'Spectre Touch',0
aDrbr		db 'DRBR',0
aDragonBreath	db 'Dragon Breath',0
aAnma		db 'ANMA',0
aAntiMagic	db 'Anti-Magic',0
aGist		db 'GIST',0
aGiantStrength	db 'Giant Strength',0
aPhdo		db 'PHDO',0
aPhaseDoor	db 'Phase Door',0
aYmca		db 'YMCA',0
aMysticalArmor	db 'Mystical Armor',0
aRest		db 'REST',0
aRestoration	db 'Restoration',0
aDest		db 'DEST',0
aDeathStrike	db 'Death Strike',0
aIces		db 'ICES',0
aIceStorm	db 'Ice Storm',0
aSton		db 'STON',0
aStoneToFlesh	db 'Stone to Flesh',0
aMija		db 'MIJA',0
aMindJab	db 'Mind Jab',0
aPhbl		db 'PHBL',0
aPhaseBlur	db 'Phase Blur',0
aLotr		db 'LOTR',0
aLocateTraps	db 'Locate Traps',0
aDisb		db 'DISB',0
aDisbelieve	db 'Disbelieve',0
aWiwa		db 'WIWA',0
aWindWarrior	db 'Wind Warrior',0
aFear		db 'FEAR',0
aWordOfFear	db 'Word of Fear',0
aWiog		db 'WIOG',0
aWindOgre	db 'Wind Ogre',0
aInvi		db 'INVI',0
aInvisibility	db 'Invisibility',0
aSesi		db 'SESI',0
aSecondSight	db 'Second Sight',0
aCaey		db 'CAEY',0
aCatEyes	db 'Cat Eyes',0
aWidr		db 'WIDR',0
aWindDragon	db 'Wind Dragon',0
aDiil		db 'DIIL',0
aDisruptIll_	db 'Disrupt Ill.',0
aMibl		db 'MIBL',0
aMindBlade	db 'Mind Blade',0
aWigi		db 'WIGI',0
aWindGiant	db 'Wind Giant',0
aSosi		db 'SOSI',0
aSorcerorSight	db 'Sorceror Sight',0
aRime		db 'RIME',0
aRimefang	db 'Rimefang',0
aWihe		db 'WIHE',0
aWindHero	db 'Wind Hero',0
aMagm		db 'MAGM',0
aMageMaelstrom	db 'Mage Maelstrom',0
aPrec		db 'PREC',0
aPreclusion	db 'Preclusion',0
aSuel		db 'SUEL',0
aSummonElementa	db 'Summon Elemental',0
aFofo		db 'FOFO',0
aForceFocus	db 'Force Focus',0
aPrsu		db 'PRSU',0
aPrimeSummoning	db 'Prime Summoning',0
aDeba		db 'DEBA',0
aDemonBane	db 'Demon Bane',0
aFlco		db 'FLCO',0
aFlameColumn	db 'Flame Column',0
aDisp		db 'DISP',0
aDispossess	db 'Dispossess',0
aHerb		db 'HERB',0
aSummonHerb	db 'Summon Herb',0
aAnde		db 'ANDE',0
aAnimateDead	db 'Animate Dead',0
aSpbi		db 'SPBI',0
aSpellBind	db 'Spell Bind',0
aSowh		db 'SOWH',0
aSoulWhip	db 'Soul Whip',0
aGrsu		db 'GRSU',0
aGreaterSummon	db 'Greater Summon',0
aBede		db 'BEDE',0
aBeyondDeath	db 'Beyond Death',0
aWizw		db 'WIZW',0
aWizardWar	db 'Wizard War',0
aDmst		db 'DMST',0
aDemonStrike	db 'Demon Strike',0
aHafo		db 'HAFO',0
aHaltfoe	db 'Haltfoe',0
aMeme		db 'MEME',0
aMeleeMen	db 'Melee Men',0
aBasp		db 'BASP',0
aBatchspell	db 'Batchspell',0
aCamr		db 'CAMR',0
aCamaraderie	db 'Camaraderie',0
aNila		db 'NILA',0
aNightLance	db 'Night Lance',0
aHeal		db 'HEAL',0
aHealAll	db 'Heal All',0
aBrkr		db 'BRKR',0
aKringleBros_	db 'Kringle Bros.',0
aMama		db 'MAMA',0
aMangarSMallet	db 'Mangar',27h,'s Mallet',0
aVitl		db 'VITL',0
aVitality	db 'Vitality',0
aArbo		db 'ARBO',0
aArbo_0		db 'Arbo',0
aEnik		db 'ENIK',0
aEnik_0		db 'Enik',0
aWifi		db 'WIFI',0
aWitherfist	db 'Witherfist',0
aCold		db 'COLD',0
aFrostForce	db 'Frost Force',0
aGeli		db 'GELI',0
aGeli_0		db 'Geli',0
aEcul		db 'ECUL',0
aEcul_0		db 'Ecul',0
aGofi		db 'GOFI',0
aGodFire	db 'God Fire',0
aStun		db 'STUN',0
aStunForce	db 'Stun Force',0
aLuce		db 'LUCE',0
aLuce_0		db 'Luce',0
aIleg		db 'ILEG',0
aIleg_0		db 'Ileg',0
aLuck		db 'LUCK',0
aLuckChant	db 'Luck Chant',0
aFade		db 'FADE',0
aFarDeath	db 'Far Death',0
aKine		db 'KINE',0
aKine_0		db 'Kine',0
aObra		db 'OBRA',0
aObra_0		db 'Obra',0
aWhat		db 'WHAT',0
aIdentify	db 'Identify',0
aOlay		db 'OLAY',0
aYouth		db 'Youth',0
aOluk		db 'OLUK',0
aOluk_0		db 'Oluk',0
aEcea		db 'ECEA',0
aEcea_0		db 'Ecea',0
aGrro		db 'GRRO',0
aGraveRobber	db 'Grave Robber',0
aFota		db 'FOTA',0
aForceOfTarjan	db 'Force of Tarjan',0
aAece		db 'AECE',0
aAece_0		db 'Aece',0
aKulo		db 'KULO',0
aKulo_0		db 'Kulo',0
aShsh		db 'SHSH',0
aShadowShield	db 'Shadow Shield',0
aFafi		db 'FAFI',0
aFatalFist	db 'Fatal Fist',0
aEvil		db 'EVIL',0
aEvil_0		db 'Evil',0
aLive		db 'LIVE',0
aLive_0		db 'Live',0
aEada		db 'EADA',0
aEarthDagger	db 'Earth Dagger',0
aEaso		db 'EASO',0
aEarthSong	db 'Earth Song',0
aEawa		db 'EAWA',0
aEarthWard	db 'Earth Ward',0
aTreb		db 'TREB',0
aTrebuchet	db 'Trebuchet',0
aEael		db 'EAEL',0
aEarthElemental	db 'Earth Elemental',0
aWawa		db 'WAWA',0
aWallWarp	db 'Wall Warp',0
aRock		db 'ROCK',0
aPetrify	db 'Petrify',0
aRoal		db 'ROAL',0
aRoscoeSAlert	db 'Roscoe',27h,'s Alert',0
aSuso		db 'SUSO',0
aSuccorSong	db 'Succor Song',0
aSast		db 'SAST',0
aSandstorm	db 'Sandstorm',0
aSant		db 'SANT',0
aSanctuary	db 'Sanctuary',0
aGlst		db 'GLST',0
aGlacierStrike	db 'Glacier Strike',0
aPath		db 'PATH',0
aPathfinder	db 'Pathfinder',0
aMaba		db 'MABA',0
aMagmaBlast	db 'Magma Blast',0
aJobo		db 'JOBO',0
aJoltBolt	db 'Jolt Bolt',0
aEama		db 'EAMA',0
aEarthMaw	db 'Earth Maw',0
aGill		db 'GILL',0
aGillesGills	db 'Gilles Gills',0
aDiva		db 'DIVA',0
aDivineInt_	db 'Divine Int.',0
aNuke		db 'NUKE',0
aGotterdamurung	db 'Gotterdamurung',0
aItem		db 'Item',0
aWeapon		db 'Weapon',0
aShield		db 'Shield',0
aArmor		db 'Armor',0
aHelm		db 'Helm',0
aGloves		db 'Gloves',0
aInstrument	db 'Instrument',0
aFigurine	db 'Figurine',0
aRing		db 'Ring',0
aWand		db 'Wand',0
aBow		db 'Bow',0
aQuiver		db 'Quiver',0
aContainer	db 'Container',0
aNothing	db 'Nothing',0
aTorch		db 'Torch',0
aLamp		db 'Lamp',0
aBroadsword	db 'Broadsword',0
aShortSword	db 'Short Sword',0
aDagger		db 'Dagger',0
aWarAxe		db 'War Axe',0
aHalbard	db 'Halbard',0
aLongBow	db 'Long Bow',0
aStaff		db 'Staff',0
aBuckler	db 'Buckler',0
aTowerShield	db 'Tower Shield',0
aLeatherArmor	db 'Leather Armor',0
aChainMail	db 'Chain Mail',0
aScaleArmor	db 'Scale Armor',0
aPlateArmor	db 'Plate Armor',0
aRobes		db 'Robes',0
aLeatherGloves	db 'Leather Gloves',0
aGauntlets	db 'Gauntlets',0
aMandolin	db 'Mandolin',0
aSpear		db 'Spear',0
aArrows		db 'Arrows',0
aMthrSword	db 'Mthr Sword',0
aMthrShield	db 'Mthr Shield',0
aMthrChain	db 'Mthr Chain',0
aMthrScale	db 'Mthr Scale',0
aGiantFgn	db 'Giant Fgn',0
aMthrBracers	db 'Mthr Bracers',0
aBardsword	db 'Bardsword',0
aFireHorn	db 'Fire Horn',0
aLitewand	db 'Litewand',0
aMthrDagger	db 'Mthr Dagger',0
aMthrHelm	db 'Mthr Helm',0
aMthrGloves	db 'Mthr Gloves',0
aMthrAxe	db 'Mthr Axe',0
aShuriken	db 'Shuriken',0
aMthrPlate	db 'Mthr Plate',0
aMoltenFgn	db 'Molten Fgn',0
aSpellSpear	db 'Spell Spear',0
aShieldRing	db 'Shield Ring',0
aFinSFlute	db 'Fin',27h,'s Flute',0
aKaelSAxe	db 'Kael',27h,'s Axe',0
aMthrArrows	db 'Mthr Arrows',0
aDayblade	db 'Dayblade',0
aShieldStaff	db 'Shield Staff',0
aElfCloak	db 'Elf Cloak',0
aHawkblade	db 'Hawkblade',0
aAdmtSword	db 'Admt Sword',0
aAdmtShield	db 'Admt Shield',0
aAdmtHelm	db 'Admt Helm',0
aAdmtGloves	db 'Admt Gloves',0
aPureblade	db 'Pureblade',0
aBoomerang	db 'Boomerang',0
aAliSCarpet	db 'Ali',27h,'s Carpet',0
aLuckshield	db 'Luckshield',0
aDozerFgn	db 'Dozer Fgn',0
aAdmtChain	db 'Admt Chain',0
aDeathStars	db 'Death Stars',0
aAdmtPlate	db 'Admt Plate',0
aAdmtBracers	db 'Admt Bracers',0
aSlayerFgn	db 'Slayer Fgn',0
aPureShield	db 'Pure Shield',0
aMageStaff	db 'Mage Staff',0
aWarStaff	db 'War Staff',0
aThiefDagger	db 'Thief Dagger',0
aSoulMace	db 'Soul Mace',0
aOgrewand	db 'Ogrewand',0
aKatoSBracer	db 'Kato',27h,'s bracer',0
aSorcerstaff	db 'Sorcerstaff',0
aGaltSFlute	db 'Galt',27h,'s Flute',0
aFrostHorn	db 'Frost Horn',0
aAgSArrows	db 'Ag',27h,'s Arrows',0
aDmndShield	db 'Dmnd Shield',0
aBardBow	db 'Bard Bow',0
aDmndHelm	db 'Dmnd Helm',0
aElfBoots	db 'Elf Boots',0
aVanquisherFgn	db 'Vanquisher Fgn',0
aConjurstaff	db 'Conjurstaff',0
aStaffOfLor	db 'Staff of Lor',0
aFlameSword	db 'Flame Sword',0
aPowerstaff	db 'Powerstaff',0
aBreathRing 	db 'Breath Ring',0
aDragonshield	db 'Dragonshield',0
aDmndPlate	db 'Dmnd Plate',0
aWargloves	db 'Wargloves',0
aWizhelm	db 'Wizhelm',0
aDragonwand	db 'Dragonwand',0
aDeathring	db 'Deathring',0
aCrystalSword	db 'Crystal Sword',0
aSpeedboots	db 'Speedboots',0
aFlameHorn	db 'Flame Horn',0
aZenArrows	db 'Zen Arrows',0
aDeathdrum	db 'Deathdrum',0
aPipesOfPan	db 'Pipes of Pan',0
aPowerRing	db 'Power Ring',0
aSongAxe	db 'Song Axe',0
aTrickBrick	db 'Trick Brick',0
aDragonFgn	db 'Dragon Fgn',0
aMageFgn	db 'Mage Fgn',0
aTrollRing	db 'Troll Ring',0
aAramSKnife	db 'Aram',27h,'s Knife',0
aAngraSEye	db 'Angra',27h,'s Eye',0
aHerbFgn	db 'Herb Fgn',0
aMasterWand	db 'Master Wand',0
aBrothersFgn	db 'Brothers Fgn',0
aDynamite	db 'Dynamite',0
aThorSHammer	db 'Thor',27h,'s Hammer',0
aStoneblade	db 'Stoneblade',0
aHolyHandgrenad	db 'Holy Handgrenade',0
aMasterkey	db 'Masterkey',0
aNospinRing	db 'Nospin Ring',0
aCrystalLens	db 'Crystal Lens',0
aSmokeyLens	db 'Smokey Lens',0
aBlackLens	db 'Black Lens',0
aSphereOfLanati	db 'Sphere of Lanatir',0
aWandOfPower	db 'Wand of Power',0
aAcorn		db 'Acorn',0
aWineskin	db 'Wineskin',0
aNightspear	db 'Nightspear',0
aTslothaSHead	db 'Tslotha',27h,'s Head',0
aTslothaSHeart	db 'Tslotha',27h,'s Heart',0
aArefolia	db 'Arefolia',0
aValarianSBow	db 'Valarian',27h,'s Bow',0
aArwsOfLife	db 'Arws of Life',0
aCanteen	db 'Canteen',0
aTitanPlate	db 'Titan Plate',0
aTitanShield	db 'Titan Shield',0
aTitanHelm	db 'Titan Helm',0
aFireSpear	db 'Fire Spear',0
aWillowFlute	db 'Willow Flute',0
aFirebrand	db 'Firebrand',0
aHolySword	db 'Holy Sword',0
aWandOfFury	db 'Wand of Fury',0
aLightstar	db 'Lightstar',0
aCrownOfTruth	db 'Crown of Truth',0
aBeltOfAlliria	db 'Belt of Alliria',0
aCrystalKey	db 'Crystal Key',0
aTaoRing	db 'Tao Ring',0
aStealthArrows	db 'Stealth Arrows',0
aYellowStaff	db 'Yellow Staff',0
aSteadyEye	db 'Steady Eye',0
aDivineHalbard	db 'Divine Halbard',0
aIncense	db 'Incense',0
aIChing		db 'I-ching',0
aWhiteRose	db 'White Rose',0
aBlueRose	db 'Blue Rose',0
aRedRose	db 'Red Rose',0
aYellowRose	db 'Yellow Rose',0
aRainbowRose	db 'Rainbow Rose',0
aMagicTriangle	db 'Magic Triangle',0
aXChar		db 'x', 0
aHammerOfWrath	db 'Hammer of Wrath',0
aFerofistSHelm	db 'Ferofist',27h,'s Helm',0
aHelmOfJustice	db 'Helm of Justice',0
aSceaduSCloak	db 'Sceadu',27h,'s Cloak',0
aShadelance	db 'Shadelance',0
aBlackArrows	db 'Black Arrows',0
aWerraSShield	db 'Werra',27h,'s Shield',0
aStrifespear	db 'Strifespear',0
aSheetmusic	db 'Sheetmusic',0
aRightKey	db 'Right Key',0
aLeftKey	db 'Left Key',0
aLever		db 'Lever',0
aNut		db 'Nut',0
aBolt		db 'Bolt',0
aSpanner	db 'Spanner',0
aShadowLock	db 'Shadow Lock',0
aShadowDoor	db 'Shadow Door',0
aMisericorde	db 'Misericorde',0
aHolyAvenger	db 'Holy Avenger',0
aShadowshiv	db 'Shadowshiv',0
aKaliSGarrote	db 'Kali',27h,'s Garrote',0
aFlameKnife	db 'Flame Knife',0
aRedSStiletto	db 'Red',27h,'s Stiletto',0
aHeartseeker	db 'Heartseeker',0
aDmndScale	db 'Dmnd Scale',0
aHolyTnt	db 'Holy TNT',0
aEternalTorch	db 'Eternal Torch',0
aOsconSStaff	db 'Oscon',27h,'s Staff',0
aAngelSRing	db 'Angel',27h,'s Ring',0
aDeathhorn	db 'Deathhorn',0
aStaffOfMangar	db 'Staff of Mangar',0
aTeslaRing	db 'Tesla Ring',0
aDmndBracers	db 'Dmnd Bracers',0
aDeathFgn	db 'Death Fgn',0
aThunderSword	db 'Thunder Sword',0
aPoisonDagger	db 'Poison Dagger',0
aSparkBlade	db 'Spark Blade',0
aGalvanicOboe	db 'Galvanic Oboe',0
aHarmonicGem	db 'Harmonic Gem',0
aTungShield	db 'Tung Shield',0
aTungPlate	db 'Tung Plate',0
aMinstrelsGlove	db 'Minstrels Glove',0
aHuntersCloak	db 'Hunters Cloak',0
aDeathHammer	db 'Death Hammer',0
aBloodMeshRobe	db 'Blood Mesh Robe',0
aSoothingBalm	db 'Soothing Balm',0
aMagesCloak	db 'Mages Cloak',0
aFamiliarFgn	db 'Familiar Fgn',0
aHourglass	db 'Hourglass',0
aThievesHood	db 'Thieves Hood',0
aSurehandAmulet	db 'Surehand Amulet',0
aThievesDart	db 'Thieves Dart',0
aShrillFlute	db 'Shrill Flute',0
aAngelSHarp	db 'Angel',27h,'s Harp',0
aTheBook	db 'The Book',0
aTrothLance	db 'Troth Lance',0
aDmndSuit	db 'Dmnd Suit',0
aDmndFlail	db 'Dmnd Flail',0
aPurpleHeart	db 'Purple Heart',0
aTitanBracers	db 'Titan Bracers',0
aEelskinTunic	db 'Eelskin Tunic',0
aSorcererSHood	db 'Sorcerer',27h,'s Hood',0
aDmndStaff	db 'Dmnd Staff',0
aCrystalGem	db 'Crystal Gem',0
aWandOfForce	db 'Wand of Force',0
aCliLyre	db 'Cli Lyre',0
aYouthPotion	db 'Youth Potion',0
aMthrSuit	db 'Mthr Suit',0
aTitanSuit	db 'Titan Suit',0
aMagesGlove	db 'Mages Glove',0
aFlareCrystal	db 'Flare Crystal',0
aHolyMissile	db 'Holy Missile',0
aGodsBlade	db 'Gods',27h,' Blade',0
aHunterBlade	db 'Hunter Blade',0
aStaffOfGods	db 'Staff of Gods',0
aHornOfGods	db 'Horn of Gods',0
aWater		db 'Water',0
aSpirits	db 'Spirits',0
aWaterOfLife	db 'Water of Life',0
aDragonBlood	db 'Dragon Blood',0
aMoltenTar	db 'Molten Tar',0
aHuman		db 'Human',0
aElf		db 'Elf',0
aDwarf		db 'Dwarf',0
aHobbit		db 'Hobbit',0
aHalfElf	db 'Half-Elf',0
aHalfOrc	db 'Half-Orc',0
aGnome		db 'Gnome',0
aMale_0		db 'Male',0
aFemale		db 'Female',0
nullStr		db 0
		db    0
spellString 	spellString_t <aMafl, aMageFlame>; 0
		spellString_t <aArfi, aArcFire>; 1
		spellString_t <aTrzp, aTrapZap>; 2
		spellString_t <aFrfo, aFreezeFoes>; 3
		spellString_t <aMaco, aKielSCompass>; 4
		spellString_t <aWohl, aWordOfHealing>; 5
		spellString_t <aLere, aLesserRev_>; 6
		spellString_t <aLevi, aLevitation>; 7
		spellString_t <aWast, aWarstrike>; 8
		spellString_t <aInwo, aInstantWolf>; 9
		spellString_t <aFlre, aFleshRestore>; 10
		spellString_t <aGrre, aGreaterRev_>; 11
		spellString_t <aShsp, aShockSphere>; 12
		spellString_t <aFlan, aFleshAnew>; 13
		spellString_t <aMale, aMajorLev_>; 14
		spellString_t <aRegn, aRegeneration>; 15
		spellString_t <aApar, aApportArcane>; 16
		spellString_t <aFafo, aFarFoe>;	17
		spellString_t <aInsl, aInstantSlayer>; 18
		spellString_t <aVopl, aVorpalPlating>; 19
		spellString_t <aQufi, aQuickFix>; 20
		spellString_t <aScsi, aScrySight>; 21
		spellString_t <aHowa, aHolyWater>; 22
		spellString_t <aMaga, aMageGauntlets>; 23
		spellString_t <aAren, aAreaEnchant>; 24
		spellString_t <aMysh, aMysticShield>; 25
		spellString_t <aOgst, aOgreStrength>; 26
		spellString_t <aStfl, aStarflare>; 27
		spellString_t <aSpto, aSpectreTouch>; 28
		spellString_t <aDrbr, aDragonBreath>; 29
		spellString_t <aAnma, aAntiMagic>; 30
		spellString_t <aGist, aGiantStrength>; 31
		spellString_t <aPhdo, aPhaseDoor>; 32
		spellString_t <aYmca, aMysticalArmor>; 33
		spellString_t <aRest, aRestoration>; 34
		spellString_t <aDest, aDeathStrike>; 35
		spellString_t <aIces, aIceStorm>; 36
		spellString_t <aSton, aStoneToFlesh>; 37
		spellString_t <aMija, aMindJab>; 38
		spellString_t <aPhbl, aPhaseBlur>; 39
		spellString_t <aLotr, aLocateTraps>; 40
		spellString_t <aDisb, aDisbelieve>; 41
		spellString_t <aWiwa, aWindWarrior>; 42
		spellString_t <aFear, aWordOfFear>; 43
		spellString_t <aWiog, aWindOgre>; 44
		spellString_t <aInvi, aInvisibility>; 45
		spellString_t <aSesi, aSecondSight>; 46
		spellString_t <aCaey, aCatEyes>; 47
		spellString_t <aWidr, aWindDragon>; 48
		spellString_t <aDiil, aDisruptIll_>; 49
		spellString_t <aMibl, aMindBlade>; 50
		spellString_t <aWigi, aWindGiant>; 51
		spellString_t <aSosi, aSorcerorSight>; 52
		spellString_t <aRime, aRimefang>; 53
		spellString_t <aWihe, aWindHero>; 54
		spellString_t <aMagm, aMageMaelstrom>; 55
		spellString_t <aPrec, aPreclusion>; 56
		spellString_t <aSuel, aSummonElementa>;	57
		spellString_t <aFofo, aForceFocus>; 58
		spellString_t <aPrsu, aPrimeSummoning>;	59
		spellString_t <aDeba, aDemonBane>; 60
		spellString_t <aFlco, aFlameColumn>; 61
		spellString_t <aDisp, aDispossess>; 62
		spellString_t <aHerb, aSummonHerb>; 63
		spellString_t <aAnde, aAnimateDead>; 64
		spellString_t <aSpbi, aSpellBind>; 65
		spellString_t <aSowh, aSoulWhip>; 66
		spellString_t <aGrsu, aGreaterSummon>; 67
		spellString_t <aBede, aBeyondDeath>; 68
		spellString_t <aWizw, aWizardWar>; 69
		spellString_t <aDmst, aDemonStrike>; 70
		spellString_t <aHafo, aHaltfoe>; 71
		spellString_t <aMeme, aMeleeMen>; 72
		spellString_t <aBasp, aBatchspell>; 73
		spellString_t <aCamr, aCamaraderie>; 74
		spellString_t <aNila, aNightLance>; 75
		spellString_t <aHeal, aHealAll>; 76
		spellString_t <aBrkr, aKringleBros_>; 77
		spellString_t <aMama, aMangarSMallet>; 78
		spellString_t <aVitl, aVitality>; 79
		spellString_t <aArbo, aArbo_0>; 80
		spellString_t <aEnik, aEnik_0>; 81
		spellString_t <aWifi, aWitherfist>; 82
		spellString_t <aCold, aFrostForce>; 83
		spellString_t <aGeli, aGeli_0>; 84
		spellString_t <aEcul, aEcul_0>; 85
		spellString_t <aGofi, aGodFire>; 86
		spellString_t <aStun, aStunForce>; 87
		spellString_t <aLuce, aLuce_0>; 88
		spellString_t <aIleg, aIleg_0>; 89
		spellString_t <aLuck, aLuckChant>; 90
		spellString_t <aFade, aFarDeath>; 91
		spellString_t <aKine, aKine_0>; 92
		spellString_t <aObra, aObra_0>; 93
		spellString_t <aWhat, aIdentify>; 94
		spellString_t <aOlay, aYouth>; 95
		spellString_t <aOluk, aOluk_0>; 96
		spellString_t <aEcea, aEcea_0>; 97
		spellString_t <aGrro, aGraveRobber>; 98
		spellString_t <aFota, aForceOfTarjan>; 99
		spellString_t <aAece, aAece_0>; 100
		spellString_t <aKulo, aKulo_0>; 101
		spellString_t <aShsh, aShadowShield>; 102
		spellString_t <aFafi, aFatalFist>; 103
		spellString_t <aEvil, aEvil_0>; 104
		spellString_t <aLive, aLive_0>; 105
		spellString_t <aEada, aEarthDagger>; 106
		spellString_t <aEaso, aEarthSong>; 107
		spellString_t <aEawa, aEarthWard>; 108
		spellString_t <aTreb, aTrebuchet>; 109
		spellString_t <aEael, aEarthElemental>;	110
		spellString_t <aWawa, aWallWarp>; 111
		spellString_t <aRock, aPetrify>; 112
		spellString_t <aRoal, aRoscoeSAlert>; 113
		spellString_t <aSuso, aSuccorSong>; 114
		spellString_t <aSast, aSandstorm>; 115
		spellString_t <aSant, aSanctuary>; 116
		spellString_t <aGlst, aGlacierStrike>; 117
		spellString_t <aPath, aPathfinder>; 118
		spellString_t <aMaba, aMagmaBlast>; 119
		spellString_t <aJobo, aJoltBolt>; 120
		spellString_t <aEama, aEarthMaw>; 121
		spellString_t <aGill, aGillesGills>; 122
		spellString_t <aDiva, aDivineInt_>; 123
		spellString_t <aNuke, aGotterdamurung>;	124
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
s_itsFilledWith	db 'It',27h,'s filled with ',0
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
g_itemGenericStringList	dd aItem, aWeapon, aShield, aArmor, aHelm, aGloves, aInstrument, aFigurine; 0
		dd aRing, aWand, aItem, aBow,	aQuiver, aContainer, aArmor; 8
g_itemStringList		dd aNothing, aTorch, aLamp, aBroadsword; 0
		dd aShortSword,	aDagger, aWarAxe, aHalbard; 4
		dd aLongBow, aStaff, aBuckler, aTowerShield; 8
		dd aLeatherArmor, aChainMail, aScaleArmor, aPlateArmor;	12
		dd aRobes, aHelm, aLeatherGloves, aGauntlets;	16
		dd aMandolin, aSpear, aArrows, aMthrSword; 20
		dd aMthrShield,	aMthrChain, aMthrScale,	aGiantFgn; 24
		dd aMthrBracers, aBardsword, aFireHorn,	aLitewand; 28
		dd aMthrDagger,	aMthrHelm, aMthrGloves,	aMthrAxe; 32
		dd aShuriken, aMthrPlate, aMoltenFgn, aSpellSpear; 36
		dd aShieldRing,	aFinSFlute, aKaelSAxe, aMthrArrows; 40
		dd aDayblade, aShieldStaff, aElfCloak, aHawkblade; 44
		dd aAdmtSword, aAdmtShield, aAdmtHelm, aAdmtGloves; 48
		dd aPureblade, aBoomerang, aAliSCarpet,	aLuckshield; 52
		dd aDozerFgn, aAdmtChain, aDeathStars, aAdmtPlate; 56
		dd aAdmtBracers, aSlayerFgn, aPureShield, aMageStaff; 60
		dd aWarStaff, aThiefDagger, aSoulMace, aOgrewand; 64
		dd aKatoSBracer, aSorcerstaff, aGaltSFlute, aFrostHorn;	68
		dd aAgSArrows, aDmndShield, aBardBow, aDmndHelm; 72
		dd aElfBoots, aVanquisherFgn, aConjurstaff, aStaffOfLor; 76
		dd aFlameSword,	aPowerstaff, aBreathRing, aDragonshield; 80
		dd aDmndPlate, aWargloves, aWizhelm, aDragonwand; 84
		dd aDeathring, aCrystalSword, aSpeedboots, aFlameHorn; 88
		dd aZenArrows, aDeathdrum, aPipesOfPan,	aPowerRing; 92
		dd aSongAxe, aTrickBrick, aDragonFgn, aMageFgn;	96
		dd aTrollRing, aAramSKnife, aAngraSEye,	aHerbFgn; 100
		dd aMasterWand,	aBrothersFgn, aDynamite, aThorSHammer; 104
		dd aStoneblade,	aHolyHandgrenad, aMasterkey, aNospinRing; 108
		dd aCrystalLens, aSmokeyLens, aBlackLens, aSphereOfLanati; 112
		dd aWandOfPower, aAcorn, aWineskin, aNightspear; 116
		dd aTslothaSHead, aTslothaSHeart, aArefolia, aValarianSBow; 120
		dd aArwsOfLife,	aCanteen, aTitanPlate, aTitanShield; 124
		dd aTitanHelm, aFireSpear, aWillowFlute, aFirebrand; 128
		dd aHolySword, aWandOfFury, aLightstar,	aCrownOfTruth; 132
		dd aBeltOfAlliria, aCrystalKey,	aTaoRing, aStealthArrows; 136
		dd aYellowStaff, aSteadyEye, aDivineHalbard, aIncense; 140
		dd aIChing, aWhiteRose,	aBlueRose, aRedRose; 144
		dd aYellowRose,	aRainbowRose, aMagicTriangle, aXChar; 148
		dd aHammerOfWrath, aFerofistSHelm, aXChar, aXChar; 152
		dd aHelmOfJustice, aSceaduSCloak, aShadelance, aBlackArrows; 156
		dd aWerraSShield, aStrifespear,	aSheetmusic, aRightKey;	160
		dd aLeftKey, aLever, aNut, aBolt; 164
		dd aSpanner, aShadowLock, aShadowDoor, aMisericorde; 168
		dd aHolyAvenger, aShadowshiv, aKaliSGarrote, aFlameKnife; 172
		dd aRedSStiletto, aHeartseeker,	aXChar, aXChar; 176
		dd aXChar, aDmndScale, aHolyTnt, aEternalTorch; 180
		dd aOsconSStaff, aAngelSRing, aDeathhorn, aStaffOfMangar; 184
		dd aTeslaRing, aDmndBracers, aDeathFgn,	aThunderSword; 188
		dd aPoisonDagger, aSparkBlade, aGalvanicOboe, aHarmonicGem; 192
		dd aTungShield,	aTungPlate, aMinstrelsGlove, aHuntersCloak; 196
		dd aDeathHammer, aBloodMeshRobe, aSoothingBalm,	aMagesCloak; 200
		dd aFamiliarFgn, aHourglass, aThievesHood, aSurehandAmulet; 204
		dd aThievesDart, aShrillFlute, aAngelSHarp, aTheBook; 208
		dd aTrothLance,	aDmndSuit, aDmndFlail, aPurpleHeart; 212
		dd aTitanBracers, aEelskinTunic, aSorcererSHood, aDmndStaff; 216
		dd aCrystalGem,	aWandOfForce, aCliLyre,	aYouthPotion; 220
		dd aXChar, aXChar, aXChar, aXChar; 224
		dd aXChar, aXChar, aXChar, aXChar; 228
		dd aXChar, aXChar, aXChar, aXChar; 232
		dd aXChar, aXChar, aXChar, aXChar; 236
		dd aMthrSuit, aTitanSuit, aMagesGlove, aFlareCrystal; 240
		dd aHolyMissile, aGodsBlade, aHunterBlade, aStaffOfGods; 244
		dd aHornOfGods,	aXChar, aXChar, aXChar; 248
		dd aXChar, aXChar, aXChar, aXChar; 252
wineskinString	dd aWater	       ; 0
		dd aSpirits		; 1
		dd aWaterOfLife		; 2
		dd aDragonBlood		; 3
		dd aMoltenTar		; 4
g_itemBaseCount	db 0FFh, 1, 1, 0FFh, 0FFh, 0FFh, 1, 0FFh, 0FFh, 0FFh; 0
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 10
		db 0FFh, 1, 18h, 0FFh, 0FFh, 0FFh, 0FFh, 1, 0FFh, 0FFh;	20
		db 32h,	50h, 0FFh, 0FFh, 0FFh, 1, 1, 0FFh, 1, 1; 30
		db 0FFh, 0FFh, 1, 0Ah, 50h, 0FFh, 0FFh,	0FFh, 0FFh, 0FFh; 40
		db 0FFh, 0FFh, 0FFh, 0FFh, 32h,	0FFh, 1, 0FFh, 4, 0FFh;	50
		db 0FFh, 1, 0FFh, 0FFh,	0FFh, 0FFh, 0FFh, 58h, 0FFh, 50h; 60
		db 58h,	41h, 0Ah, 0FFh,	0FFh, 0FFh, 0FFh, 1, 0FFh, 23h;	70
		db 0FFh, 33h, 0FFh, 14h, 0FFh, 0FFh, 19h, 23h, 40h, 0FFh; 80
		db 0FFh, 3Ch, 0Ah, 0Ah,	0FFh, 11h, 0FFh, 1Eh, 1, 1; 90
		db 0FFh, 1Eh, 7, 1, 0Bh, 1, 1, 0FFh, 0FFh, 1; 100
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 1,	0Ah, 0FFh; 110
		db 0FFh, 0FFh, 1, 0FFh,	18h, 0Ah, 0FFh,	0FFh, 0FFh, 1; 120
		db 5, 0FFh, 0FFh, 0Ah, 1, 0FFh,	0FFh, 0FFh, 0FFh, 18h; 130
		db 0FFh, 0FFh, 0FFh, 3,	19h, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 140
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 18h; 150
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 160
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 14h, 0FFh, 0FFh, 0FFh,	0FFh; 170
		db 0FFh, 0FFh, 2, 0FFh,	0Ah, 0FFh, 1Eh,	0FFh, 19h, 0FFh; 180
		db 1, 0FFh, 0FFh, 0FFh,	5, 1, 0FFh, 0FFh, 0FFh,	0FFh; 190
		db 0FFh, 0FFh, 5, 0Ah, 0FFh, 2,	0FFh, 0FFh, 1, 5; 200
		db 5, 4, 0FFh, 0FFh, 0FFh, 0Ah,	0FFh, 0FFh, 0FFh, 0FFh;	210
		db 3, 0Ah, 0Fh,	0Ah, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 220
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 230
		db 0FFh, 0FFh, 0FFh, 5,	1, 0FFh, 0FFh, 0Ah, 19h, 0FFh; 240
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 250
itemDamageDice	db 0, 0, 0, 33	       ; 0
		db 64, 0, 33, 96	; 4
		db 0, 64, 0, 0		; 8
		db 0, 0, 0, 0		; 12
		db 0, 0, 0, 0		; 16
		db 0, 64, 0, 33		; 20
		db 0, 0, 0, 0		; 24
		db 0, 65, 0, 0		; 28
		db 0, 0, 0, 33		; 32
		db 0, 0, 0, 96		; 36
		db 0, 0, 36, 0		; 40
		db 66, 96, 0, 66	; 44
		db 33, 0, 0, 0		; 48
		db 98, 0, 0, 0		; 52
		db 0, 0, 0, 0		; 56
		db 0, 0, 0, 66		; 60
		db 67, 52, 65, 0	; 64
		db 0, 34, 0, 0		; 68
		db 33, 0, 0, 0		; 72
		db 0, 0, 34, 36		; 76
		db 98, 66, 97, 0	; 80
		db 0, 0, 0, 0		; 84
		db 0, 98, 0, 0		; 88
		db 0, 0, 0, 0		; 92
		db 0, 0, 0, 0		; 96
		db 0, 33, 0, 0		; 100
		db 0, 0, 0, 99		; 104
		db 0, 0, 0, 0		; 108
		db 0, 0, 0, 0		; 112
		db 0, 0, 0, 100		; 116
		db 0, 0, 0, 0		; 120
		db 0, 0, 0, 0		; 124
		db 0, 99, 0, 72		; 128
		db 99, 0, 0, 0		; 132
		db 0, 0, 0, 0		; 136
		db 38, 0, 72, 0		; 140
		db 0, 0, 0, 0		; 144
		db 0, 0, 0, 0		; 148
		db 99, 0, 0, 0		; 152
		db 0, 0, 0, 0		; 156
		db 0, 0, 0, 0		; 160
		db 0, 0, 0, 0		; 164
		db 0, 0, 0, 165		; 168
		db 135,	98, 137, 105	; 172
		db 167,	32, 0, 0	; 176
		db 0, 0, 0, 0		; 180
		db 67, 0, 0, 99		; 184
		db 0, 0, 0, 99		; 188
		db 98, 99, 0, 0		; 192
		db 0, 0, 0, 0		; 196
		db 99, 0, 0, 0		; 200
		db 0, 0, 0, 0		; 204
		db 0, 0, 0, 0		; 208
		db 135,	0, 129,	0	; 212
		db 0, 0, 0, 39		; 216
		db 0, 99, 0, 0		; 220
		db 0, 0, 0, 0		; 224
		db 0, 0, 0, 0		; 228
		db 0, 0, 0, 0		; 232
		db 0, 0, 0, 0		; 236
		db 0, 0, 0, 0		; 240
		db 0, 137, 169,	41	; 244
		db 0, 0, 0, 0		; 248
		db 0, 0, 0, 0		; 252
item_acBonWeapDam db 0,	0, 0, 0		  ; 0
		db 0, 0, 0, 0		; 4
		db 0, 0, 1, 2		; 8
		db 2, 3, 4, 5		; 12
		db 1, 1, 1, 1		; 16
		db 0, 0, 0, 32		; 20
		db 3, 4, 5, 0		; 24
		db 4, 64, 0, 0		; 28
		db 32, 2, 2, 32		; 32
		db 0, 6, 0, 32		; 36
		db 2, 2, 32, 0		; 40
		db 16, 18, 3, 16	; 44
		db 64, 4, 3, 3		; 48
		db 0, 0, 2, 3		; 52
		db 0, 5, 0, 7		; 56
		db 6, 0, 5, 2		; 60
		db 0, 16, 48, 0		; 64
		db 0, 50, 0, 0		; 68
		db 96, 5, 2, 4		; 72
		db 0, 0, 34, 16		; 76
		db 17, 16, 16, 4	; 80
		db 8, 4, 3, 0		; 84
		db 1, 16, 0, 0		; 88
		db 0, 2, 2, 0		; 92
		db 3, 0, 0, 0		; 96
		db 0, 64, 0, 0		; 100
		db 0, 0, 0, 32		; 104
		db 48, 0, 0, 0		; 108
		db 0, 0, 0, 37		; 112
		db 51, 0, 0, 48		; 116
		db 0, 0, 0, 4		; 120
		db 32, 0, 10, 22	; 124
		db 5, 48, 2, 65		; 128
		db 66, 17, 0, 10	; 132
		db 0, 0, 37, 2		; 136
		db 36, 4, 49, 0		; 140
		db 0, 0, 0, 0		; 144
		db 0, 0, 0, 0		; 148
		db 0, 39, 0, 0		; 152
		db 9, 28, 0, 0		; 156
		db 8, 80, 0, 0		; 160
		db 0, 0, 0, 0		; 164
		db 0, 0, 0, 115		; 168
		db 84, 16, 49, 33	; 172
		db 66, 82, 0, 0		; 176
		db 0, 7, 0, 0		; 180
		db 51, 2, 0, 36		; 184
		db 2, 8, 0, 66		; 188
		db 49, 50, 0, 0		; 192
		db 23, 12, 7, 40	; 196
		db 81, 4, 0, 4		; 200
		db 0, 0, 4, 0		; 204
		db 0, 2, 2, 0		; 208
		db 81, 15, 80, 0	; 212
		db 10, 20, 3, 33	; 216
		db 0, 32, 5, 0		; 220
		db 0, 0, 0, 0		; 224
		db 0, 0, 0, 0		; 228
		db 0, 0, 0, 0		; 232
		db 0, 0, 0, 0		; 236
		db 10, 15, 4, 0		; 240
		db 0, 85, 83, 50	; 244
		db 0, 0, 0, 0		; 248
		db 0, 0, 0, 0		; 252
itemTypeList	db itType_item, itType_item, itType_item; 0
		db itType_weapon, itType_weapon, itType_weapon;	3
		db itType_weapon, itType_weapon, itType_bow; 6
		db itType_weapon, itType_shield, itType_shield;	9
		db itType_armor, itType_armor, itType_armor; 12
		db itType_armor, itType_armor, itType_helm; 15
		db itType_gloves, itType_gloves, itType_instrument; 18
		db itType_weapon, itType_quiver, itType_weapon;	21
		db itType_shield, itType_armor,	itType_armor; 24
		db itType_figurine, itType_armor, itType_weapon; 27
		db itType_instrument, itType_item0, itType_weapon; 30
		db itType_helm,	itType_gloves, itType_weapon; 33
		db itType_item0, itType_armor, itType_figurine;	36
		db itType_weapon, itType_ring, itType_instrument; 39
		db 11h,	itType_quiver, itType_weapon; 42
		db itType_weapon, itType_armor0, itType_weapon;	45
		db itType_weapon, itType_shield, itType_helm; 48
		db itType_gloves, itType_weapon, itType_item0; 51
		db itType_item0, itType_shield,	itType_figurine; 54
		db itType_armor, itType_weapon,	itType_armor; 57
		db itType_armor, itType_figurine, itType_shield; 60
		db itType_weapon, itType_weapon, itType_weapon;	63
		db 51h,	itType_wand, itType_item0; 66
		db itType_weapon, itType_instrument, itType_instrument;	69
		db itType_quiver, itType_shield, itType_bow; 72
		db itType_helm,	itType_item0, itType_figurine; 75
		db itType_weapon, itType_weapon, itType_weapon;	78
		db itType_weapon, itType_ring, itType_shield; 81
		db itType_armor, itType_gloves,	itType_helm; 84
		db itType_wand,	itType_ring, itType_weapon; 87
		db itType_item0, itType_instrument, itType_quiver; 90
		db itType_instrument, itType_instrument, itType_ring; 93
		db itType_weapon, itType_item0,	itType_figurine; 96
		db itType_figurine, itType_ring, itType_weapon;	99
		db itType_item0, itType_figurine, itType_wand; 102
		db itType_figurine, itType_item0, itType_weapon; 105
		db 61h,	itType_item0, itType_item0; 108
		db itType_ring,	itType_item, itType_item; 111
		db itType_item,	itType_item0, itType_wand; 114
		db itType_item0, itType_container, itType_weapon; 117
		db itType_item0, itType_item0, itType_item0; 120
		db itType_bow, itType_quiver, itType_container;	123
		db itType_armor, itType_shield,	itType_helm; 126
		db itType_weapon, itType_instrument, 51h; 129
		db itType_weapon, itType_wand, itType_item0; 132
		db itType_helm,	itType_item0, itType_item0; 135
		db itType_ring,	itType_quiver, itType_weapon; 138
		db itType_item0, itType_weapon,	itType_item0; 141
		db itType_item0, itType_item0, itType_item0; 144
		db itType_item0, itType_item0, itType_item0; 147
		db itType_item0, itType_item0, itType_weapon; 150
		db itType_helm,	itType_item0, itType_item0; 153
		db itType_helm,	itType_armor, itType_weapon; 156
		db itType_item0, itType_shield,	71h; 159
		db itType_item0, itType_item0, itType_item0; 162
		db itType_item0, itType_item0, itType_item0; 165
		db itType_item0, itType_item0, itType_item0; 168
		db itType_weapon, itType_weapon, itType_weapon;	171
		db itType_weapon, itType_weapon, itType_weapon;	174
		db 71h,	itType_item0, itType_item0; 177
		db itType_item0, itType_armor, itType_item0; 180
		db itType_item0, 11h, itType_ring; 183
		db itType_instrument, 51h, itType_ring;	186
		db itType_armor, itType_figurine, itType_weapon; 189
		db 11h,	itType_weapon, itType_instrument; 192
		db itType_item0, itType_shield,	itType_armor; 195
		db itType_gloves, itType_armor,	itType_weapon; 198
		db itType_armor, itType_item0, itType_armor; 201
		db itType_figurine, itType_item0, itType_helm; 204
		db itType_item0, itType_item0, itType_instrument; 207
		db itType_instrument, itType_item0, itType_weapon; 210
		db itType_armor0, itType_weapon, itType_item0; 213
		db itType_armor, itType_instrument, itType_helm; 216
		db itType_weapon, itType_item0,	itType_wand; 219
		db itType_instrument, itType_item0, itType_item0; 222
		db itType_item0, itType_item0, itType_item0; 225
		db itType_item0, itType_item0, itType_item0; 228
		db itType_item0, itType_item0, itType_item0; 231
		db itType_item0, itType_item0, itType_item0; 234
		db itType_item0, itType_item0, itType_item0; 237
		db itType_armor, itType_armor, itType_gloves; 240
		db itType_item0, itType_weapon,	itType_weapon; 243
		db itType_weapon, itType_weapon, itType_instrument; 246
		db itType_item0, itType_item0, itType_item0; 249
		db itType_item0, itType_item0, itType_item0; 252
		db itType_item0		; 255
classEquipMask	db 80h, 40h, 40h, 40h, 40h, 10h, 8, 4; 0
		db 2, 1, 20h, 60h, 0E0h, 0, 0, 0; 8
itemEquipMask	db 0, 0FFh, 0FFh, 8Fh, 9Fh, 0FFh, 8Fh, 87h; 0
		db 9Fh,	0FFh, 9Fh, 8Eh,	9Fh, 8Fh, 8Eh, 86h; 8
		db 0FFh, 9Fh, 0FFh, 86h, 8, 9Fh, 9Fh, 9Eh; 16
		db 9Eh,	8Fh, 9Eh, 0FFh,	70h, 8,	8, 60h;	24
		db 0FFh, 9Fh, 8Ch, 8Fh,	9Bh, 86h, 0FFh,	9Fh; 32
		db 0FFh, 8, 8Eh, 9Fh, 8Eh, 0FFh, 71h, 8Eh; 40
		db 9Eh,	9Eh, 9Eh, 84h, 4, 99h, 0FFh, 9Eh; 48
		db 0FFh, 8Eh, 2, 86h, 70h, 0FFh, 4, 60h; 56
		db 0FFh, 10h, 8Eh, 60h,	70h, 60h, 8, 8;	64
		db 86h,	8Eh, 8,	86h, 0FFh, 8, 60h, 61h;	72
		db 86h,	0FCh, 0FFh, 9Eh, 8Ch, 84h, 60h,	60h; 80
		db 86h,	8Eh, 9Fh, 8, 9Fh, 8, 8,	62h; 88
		db 8, 60h, 0FFh, 0FFh, 0FFh, 86h, 6Ch, 0FFh; 96
		db 60h,	0FFh, 0FFh, 84h, 86h, 0FFh, 0FFh, 0FFh;	104
		db 0FFh, 0FFh, 0FFh, 60h, 60h, 0FFh, 0FFh, 9Fh;	112
		db 0FFh, 0FFh, 0FFh, 9Fh, 9Fh, 0FFh, 84h, 8Ch; 120
		db 86h,	9Fh, 8,	9Eh, 4,	60h, 2,	86h; 128
		db 0FFh, 0FFh, 1, 2, 60h, 2, 87h, 1; 136
		db 1, 0FFh, 0FFh, 0FFh,	0FFh, 0FFh, 0FFh, 0FFh;	144
		db 84h,	86h, 0FFh, 0FFh, 10h, 10h, 86h,	9Fh; 152
		db 8Eh,	8Eh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 160
		db 0FFh, 0FFh, 0FFh, 10h, 4, 10h, 10h, 10h; 168
		db 10h,	10h, 0FFh, 0FFh, 0FFh, 8Eh, 0FFh, 0FFh;	176
		db 60h,	0FFh, 8, 20h, 60h, 70h,	0FFh, 8; 184
		db 10h,	80h, 8,	60h, 8Ch, 84h, 8, 2; 192
		db 80h,	60h, 0FFh, 20h,	20h, 60h, 10h, 10h; 200
		db 10h,	8, 8, 4, 86h, 84h, 84h,	0FFh; 208
		db 70h,	2, 60h,	20h, 60h, 60h, 8, 0FFh;	216
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 224
		db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh; 232
		db 86h,	80h, 60h, 60h, 9Fh, 84h, 2, 60h; 240
		db 8, 0FFh, 0FFh, 0FFh,	0FFh, 0FFh, 0FFh, 0FFh;	248
itemEffectList	db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 0
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 4
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 8
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 12
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 16
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 20
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 24
		db itemEff_none, itemEff_freeSinging, itemEff_none, itemEff_none; 28
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 32
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 36
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 40
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 44
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 48
		db itemEff_none, itemEff_none, itemEff_none, itemEff_alwaysHide; 52
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 56
		db itemEff_none, itemEff_none, itemEff_none, itemEff_anotherSpptRegen; 60
		db itemEff_none, 8, itemEff_none, itemEff_none;	64
		db itemEff_calmMonster,	itemEff_none, itemEff_none, itemEff_none; 68
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 72
		db itemEff_none, itemEff_none, itemEff_halfSpptUsage, itemEff_none; 76
		db itemEff_none, itemEff_none, itemEff_breathDefense, itemEff_none; 80
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 84
		db itemEff_none, itemEff_none, itemEff_alwaysRunAway, itemEff_none; 88
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 92
		db itemEff_freeSinging,	itemEff_none, itemEff_none, itemEff_none; 96
		db itemEff_regenHP, itemEff_none, itemEff_none,	itemEff_none; 100
		db itemEff_none, itemEff_none, itemEff_none, itemEff_regenHP; 104
		db itemEff_none, itemEff_none, 0Bh, itemEff_noSpin; 108
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 112
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 116
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 120
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 124
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 128
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 132
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 136
		db itemEff_anotherSpptRegen, itemEff_none, itemEff_none, itemEff_none; 140
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 144
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 148
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 152
		db 8, itemEff_none, itemEff_none, itemEff_none;	156
		db itemEff_breathDefense, itemEff_none,	itemEff_none, itemEff_none; 160
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 164
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 168
		db itemEff_none, itemEff_alwaysHide, 8,	itemEff_none; 172
		db itemEff_none, itemEff_breathDefense,	itemEff_none, itemEff_none; 176
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 180
		db itemEff_regenSppt, itemEff_resurrect, itemEff_alwaysHide, itemEff_halfSpptUsage; 184
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 188
		db itemEff_none, itemEff_none, itemEff_freeSinging, itemEff_none; 192
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 196
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 200
		db itemEff_regenSppt, itemEff_none, 8, itemEff_alwaysHide; 204
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 208
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 212
		db itemEff_none, itemEff_none, itemEff_resurrect, itemEff_regenSppt; 216
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 220
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 224
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 228
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 232
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 236
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 240
		db itemEff_none, itemEff_none, itemEff_none, itemEff_quaterSpptUse; 244
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 248
		db itemEff_none, itemEff_none, itemEff_none, itemEff_none; 252
itemSpellNo	db 255, 126, 127, 255   ; 0	; This array holds the spell number to call when
		db 255,	255, 131, 255	; 4 ; using the	particular item
		db 255,	255, 255, 255	; 8
		db 255,	255, 255, 255	; 12
		db 255,	255, 255, 255	; 16
		db 255,	131, 131, 255	; 20
		db 255,	255, 255, 132	; 24
		db 255,	255, 133, 6	; 28
		db 255,	255, 255, 131	; 32
		db 131,	255, 132, 131	; 36
		db 255,	255, 131, 131	; 40
		db 6, 255, 255,	255	; 44
		db 255,	255, 255, 255	; 48
		db 255,	131, 14, 255	; 52
		db 132,	255, 131, 255	; 56
		db 255,	132, 255, 255	; 60
		db 255,	255, 255, 51	; 64
		db 255,	49, 54,	133	; 68
		db 131,	255, 255, 255	; 72
		db 255,	132, 255, 34	; 76
		db 255,	66, 255, 133	; 80
		db 255,	255, 69, 133	; 84
		db 64, 255, 255, 133	; 88
		db 131,	35, 11,	55	; 92
		db 131,	36, 132, 132	; 96
		db 255,	131, 73, 63	; 100
		db 75, 77, 78, 131	; 104
		db 255,	78, 255, 255	; 108
		db 130,	130, 130, 130	; 112
		db 67, 128, 129, 131	; 116
		db 255,	130, 122, 130	; 120
		db 131,	129, 255, 255	; 124
		db 255,	131, 69, 255	; 128
		db 11, 133, 131, 255	; 132
		db 130,	130, 7,	131	; 136
		db 255,	255, 255, 15	; 140
		db 21, 130, 130, 130	; 144
		db 130,	130, 130, 255	; 148
		db 130,	130, 255, 255	; 152
		db 255,	130, 75, 131	; 156
		db 130,	91, 130, 130	; 160
		db 130,	130, 130, 130	; 164
		db 130,	130, 130, 11	; 168
		db 11, 255, 255, 61	; 172
		db 71, 255, 255, 255	; 176
		db 255,	255, 78, 126	; 180
		db 37, 255, 133, 255	; 184
		db 69, 255, 132, 11	; 188
		db 255,	12, 69,	134	; 192
		db 255,	255, 255, 255	; 196
		db 255,	255, 15, 73	; 200
		db 132,	87, 45,	255	; 204
		db 133,	17, 15,	62	; 208
		db 255,	255, 255, 34	; 212
		db 255,	255, 55, 255	; 216
		db 134,	99, 133, 95	; 220
		db 255,	255, 255, 255	; 224
		db 255,	255, 255, 255	; 228
		db 255,	255, 255, 255	; 232
		db 255,	255, 255, 255	; 236
		db 255,	255, 255, 134	; 240
		db 131,	255, 255, 120	; 244
		db 133,	255, 255, 255	; 248
		db 255,	255, 255, 255	; 252
g_raceString	dd aHuman		   ; 0
		dd aElf			; 1
		dd aDwarf		; 2
		dd aHobbit		; 3
		dd aHalfElf		; 4
		dd aHalfOrc		; 5
		dd aGnome		; 6
s_genderString	dd aMale_0		     ; 0
		dd aFemale		; 1
		dd nullStr
		s_isAn db ' is a/n \ ',0
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
s_percentD		db '%d',0
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
aDissentionInYo	db 'Dissention in your ranks...',0Ah
db 0Ah,0
aWillThereEverB	db '"Will there ever be an end to them?" you shout. You see ',0
aEnjoyYourNextL	db '"Enjoy your next life!" you snarl. You see ',0
aYourBattlecryI	db 'Your battlecry is heard by all as you face ',0
aYourOnslaughtI	db 'Your onslaught is greeted with laughter, you face ',0
aNotAgainYouMoa	db '"Not again!" you moan as you face ',0
aGimmeABreakWhe	db '"Gimme a break! Where do they come from?" You see ',0
align 2
specialAttString dd aKilling, aPoisoning, aDraining, aCrazing, aWithering; 0
		dd aPossessing,	aStoning, aCriticallyHitt, aStealing, aPhazing;	5
breathAttack	breathAtt_t <0, 0, 0, 0, 0, 41h, 1>; 0
		db    0
aYouStillFace	db 'You still face ',0
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
aWillYourGallantBand db	'Will your gallant band choose to:',0Ah
		db '@Fight bravely',0Ah
		db '@Advance ahead',0Ah
		db '@Run away',0Ah,0
		db    0
aThePartyAdvances db 0Ah,0Ah,'The party advances!',0Ah,0Ah,0
aHasTheseOptionsThisBa db ' has these options this battle round:',0Ah,0Ah
		db '@Attack foes ',0
		db    0
byte_4724A	db 31h
		db  30h	; 0
		db  27h	
		db    0
a@defend@partyAttack@c db 0Ah
		db '@Defend',0Ah
		db '@Party attack',0Ah
		db '@Cast a spell',0Ah
		db '@Use an item',0Ah
		db '@Hide in shadows',0Ah
		db '@Bard Song',0Ah,0
		db    0
aSelectAnOption_ db 0Ah,0Ah,'Select an option.',0
s_nlUseOn	db 0Ah,'Use on ',0
		db    0
aYouCanTUseThatItem_ db	'You can',27h,'t use that item.',0
		db    0
s_attack	db 0Ah,'Attack ',0
		db    0
s_useTheseCommands? db 'Use these commands?',0Ah,0Ah,0
aAndHits	db ', and hits ',0
aTimesFor	db ' times for ',0
aAndHitsFor	db ', and hits for ',0
s_firesBreathes	db ' /fir\breath\es ',0
		db    0
s_lost		db ' lost ',0
		db    0
s_voice		db ' voice!',0Ah,0Ah,0
s_plays	db ' plays...',0Ah,0Ah,0
aHostilePartyMembers db	'hostile party members!',0Ah,0Ah,0
		db    0
asc_473AE	db ',',0
aAnd_1		db 'and ',0
		db 0
a__1		db '.',0Ah,0Ah,0
aParty		db 'Party',0
aSorryBud	db 'Sorry, Bud',0
		db    0
aAlasYourPartyHasExp db	'Alas, your party has expired, but gone to adventurer heaven.',0
		db    0
g_monkDamageDice	db 20h, 21h, 22h, 23h, 24h, 25h, 26h, 27h
			db 68h, 69h, 6Ah, 6Bh, 6Ch, 6Dh, 6Eh, 8Fh
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
battleCryString	dd aDissentionInYo	; 0
		dd aWillThereEverB	; 1
		dd aEnjoyYourNextL	; 2
		dd aYourBattlecryI	; 3
		dd aYourOnslaughtI	; 4
		dd aNotAgainYouMoa	; 5
		dd aGimmeABreakWhe	; 6
aMember17	db 'member #(1-7)',0
aMember1	db 'member #(1)',0
aOr		db ' or ',0
		db    0
vowelList	db 'A', 'E', 'I', 'O', 'U', 0               ; 4
byte_475AE	db 5, 7, 7, 3	   ; 0
		db 3, 0, 0, 5		; 4
		db 5, 0Ah, 0Fh,	0Fh	; 8
		db 16h			; 12
aBadDiceMaskRange db 'Bad dice mask range',0
		db    0
off_475D0	dd bat_partyFightAction
		dd bat_partyAdvanceAction
		dd bat_partyRunAction
off_475DC	dd bat_charAttackAction, bat_charDefendAction; 0
		dd bat_charPartyAttackAction, bat_charCastAction; 2
		dd bat_charUseAction, bat_charHideAction;	4
		dd bat_charSingAction		; 6
g_classToHitBonus	db 3, 1, 1, 1, 1, 0, 0, 3, 3, 4, 1, 1, 4, 0
g_monsterAcBonusList	db 3, 2, 0, 0FEh	   ; 0
g_monsterAdvanceSpeedAcBonusList	db 0FFh, 0FFh, 0FFh, 0, 0, 0, 0, 0, 1, 1
s_experiencePoinsForV db ' experience points for valor and battle knowledge, and ',0
aTheyDisbelieve	db 'They disbelieve!',0Ah,0Ah,0
		db    0
s_inGold	db ' in gold.',0Ah,0Ah,0
s_foundA		db ' found a ',0
s_eachCharacterReceives db 'Each character receives ',0
		db    0
aThePartyDisbelieves_ db 'The party disbelieves...',0Ah,0Ah,0
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
aTheEntryStairs	db 'the entry stairs.',0
aTheEntryPortal	db 'the entry portal.',0
aTheEntryway_	db 'the entryway.',0
aTheBaseOfTheMo	db 'the base of the mountain.',0
aAVantagePoint_	db 'a vantage point.',0
aTheWayIn_	db 'the way in.',0
aTheExit_	db 'the exit.',0
align 2
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
aPointSOfDamage	db ' point/\s\ of damage',0
align 2
aAnd		db	'And ',0
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
s_youFace	db 'You face ',0
s_levels		db ' level/\s',0
s_aboveBelow	db ' /above\below\',0
align 2
s_paces		db ' pace/\s',0
align 2
s_northSouth	db ' /north\south\',0
align 2
s_eastWest	db ' /east\west\',0
align 2
s_andAreAt	db ' and are at ',0
align 2
s_of		db ' of ',0
align 2
s_andAre		db ' and /\are \',0
align 2
scryBaseStringList dd aTheEntryStairs, aTheEntryPortal,	aTheEntryway_
		dd aTheBaseOfTheMo, aAVantagePoint_, aTheWayIn_
		dd aTheExit_
byte_47EDC	db 0, 0, 4, 2	   ; 0
		db 2, 2, 2, 9		; 4
		db 0, 0, 0, 0		; 8
		db 0, 0, 0, 0		; 12
		db 4, 4, 4, 4		; 16
		db 8, 8, 0, 0		; 20
		db 0, 0, 0, 0		; 24
		db 0, 6, 6, 0		; 28
		db 0, 0, 0, 0		; 32
		db 0, 0, 0, 0		; 36
		db 0, 0, 0, 0		; 40
		db 0, 0Eh, 0, 0Ah	; 44
		db 0, 0, 0, 3		; 48
		db 0, 0, 0, 0		; 52
		db 10h,	15h, 1,	1	; 56
		db 1, 0			; 60
byte_47F1A	db 0, 0, 0Eh, 0	   ; 0
		db 0, 0, 0, 0		; 4
		db 0, 0, 0, 0		; 8
		db 4, 4, 4, 4		; 12
		db 0, 0, 0, 0		; 16
		db 2, 2, 1, 1		; 20
		db 9, 9, 0, 0		; 24
		db 0, 0, 0, 0		; 28
		db 0, 0, 0, 0		; 32
		db 0, 0, 0, 0		; 36
		db 0, 0, 0Ah, 0Ah	; 40
		db 0Ah,	0Bh, 0,	0	; 44
		db 6, 6, 6, 0Ch		; 48
		db 0Eh,	0Eh, 0Eh, 0Eh	; 52
		db 0Ah,	3, 1, 1		; 56
		db 0, 0			; 60
byte_47F58	db 0, 0, 2, 0	   ; 0
		db 0, 0, 0, 2		; 4
		db 0, 0, 0, 0		; 8
		db 0, 0, 0, 0		; 12
		db 0, 0, 0, 0		; 16
		db 0, 0, 0, 0		; 20
		db 3, 3, 0, 0		; 24
		db 0, 0, 0, 4		; 28
		db 4, 4, 4, 4		; 32
		db 4, 4, 4, 4		; 36
		db 0, 0, 5, 5		; 40
		db 5, 6, 6, 6		; 44
		db 6, 6, 6, 1		; 48
		db 0, 0, 0, 0		; 52
		db 2, 2, 1, 2		; 56
spellCastFlags	db 1Ch		; 0
		db 0Bh		; 1
		db 14h		; 2
		db 0Ah		; 3
		db 1Ch		; 4
		db 38h		; 5
		db 1Ch		; 6
		db 1Ch		; 7
		db 0Ah		; 8
		db 1Ch		; 9
		db 38h		; 10
		db 1Ch		; 11
		db 0Ah		; 12
		db 3Ch		; 13
		db 1Ch		; 14
		db 38h		; 15
		db 14h		; 16
		db 0Ah		; 17
		db 1Ch		; 18
		db 28h		; 19
		db 38h		; 20
		db 14h		; 21
		db 0Bh		; 22
		db 28h		; 23
		db 1Ch		; 24
		db 1Ch		; 25
		db 28h		; 26
		db 0Ah		; 27
		db 0Bh		; 28
		db 0Ah		; 29
		db 0Ch		; 30
		db 2Ch		; 31
		db 14h		; 32
		db 1Ch		; 33
		db 3Ch		; 34
		db 0Bh		; 35
		db 0Ah		; 36
		db 38h		; 37
		db 0Bh		; 38
		db 0Ch		; 39
		db 1Ch		; 40
		db 0Ch		; 41
		db 1Ch		; 42
		db 0Ah		; 43
		db 1Ch		; 44
		db 0Ch		; 45
		db 1Ch		; 46
		db 1Ch		; 47
		db 1Ch		; 48
		db 0Ch		; 49
		db 0Ch		; 50
		db 1Ch		; 51
		db 1Ch		; 52
		db 0Ch		; 53
		db 1Ch		; 54
		db 0Ah		; 55
		db 0FCh		; 56
		db 1Ch		; 57
		db 0Ah		; 58
		db 1Ch		; 59
		db 0Bh		; 60
		db 0Ah		; 61
		db 38h		; 62
		db 1Ch		; 63
		db 8		; 64
		db 0Ah		; 65
		db 0Bh		; 66
		db 1Ch		; 67
		db 38h		; 68
		db 0Ah		; 69
		db 0Ah		; 70
		db 0Ch		; 71
		db 0Ah		; 72
		db 1Ch		; 73
		db 0Ch		; 74
		db 0Ah		; 75
		db 1Ch		; 76
		db 1Ch		; 77
		db 0Ch		; 78
		db 38h		; 79
		db 1Ch		; 80
		db 1Ch		; 81
		db 0Ah		; 82
		db 0Ah		; 83
		db 1Ch		; 84
		db 1Ch		; 85
		db 0Ah		; 86
		db 0Ch		; 87
		db 1Ch		; 88
		db 1Ch		; 89
		db 0Ch		; 90
		db 0Bh		; 91
		db 1Ch		; 92
		db 1Ch		; 93
		db 14h		; 94
		db 38h		; 95
		db 1Ch		; 96
		db 1Ch		; 97
		db 38h		; 98
		db 0Ah		; 99
		db 1Ch		; 100
		db 1Ch		; 101
		db 1Ch		; 102
		db 0Ch		; 103
		db 1Ch		; 104
		db 1Ch		; 105
		db 0Ah		; 106
		db 14h		; 107
		db 14h		; 108
		db 0Ch		; 109
		db 1Ch		; 110
		db 14h		; 111
		db 0Bh		; 112
		db 14h		; 113
		db 14h		; 114
		db 0Ah		; 115
		db 14h		; 116
		db 0Bh		; 117
		db 14h		; 118
		db 0Ah		; 119
		db 0Ch		; 120
		db 0Ah		; 121
		db 14h		; 122
		db 0FCh		; 123
		db 0Ch		; 124
		db 1Ch		; 125
		db 1Ch		; 126
		db 1Ch		; 127
		db 1Ch		; 128
		db 1Ch		; 129
		db 1Ch		; 130
		db 0Bh		; 131
		db 1Ch		; 132
		db 0Ah		; 133
		db 1Ch		; 134
		db 0Ch		; 135
spellEffectFlags db splf_mageflame	; 0 Mage Flame
		db 0B6h			; 1
		db 0			; 2
		db 2			; 3
		db 20h			; 4
		db 4			; 5
		db splf_lesserrev	; 6
		db 4			; 7
		db 2Ah			; 8
		db 0			; 9
		db 0Ah			; 10
		db splf_greaterrev	; 11
		db 31h			; 12
		db 0Ah			; 13
		db 0FFh			; 14
		db 0FDh			; 15
		db 0			; 16
		db 4			; 17
		db 1			; 18
		db 2			; 19
		db 0FEh			; 20
		db 0			; 21
		db 69h			; 22
		db 4			; 23
		db 4			; 24
		db 4			; 25
		db 7			; 26
		db 38h			; 27
		db 0A8h			; 28
		db 3Fh			; 29
		db 2			; 30
		db 0Ah			; 31
		db 0			; 32
		db 0FFh			; 33
		db 0FDh			; 34
		db 0AFh			; 35
		db 70h			; 36
		db 0			; 37
		db 0BDh			; 38
		db 1			; 39
		db 4			; 40
		db disb_disbelieve	; 41
		db 82h			; 42
		db 1			; 43
		db 83h			; 44
		db 4			; 45
		db 6			; 46
		db splf_cateyes		; 47
		db 84h,	disb_disruptill, 0,	85h	; 48
		db 0FFh, 15h, 86h, 77h	; 52
		db disb_nosummon,	7, 46h,	8	; 56
		db 0C4h, 4Dh, 0, 9	; 60
		db 0E0h, 0, 0CBh, 0Ah	; 64
		db 0, 54h, 7Eh,	0	; 68
		db 0, 0, 0, 5Bh		; 72
		db 0FDh, 0Bh, 7, 0FFh	; 76
		db 0, 0, 62h, 85h	; 80
		db 0, 0, 8Ch, 0EEh	; 84
		db 0, 0, 8, 0D2h	; 88
		db 0, 0, 0, 0		; 92
		db 0, 0, 6, 9		; 96
		db 0, 0, 0FFh, 1Ch	; 100
		db 0, 0, 93h, 6		; 104
		db 0, 0A1h, 0Ch, 80h	; 108
		db 0D9h, 8, 4, 6	; 112
		db 2, 0E7h, 0Ah, 9Ah	; 116
		db 0Eh,	0, 0, 5		; 120
		db 23h,	0, 4, 5		; 124
		db 0, 0, 0, 0		; 128
		db 0, 0, 0, 0		; 132
spellExtraFlags	db 0			; 0
		db 1			; 1
		db 0			; 2
		db 0Ah			; 3
		db 0			; 4
		db 0			; 5
		db 0			; 6
		db 0			; 7
		db 2			; 8
		db 0			; 9
		db 1			; 10
		db 0			; 11
		db 83h			; 12
		db 81h			; 13
		db 0			; 14
		db 1			; 15
		db 0, 0, 0, 0, 0, 0, 1,	0; 16
		db 1, 2, 0, 84h, 7, 83h, 0, 1; 24
		db 0, 2, 81h, 1, 5, 2, 84h, 0; 32
		db 0, 0, 0, 0, 0, 0, 2,	0; 40
		db 0, 0, 83h, 0, 2, 4, 0, 0Ah; 48
		db 0Ah,	0, 1, 0, 3, 3, 3, 0; 56
		db 0, 0, 7, 0, 4, 5, 85h, 0; 64
		db 0, 0, 0, 6, 86h, 0, 0Ah, 0; 72
		db 0, 0, 2, 8, 0, 0, 8,	5; 80
		db 0, 0, 0, 3, 0, 0, 0,	5; 88
		db 0, 0, 0, 0, 0, 0, 4,	0Ah; 96
		db 0, 0, 84h, 0, 0, 0Ah, 0, 0; 104
		db 6, 0, 0, 0, 0, 0Ah, 85h, 5; 112
		db 0Ah,	5, 0, 0Ah, 0Ah,	0, 1, 1; 120
		db 0, 0, 0, 0, 0, 0, 0,	0; 128
spptRequired	db 2, 3, 2, 3, 3, 4, 5, 4;	0
		db 5, 6, 6, 7, 7, 9, 8,	12; 8
		db 15, 18, 12, 3, 3, 2,	4, 5; 16
		db 5, 6, 6, 6, 8, 7, 8,	10; 24
		db 10, 10, 25, 16, 11, 20, 3, 2; 32
		db 2, 4, 5, 4, 6, 6, 6,	7; 40
		db 12, 8, 10, 11, 11, 20, 16, 40; 48
		db 50, 10, 11, 14, 11, 14, 12, 13; 56
		db 14, 16, 13, 22, 18, 16, 25, 15; 64
		db 20, 28, 26, 30, 50, 60, 80, 12; 72
		db 10, 10, 20, 20, 15, 15, 25, 30; 80
		db 20, 20, 45, 50, 25, 25, 60, 60; 88
		db 30, 30, 65, 70, 35, 35, 60, 100; 96
		db 50, 50, 5, 5, 8, 10,	15, 15;	104
		db 18, 20, 20, 25, 30, 40, 40, 50; 112
		db 60, 80, 10, 250, 150, 1; 120
breathEffectStr	dd aFried, aFrozen, aShocked, aDrained, aBurnt; 0
		dd aChoked, aSteamed, aBlasted, aHit, aNuked;	5
damageSpellData	breathAtt_t <0,	0Ch, 4,	0, 38h,	0C0h, 1>; 0
		breathAtt_t <0,	4, 0, 0, 38h, 0C0h, 8>;	1
		breathAtt_t <0,	0Ch, 4,	0, 38h,	0C0h, 10h>	; 2
		breathAtt_t <0,	14h, 2,	0, 58h,	0C0h, 1>; 3
		breathAtt_t <0,	4, 10h,	0, 3Dh,	0C0h, 0Dh>	; 4
		breathAtt_t <0,	4, 12h,	0, 5Fh,	0C0h, 10h>	; 5
		breathAtt_t <0,	0Ch, 4,	0, 24h,	40h, 1>; 6
		breathAtt_t <0,	0Ch, 4,	0, 2Eh,	40h, 1>; 7
		breathAtt_t <0,	0Ch, 4,	0, 29h,	40h, 1>; 8
		breathAtt_t <0,	84h, 8,	0, 47h,	40h, 1>; 9
		breathAtt_t <0,	4, 10h,	0, 38h,	40h, 1>; 10
		breathAtt_t <0,	84h, 8,	0, 35h,	40h, 1>; 11
		breathAtt_t <0,	0Ch, 4,	0, 38h,	40h, 2>; 12
		breathAtt_t <0,	14h, 2,	0, 38h,	40h, 4>; 13
		breathAtt_t <4,	4, 6, 0, 1Dh, 40h, 0Ah>; 14
		breathAtt_t <0,	24h, 6,	80h, 25h, 0, 1>; 15
		breathAtt_t <0,	14h, 2,	0, 33h,	40h, 1>; 16
		breathAtt_t <0,	4, 0Ah,	20h, 3Dh, 40h, 2>		; 17
		breathAtt_t <0,	4, 10h,	40h, 13h, 40h, 0Ah>	; 18
		breathAtt_t <0,	14h, 2,	0, 58h,	40h, 2>; 19
		breathAtt_t <0,	24h, 0Eh, 0, 2Bh, 40h, 5>		; 20
		breathAtt_t <0,	24h, 0,	0, 38h,	40h, 8>; 21
		breathAtt_t <0,	84h, 8,	0, 3Dh,	40h, 0Ah>	; 22
		breathAtt_t <0,	4, 0, 0, 2Eh, 0C0h, 0Ah>; 23
		breathAtt_t <4,	4, 6, 0, 2Eh, 0, 1>; 24
		breathAtt_t <7,	4, 10h,	0, 0, 0, 1>; 25
		breathAtt_t <0,	84h, 8,	0, 20h,	0, 0>; 26
		breathAtt_t <0,	0Ch, 4,	0, 21h,	0, 0>; 27
		breathAtt_t <0,	84h, 8,	40h, 38h, 0, 4>; 28
		breathAtt_t <0,	24h, 6,	0, 38h,	0, 2>; 29
		breathAtt_t <7,	4, 10h,	0, 0, 0, 1>; 30
		breathAtt_t <6,	4, 10h,	0, 0, 0, 1>; 31
		breathAtt_t <5,	4, 10h,	0, 0, 0, 1>; 32
		breathAtt_t <0,	14h, 2,	0, 38h,	0, 10h>; 33
		breathAtt_t <0,	0Ch, 4,	0, 38h,	0C0h, 2>; 34
		db    0
weaponDamageList	anotherBreathAtt_t <0, 1, 25h, 2, 1,	2>; 0
		anotherBreathAtt_t <0, 1, 24h, 2, 1, 2>; 1
		anotherBreathAtt_t <0, 1, 22h, 2, 1, 3>; 2
		anotherBreathAtt_t <0, 1, 26h, 2, 1, 3>; 3
		anotherBreathAtt_t <0, 1, 23h, 2, 1, 3>; 4
		anotherBreathAtt_t <0, 1, 27h, 2, 1, 4>; 5
		anotherBreathAtt_t <0, 1, 28h, 2, 1, 4>; 6
		anotherBreathAtt_t <0, 1, 28h, 2, 1, 5>; 7
		anotherBreathAtt_t <0, 1, 2Bh, 2, 1, 4>; 8
		anotherBreathAtt_t <0, 1, 2Fh, 2, 1, 6>; 9
		anotherBreathAtt_t <0, 1, 37h, 2, 1, 9>; 10
		anotherBreathAtt_t <0, 1, 33h, 2, 2, 7>; 11
		anotherBreathAtt_t <0, 1, 2Fh, 2, 4, 8>; 12
		anotherBreathAtt_t <0, 1, 2Fh, 2, 8, 9>; 13
		anotherBreathAtt_t <0, 1, 2Fh, 2, 2, 7>; 14
		anotherBreathAtt_t <0, 1, 33h, 2, 2, 7>; 15
		anotherBreathAtt_t <0, 1, 38h, 2, 8, 5>; 16
		anotherBreathAtt_t 2 dup(<0, 80h, 38h, 2, 4,	6>); 17
		anotherBreathAtt_t <0, 1, 38h, 2, 8, 6>; 19
		anotherBreathAtt_t <0, 1, 38h, 42h, 8, 9>	; 20
		anotherBreathAtt_t <7, 1, 20h, 2, 1, 3>; 21
		anotherBreathAtt_t <0, 20h, 2Fh, 2, 10h, 8>	; 22
		anotherBreathAtt_t <0, 80h, 29h, 42h, 1, 3>	; 23
		anotherBreathAtt_t <0, 10h, 37h, 42h, 1, 4>	; 24
		anotherBreathAtt_t <0, 80h, 2Fh, 42h, 2, 6>	; 25
		anotherBreathAtt_t <0, 80h, 2Fh, 42h, 6, 6>	; 26
		anotherBreathAtt_t <0, 80h, 2Fh, 42h, 8, 5>	; 27
		anotherBreathAtt_t <7, 8, 2Fh, 42h, 10h, 6>	; 28
		anotherBreathAtt_t <0, 0, 31h, 42h, 0Ah, 7>	; 29
		anotherBreathAtt_t <0, 20h, 2Fh, 42h, 20h, 7>; 30
		anotherBreathAtt_t <0, 1, 25h, 2, 1, 2>; 0

byte_48382	db 6, 15h, 16h, 23h, 24h, 27h, 2Ah, 2Bh; 0
		db 35h,	3Ah, 48h, 5Ch, 60h, 65h, 6Bh, 77h; 8
		db 7Ch,	81h, 86h, 8Bh, 9Fh, 0D0h, 0F4h,	1Eh; 16
		db 47h,	53h, 57h, 5Bh, 0BAh, 0DEh; 24
		db 0F8h, 85h
		db    0
figurineItemNo	db 27, 38	       ; 0
		db 56, 61		; 2
		db 77, 98		; 4
		db 99, 190		; 6
		db 204,	0		; 8
byte_483AC	db 0Dh, 0Eh		   ; 0
		db 0Fh,	1		; 2
		db 10h,	11h		; 4
		db 12h,	13h		; 6
		db 14h,	0		; 8
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
lightDistList	db 3			;0 splf_mageflame
		db 4			;1 splf_lesserrev
		db 5			;2 splf_greaterrev
		db 5			;3 splf_cateyes
		db 2			;4
		db 2			;5

; This is a holdover from previous games. A value of 0xFF indicates
; that secret doors are visible.
lightDetectList	db 0			;0 splf_mageflame
		db 0FFh			;1 splf_lesserrev
		db 0FFh			;2 splf_greaterrev
		db 0			;3 splf_cateyes
		db 0			;4
		db 0			;5

lightDurList	db 4			;0 splf_mageflame
		db 0Ch			;1 splf_lesserrev
		db 10h			;2 splf_greaterrev
		db 0FFh			;3 splf_cateyes
		db 4
		db 8			;0
classSavingBonus	db 0, 0Ah, 0Ah, 5	   ; 0
		db 5, 0, 0, 5		; 4
		db 0, 0, 11h, 11h	; 8
		db 16h,	0		; 12
word_484CC	dw 1Eh
		db  1Eh
		db    0
		db    7
		db    0
batchSpellList	db 0Bh
		db  21h	; !
		db  34h	; 4
		db  0Eh
		db    4
		db    0
		db  44h	; D
		db  0Fh
		db    0
		db 0D2h	; Ò
unk_484DC	db  73h ; s
		db    0
geoSpMasks	geomanSp_t <3, 20h>	   ; 0
		geomanSp_t <4, 40h>	; 1
		geomanSp_t <3, 4>	; 2
		geomanSp_t <3, 2>	; 3
geoSpList	dd spGeo_removeTrap	; 0 ;	0: Earth Ward. Remove all traps	from level
		dd dun_revealSpSquare	; 1 ; 1: Sanctuary. Reveal all mage regeneration squares
		dd dun_revealSpSquare	; 2 ; 2: Succor	Song. Reveal party heal	squares
		dd dun_revealSpSquare	; 3 ; 3: Roscoe's Alert. Reveal all anti-magic squares
		dd dun_revealSpSquare	; 4 ; 4: Earth song. Reveal all	drain HP squares
		dd spGeo_revealSquare	; 5 ; 5:
spellFuncList	dd sp_lightSpell	      ;	0
		dd sp_damageSpell	; 1
		dd sp_trapZap		; 2
		dd sp_freezeFoes	; 3
		dd sp_compassSpell	; 4
		dd sp_healSpell		; 5
		dd sp_lightSpell	; 6
		dd sp_levitation	; 7
		dd sp_damageSpell	; 8
		dd sp_summonSpell	; 9
		dd sp_healSpell		; 10
		dd sp_lightSpell	; 11
		dd sp_damageSpell	; 12
		dd sp_healSpell		; 13
		dd sp_levitation	; 14
		dd sp_healSpell		; 15
		dd sp_teleport		; 16
		dd sp_farFoes		; 17
		dd sp_summonSpell	; 18
		dd sp_vorpalPlating	; 19
		dd sp_healSpell		; 20
		dd sp_scrySight		; 21
		dd sp_damageSpell	; 22
		dd sp_vorpalPlating	; 23
		dd sp_areaEnchant	; 24
		dd sp_shieldSpell	; 25
		dd sp_strengthBonus	; 26
		dd sp_damageSpell	; 27
		dd sp_damageSpell	; 28
		dd sp_damageSpell	; 29
		dd sp_antiMagic		; 30
		dd sp_strengthBonus	; 31
		dd sp_phaseDoor		; 32
		dd sp_shieldSpell	; 33
		dd sp_healSpell		; 34
		dd sp_damageSpell	; 35
		dd sp_damageSpell	; 36
		dd sp_healSpell		; 37
		dd sp_damageSpell	; 38
		dd sp_acBonus		; 39
		dd sp_areaEnchant	; 40
		dd sp_disbelieve	; 41
		dd sp_summonSpell	; 42
		dd sp_wordOfFear	; 43
		dd sp_summonSpell	; 44
		dd sp_acBonus		; 45
		dd sp_areaEnchant	; 46
		dd sp_lightSpell	; 47
		dd sp_summonSpell	; 48
		dd sp_disbelieve	; 49
		dd sp_damageSpell	; 50
		dd sp_summonSpell	; 51
		dd sp_areaEnchant	; 52
		dd sp_damageSpell	; 53
		dd sp_summonSpell	; 54
		dd sp_damageSpell	; 55
		dd sp_disbelieve	; 56
		dd sp_summonSpell	; 57
		dd sp_damageSpell	; 58
		dd sp_summonSpell	; 59
		dd sp_damageSpell	; 60
		dd sp_damageSpell	; 61
		dd sp_healSpell		; 62
		dd sp_summonSpell	; 63
		dd sp_possessChar	; 64
		dd sp_spellbind		; 65
		dd sp_damageSpell	; 66
		dd sp_summonSpell	; 67
		dd sp_healSpell		; 68
		dd sp_damageSpell	; 69
		dd sp_damageSpell	; 70
		dd sp_haltFoe		; 71
		dd sp_meleeMen		; 72
		dd sp_batchspell	; 73
		dd sp_camaraderie	; 74
		dd sp_damageSpell	; 75
		dd sp_healSpell		; 76
		dd sp_summonSpell	; 77
		dd sp_damageSpell	; 78
		dd sp_healSpell		; 79
		dd printSpellFizzled	; 80
		dd printSpellFizzled	; 81
		dd sp_damageSpell	; 82
		dd sp_damageSpell	; 83
		dd printSpellFizzled	; 84
		dd printSpellFizzled	; 85
		dd sp_damageSpell	; 86
		dd sp_damageSpell	; 87
		dd printSpellFizzled	; 88
		dd printSpellFizzled	; 89
		dd sp_luckSpell		; 90
		dd sp_damageSpell	; 91
		dd printSpellFizzled	; 92
		dd printSpellFizzled	; 93
		dd sp_identifySpell	; 94
		dd sp_healSpell		; 95
		dd printSpellFizzled	; 96
		dd printSpellFizzled	; 97
		dd sp_batchspell	; 98
		dd sp_batchspell	; 99
		dd printSpellFizzled	; 100
		dd printSpellFizzled	; 101
		dd sp_shieldSpell	; 102
		dd sp_damageSpell	; 103
		dd printSpellFizzled	; 104
		dd printSpellFizzled	; 105
		dd sp_damageSpell	; 106
		dd sp_geomancerSpell	; 107
		dd sp_geomancerSpell	; 108
		dd sp_damageSpell	; 109
		dd sp_summonSpell	; 110
		dd sp_phaseDoor		; 111
		dd sp_damageSpell	; 112
		dd sp_geomancerSpell	; 113
		dd sp_geomancerSpell	; 114
		dd sp_farFoes		; 115
		dd sp_geomancerSpell	; 116
		dd sp_damageSpell	; 117
		dd sp_geomancerSpell	; 118
		dd sp_damageSpell	; 119
		dd sp_damageSpell	; 120
		dd sp_earthMaw		; 121
		dd printNoEffect	; 122
		dd sp_divineIntervention; 123
		dd sp_damageSpell	; 124
		dd printNoEffect	; 125
		dd _sp_useLightObj	; 126
		dd _sp_useLightObj	; 127
		dd _sp_useAcorn		; 128
		dd _sp_useWineskin	; 129
		dd printCantFindUse	; 130
		dd _sp_useWeapon	; 131
		dd _sp_useFigurine	; 132
		dd _sp_useWeapon	; 133
		dd _sp_reenergizeMage	; 134
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
summonData      db 'Wol/f\ves',0,0,0,0,0,0,0; _name
summonHpDice    db 0A1h                 ; [0].hpDice
                dw 0Ah                  ; [0].hpBase
                db 11h                  ; [0].distance
                db 8Ch                  ; [0].packedGenAc
                db 0                    ; [0].groupSize
                db 0F0h                 ; [0].attackType._type
                db 23h                  ; [0].attackType.damage
                db 0F0h                 ; [0].attackType._type
                db 23h                  ; [0].attackType.damage
                db 0F0h                 ; [0].attackType._type
                db 23h                  ; [0].attackType.damage
                db 0F0h                 ; [0].attackType._type
                db 23h                  ; [0].attackType.damage
                db 0                    ; [0].breathFlag
                db 0                    ; [0].breathRange
                db 4                    ; [0].picIndex
                db 64h                  ; [0].rewardLo
                db 0                    ; [0].rewardMid
                db 0                    ; [0].rewardHi
                db 43h                  ; [0].flags
                db 12h                  ; [0].breathSaveLo
                db 19h                  ; [0].breathSaveHi
                db 37h                  ; [0].oppPriorityLo
                db 41h                  ; [0].oppPriorityHi
                db 0                    ; [0].strongElement
                db 0                    ; [0].weakElement
                db 8                    ; [0].repelFlags
                db 0Fh                  ; [0].toHitLo
                db 19h                  ; [0].toHitHi
                db 17h                  ; [0].spellSaveLo
                db 1Ch                  ; [0].spellSaveHi
                db 'Slayer/\s',0,0,0,0,0,0,0; _name
                db 81h                  ; [1].hpDice
                dw 40h                  ; [1].hpBase
                db 11h                  ; [1].distance
                db 17h                  ; [1].packedGenAc
                db 0                    ; [1].groupSize
                db 0F7h                 ; [1].attackType._type
                db 81h                  ; [1].attackType.damage
                db 0F7h                 ; [1].attackType._type
                db 81h                  ; [1].attackType.damage
                db 0F7h                 ; [1].attackType._type
                db 81h                  ; [1].attackType.damage
                db 0F7h                 ; [1].attackType._type
                db 81h                  ; [1].attackType.damage
                db 0                    ; [1].breathFlag
                db 0                    ; [1].breathRange
                db 21h                  ; [1].picIndex
                db 64h                  ; [1].rewardLo
                db 0                    ; [1].rewardMid
                db 0                    ; [1].rewardHi
                db 80h                  ; [1].flags
                db 12h                  ; [1].breathSaveLo
                db 19h                  ; [1].breathSaveHi
                db 37h                  ; [1].oppPriorityLo
                db 3Dh                  ; [1].oppPriorityHi
                db 8                    ; [1].strongElement
                db 0                    ; [1].weakElement
                db 4                    ; [1].repelFlags
                db 0Fh                  ; [1].toHitLo
                db 19h                  ; [1].toHitHi
                db 19h                  ; [1].spellSaveLo
                db 23h                  ; [1].spellSaveHi
                db 'Wind Warrior/\s',0  ; _name
                db 81h                  ; [2].hpDice
                dw 14h                  ; [2].hpBase
                db 11h                  ; [2].distance
                db 17h                  ; [2].packedGenAc
                db 0                    ; [2].groupSize
                db 0F0h                 ; [2].attackType._type
                db 62h                  ; [2].attackType.damage
                db 0F0h                 ; [2].attackType._type
                db 62h                  ; [2].attackType.damage
                db 0F0h                 ; [2].attackType._type
                db 62h                  ; [2].attackType.damage
                db 0F0h                 ; [2].attackType._type
                db 62h                  ; [2].attackType.damage
                db 0                    ; [2].breathFlag
                db 0                    ; [2].breathRange
                db 14h                  ; [2].picIndex
                db 64h                  ; [2].rewardLo
                db 0                    ; [2].rewardMid
                db 0                    ; [2].rewardHi
                db 94h                  ; [2].flags
                db 12h                  ; [2].breathSaveLo
                db 19h                  ; [2].breathSaveHi
                db 37h                  ; [2].oppPriorityLo
                db 3Dh                  ; [2].oppPriorityHi
                db 0                    ; [2].strongElement
                db 0                    ; [2].weakElement
                db 0                    ; [2].repelFlags
                db 0Fh                  ; [2].toHitLo
                db 19h                  ; [2].toHitHi
                db 19h                  ; [2].spellSaveLo
                db 23h                  ; [2].spellSaveHi
                db 'Wind Ogre/\s',0,0,0,0; _name
                db 0A1h                 ; [3].hpDice
                dw 0Ah                  ; [3].hpBase
                db 11h                  ; [3].distance
                db 97h                  ; [3].packedGenAc
                db 0                    ; [3].groupSize
                db 0F0h                 ; [3].attackType._type
                db 64h                  ; [3].attackType.damage
                db 0F0h                 ; [3].attackType._type
                db 64h                  ; [3].attackType.damage
                db 0FFh                 ; [3].attackType._type
                db 0                    ; [3].attackType.damage
                db 0FFh                 ; [3].attackType._type
                db 0                    ; [3].attackType.damage
                db 0                    ; [3].breathFlag
                db 0                    ; [3].breathRange
                db 33h                  ; [3].picIndex
                db 64h                  ; [3].rewardLo
                db 0                    ; [3].rewardMid
                db 0                    ; [3].rewardHi
                db 95h                  ; [3].flags
                db 12h                  ; [3].breathSaveLo
                db 19h                  ; [3].breathSaveHi
                db 37h                  ; [3].oppPriorityLo
                db 3Dh                  ; [3].oppPriorityHi
                db 0                    ; [3].strongElement
                db 0                    ; [3].weakElement
                db 0                    ; [3].repelFlags
                db 0Fh                  ; [3].toHitLo
                db 19h                  ; [3].toHitHi
                db 19h                  ; [3].spellSaveLo
                db 23h                  ; [3].spellSaveHi
                db 'Wind Dragon/\s',0,0 ; _name
                db 0A2h                 ; [4].hpDice
                dw 28h                  ; [4].hpBase
                db 11h                  ; [4].distance
                db 99h                  ; [4].packedGenAc
                db 0                    ; [4].groupSize
                db 80h                  ; [4].attackType._type
                db 69h                  ; [4].attackType.damage
                db 80h                  ; [4].attackType._type
                db 69h                  ; [4].attackType.damage
                db 0F0h                 ; [4].attackType._type
                db 69h                  ; [4].attackType.damage
                db 80h                  ; [4].attackType._type
                db 44h                  ; [4].attackType.damage
                db 0                    ; [4].breathFlag
                db 3                    ; [4].breathRange
                db 3Dh                  ; [4].picIndex
                db 64h                  ; [4].rewardLo
                db 0                    ; [4].rewardMid
                db 0                    ; [4].rewardHi
                db 0D2h                 ; [4].flags
                db 13h                  ; [4].breathSaveLo
                db 1Eh                  ; [4].breathSaveHi
                db 28h                  ; [4].oppPriorityLo
                db 46h                  ; [4].oppPriorityHi
                db 80h                  ; [4].strongElement
                db 10h                  ; [4].weakElement
                db 1                    ; [4].repelFlags
                db 14h                  ; [4].toHitLo
                db 1Eh                  ; [4].toHitHi
                db 0Ah                  ; [4].spellSaveLo
                db 64h                  ; [4].spellSaveHi
                db 'Wind Giant/\s',0,0,0; _name
                db 0A3h                 ; [5].hpDice
                dw 0Fh                  ; [5].hpBase
                db 11h                  ; [5].distance
                db 19h                  ; [5].packedGenAc
                db 0                    ; [5].groupSize
                db 80h                  ; [5].attackType._type
                db 6Bh                  ; [5].attackType.damage
                db 0F0h                 ; [5].attackType._type
                db 6Bh                  ; [5].attackType.damage
                db 0F0h                 ; [5].attackType._type
                db 6Bh                  ; [5].attackType.damage
                db 23h                  ; [5].attackType._type
                db 32h                  ; [5].attackType.damage
                db 2                    ; [5].breathFlag
                db 4                    ; [5].breathRange
                db 33h                  ; [5].picIndex
                db 64h                  ; [5].rewardLo
                db 0                    ; [5].rewardMid
                db 0                    ; [5].rewardHi
                db 0D5h                 ; [5].flags
                db 15h                  ; [5].breathSaveLo
                db 20h                  ; [5].breathSaveHi
                db 1Eh                  ; [5].oppPriorityLo
                db 3Ch                  ; [5].oppPriorityHi
                db 0                    ; [5].strongElement
                db 0                    ; [5].weakElement
                db 0                    ; [5].repelFlags
                db 19h                  ; [5].toHitLo
                db 23h                  ; [5].toHitHi
                db 0Ah                  ; [5].spellSaveLo
                db 1Eh                  ; [5].spellSaveHi
                db 'Wind Her/o\oes',0,0 ; _name
                db 0A4h                 ; [6].hpDice
                dw 14h                  ; [6].hpBase
                db 11h                  ; [6].distance
                db 1Bh                  ; [6].packedGenAc
                db 20h                  ; [6].groupSize
                db 0F0h                 ; [6].attackType._type
                db 6Ch                  ; [6].attackType.damage
                db 0F0h                 ; [6].attackType._type
                db 6Ch                  ; [6].attackType.damage
                db 0F0h                 ; [6].attackType._type
                db 8Ch                  ; [6].attackType.damage
                db 0F0h                 ; [6].attackType._type
                db 6Ch                  ; [6].attackType.damage
                db 0                    ; [6].breathFlag
                db 0                    ; [6].breathRange
                db 0Ah                  ; [6].picIndex
                db 64h                  ; [6].rewardLo
                db 0                    ; [6].rewardMid
                db 0                    ; [6].rewardHi
                db 94h                  ; [6].flags
                db 16h                  ; [6].breathSaveLo
                db 21h                  ; [6].breathSaveHi
                db 2Ah                  ; [6].oppPriorityLo
                db 48h                  ; [6].oppPriorityHi
                db 0                    ; [6].strongElement
                db 0                    ; [6].weakElement
                db 0                    ; [6].repelFlags
                db 19h                  ; [6].toHitLo
                db 23h                  ; [6].toHitHi
                db 0Ah                  ; [6].spellSaveLo
                db 64h                  ; [6].spellSaveHi
                db 'Fire Elemental/',0  ; _name
                db 81h                  ; [7].hpDice
                dw 0Ah                  ; [7].hpBase
                db 11h                  ; [7].distance
                db 97h                  ; [7].packedGenAc
                db 0                    ; [7].groupSize
                db 0F0h                 ; [7].attackType._type
                db 64h                  ; [7].attackType.damage
                db 0F0h                 ; [7].attackType._type
                db 64h                  ; [7].attackType.damage
                db 0F0h                 ; [7].attackType._type
                db 64h                  ; [7].attackType.damage
                db 0F0h                 ; [7].attackType._type
                db 64h                  ; [7].attackType.damage
                db 0                    ; [7].breathFlag
                db 0                    ; [7].breathRange
                db 5                    ; [7].picIndex
                db 64h                  ; [7].rewardLo
                db 0                    ; [7].rewardMid
                db 0                    ; [7].rewardHi
                db 85h                  ; [7].flags
                db 12h                  ; [7].breathSaveLo
                db 19h                  ; [7].breathSaveHi
                db 37h                  ; [7].oppPriorityLo
                db 3Dh                  ; [7].oppPriorityHi
                db 80h                  ; [7].strongElement
                db 10h                  ; [7].weakElement
                db 0                    ; [7].repelFlags
                db 0Fh                  ; [7].toHitLo
                db 19h                  ; [7].toHitHi
                db 19h                  ; [7].spellSaveLo
                db 23h                  ; [7].spellSaveHi
                db 'Demon/\s',0,0,0,0,0,0,0,0; _name
                db 0A2h                 ; [8].hpDice
                dw 0Ch                  ; [8].hpBase
                db 11h                  ; [8].distance
                db 94h                  ; [8].packedGenAc
                db 0                    ; [8].groupSize
                db 80h                  ; [8].attackType._type
                db 44h                  ; [8].attackType.damage
                db 80h                  ; [8].attackType._type
                db 44h                  ; [8].attackType.damage
                db 0F0h                 ; [8].attackType._type
                db 64h                  ; [8].attackType.damage
                db 0F0h                 ; [8].attackType._type
                db 64h                  ; [8].attackType.damage
                db 0                    ; [8].breathFlag
                db 4                    ; [8].breathRange
                db 17h                  ; [8].picIndex
                db 64h                  ; [8].rewardLo
                db 0                    ; [8].rewardMid
                db 0                    ; [8].rewardHi
                db 80h                  ; [8].flags
                db 12h                  ; [8].breathSaveLo
                db 19h                  ; [8].breathSaveHi
                db 37h                  ; [8].oppPriorityLo
                db 3Dh                  ; [8].oppPriorityHi
                db 0                    ; [8].strongElement
                db 20h                  ; [8].weakElement
                db 40h                  ; [8].repelFlags
                db 0Fh                  ; [8].toHitLo
                db 19h                  ; [8].toHitHi
                db 19h                  ; [8].spellSaveLo
                db 23h                  ; [8].spellSaveHi
                db 'Herb/\s',0,0,0,0,0,0,0,0,0; _name
                db 0E0h                 ; [9].hpDice
                dw 28h                  ; [9].hpBase
                db 11h                  ; [9].distance
                db 16h                  ; [9].packedGenAc
                db 0                    ; [9].groupSize
                db 0F0h                 ; [9].attackType._type
                db 69h                  ; [9].attackType.damage
                db 0F0h                 ; [9].attackType._type
                db 69h                  ; [9].attackType.damage
                db 0F0h                 ; [9].attackType._type
                db 69h                  ; [9].attackType.damage
                db 42h                  ; [9].attackType._type
                db 20h                  ; [9].attackType.damage
                db 0                    ; [9].breathFlag
                db 0                    ; [9].breathRange
                db 5                    ; [9].picIndex
                db 64h                  ; [9].rewardLo
                db 0                    ; [9].rewardMid
                db 0                    ; [9].rewardHi
                db 82h                  ; [9].flags
                db 13h                  ; [9].breathSaveLo
                db 1Eh                  ; [9].breathSaveHi
                db 28h                  ; [9].oppPriorityLo
                db 46h                  ; [9].oppPriorityHi
                db 0                    ; [9].strongElement
                db 0                    ; [9].weakElement
                db 0                    ; [9].repelFlags
                db 14h                  ; [9].toHitLo
                db 1Eh                  ; [9].toHitHi
                db 0Ah                  ; [9].spellSaveLo
                db 64h                  ; [9].spellSaveHi
                db 'Greater Demon',0,0,0; _name
                db 0E1h                 ; [10].hpDice
                dw 0Ah                  ; [10].hpBase
                db 11h                  ; [10].distance
                db 9Ch                  ; [10].packedGenAc
                db 0                    ; [10].groupSize
                db 0F0h                 ; [10].attackType._type
                db 6Ch                  ; [10].attackType.damage
                db 0F0h                 ; [10].attackType._type
                db 6Ch                  ; [10].attackType.damage
                db 80h                  ; [10].attackType._type
                db 69h                  ; [10].attackType.damage
                db 80h                  ; [10].attackType._type
                db 69h                  ; [10].attackType.damage
                db 2                    ; [10].breathFlag
                db 5                    ; [10].breathRange
                db 5                    ; [10].picIndex
                db 64h                  ; [10].rewardLo
                db 0                    ; [10].rewardMid
                db 0                    ; [10].rewardHi
                db 0C5h                 ; [10].flags
                db 16h                  ; [10].breathSaveLo
                db 23h                  ; [10].breathSaveHi
                db 20h                  ; [10].oppPriorityLo
                db 48h                  ; [10].oppPriorityHi
                db 0                    ; [10].strongElement
                db 20h                  ; [10].weakElement
                db 40h                  ; [10].repelFlags
                db 19h                  ; [10].toHitLo
                db 25h                  ; [10].toHitHi
                db 0Fh                  ; [10].spellSaveLo
                db 64h                  ; [10].spellSaveHi
                db 'Kringle Bro',27h,0,0,0,0; _name
                db 0E1h                 ; [11].hpDice
                dw 0C8h                 ; [11].hpBase
                db 11h                  ; [11].distance
                db 1Eh                  ; [11].packedGenAc
                db 0                    ; [11].groupSize
                db 0F0h                 ; [11].attackType._type
                db 73h                  ; [11].attackType.damage
                db 0F0h                 ; [11].attackType._type
                db 73h                  ; [11].attackType.damage
                db 0F0h                 ; [11].attackType._type
                db 73h                  ; [11].attackType.damage
                db 4Bh                  ; [11].attackType._type
                db 19h                  ; [11].attackType.damage
                db 0                    ; [11].breathFlag
                db 0                    ; [11].breathRange
                db 0Ah                  ; [11].picIndex
                db 64h                  ; [11].rewardLo
                db 0                    ; [11].rewardMid
                db 0                    ; [11].rewardHi
                db 85h                  ; [11].flags
                db 16h                  ; [11].breathSaveLo
                db 23h                  ; [11].breathSaveHi
                db 32h                  ; [11].oppPriorityLo
                db 50h                  ; [11].oppPriorityHi
                db 0                    ; [11].strongElement
                db 0                    ; [11].weakElement
                db 0                    ; [11].repelFlags
                db 23h                  ; [11].toHitLo
                db 2Dh                  ; [11].toHitHi
                db 0Ah                  ; [11].spellSaveLo
                db 64h                  ; [11].spellSaveHi
                db 'Earth Elemental',0  ; _name
                db 0E2h                 ; [12].hpDice
                dw 12Ch                 ; [12].hpBase
                db 11h                  ; [12].distance
                db 9Fh                  ; [12].packedGenAc
                db 0                    ; [12].groupSize
                db 0F0h                 ; [12].attackType._type
                db 8Eh                  ; [12].attackType.damage
                db 0F0h                 ; [12].attackType._type
                db 8Eh                  ; [12].attackType.damage
                db 0F0h                 ; [12].attackType._type
                db 8Eh                  ; [12].attackType.damage
                db 6Eh                  ; [12].attackType._type
                db 32h                  ; [12].attackType.damage
                db 0                    ; [12].breathFlag
                db 0                    ; [12].breathRange
                db 5                    ; [12].picIndex
                db 64h                  ; [12].rewardLo
                db 0                    ; [12].rewardMid
                db 0                    ; [12].rewardHi
                db 0C5h                 ; [12].flags
                db 16h                  ; [12].breathSaveLo
                db 23h                  ; [12].breathSaveHi
                db 32h                  ; [12].oppPriorityLo
                db 50h                  ; [12].oppPriorityHi
                db 0                    ; [12].strongElement
                db 0                    ; [12].weakElement
                db 0                    ; [12].repelFlags
                db 23h                  ; [12].toHitLo
                db 2Dh                  ; [12].toHitHi
                db 0Ah                  ; [12].spellSaveLo
                db 64h                  ; [12].spellSaveHi
                db 'Frost Giant/\s',0,0 ; _name
                db 0A1h                 ; [13].hpDice
                dw 14h                  ; [13].hpBase
                db 11h                  ; [13].distance
                db 17h                  ; [13].packedGenAc
                db 0                    ; [13].groupSize
                db 0F0h                 ; [13].attackType._type
                db 64h                  ; [13].attackType.damage
                db 0F0h                 ; [13].attackType._type
                db 64h                  ; [13].attackType.damage
                db 0F0h                 ; [13].attackType._type
                db 64h                  ; [13].attackType.damage
                db 0FFh                 ; [13].attackType._type
                db 0                    ; [13].attackType.damage
                db 0                    ; [13].breathFlag
                db 0                    ; [13].breathRange
                db 33h                  ; [13].picIndex
                db 64h                  ; [13].rewardLo
                db 0                    ; [13].rewardMid
                db 0                    ; [13].rewardHi
                db 0C5h                 ; [13].flags
                db 12h                  ; [13].breathSaveLo
                db 19h                  ; [13].breathSaveHi
                db 37h                  ; [13].oppPriorityLo
                db 3Dh                  ; [13].oppPriorityHi
                db 10h                  ; [13].strongElement
                db 80h                  ; [13].weakElement
                db 0                    ; [13].repelFlags
                db 0Fh                  ; [13].toHitLo
                db 19h                  ; [13].toHitHi
                db 19h                  ; [13].spellSaveLo
                db 23h                  ; [13].spellSaveHi
                db 'Molten M/an\en',0,0 ; _name
                db 0C0h                 ; [14].hpDice
                dw 32h                  ; [14].hpBase
                db 11h                  ; [14].distance
                db 94h                  ; [14].packedGenAc
                db 0                    ; [14].groupSize
                db 80h                  ; [14].attackType._type
                db 62h                  ; [14].attackType.damage
                db 80h                  ; [14].attackType._type
                db 62h                  ; [14].attackType.damage
                db 0F0h                 ; [14].attackType._type
                db 64h                  ; [14].attackType.damage
                db 0F0h                 ; [14].attackType._type
                db 64h                  ; [14].attackType.damage
                db 4                    ; [14].breathFlag
                db 4                    ; [14].breathRange
                db 5                    ; [14].picIndex
                db 64h                  ; [14].rewardLo
                db 0                    ; [14].rewardMid
                db 0                    ; [14].rewardHi
                db 80h                  ; [14].flags
                db 13h                  ; [14].breathSaveLo
                db 1Ah                  ; [14].breathSaveHi
                db 38h                  ; [14].oppPriorityLo
                db 3Eh                  ; [14].oppPriorityHi
                db 80h                  ; [14].strongElement
                db 10h                  ; [14].weakElement
                db 0                    ; [14].repelFlags
                db 10h                  ; [14].toHitLo
                db 1Ah                  ; [14].toHitHi
                db 19h                  ; [14].spellSaveLo
                db 24h                  ; [14].spellSaveHi
                db 'Bulldozer/\s',0,0,0,0; _name
                db 0E0h                 ; [15].hpDice
                dw 30h                  ; [15].hpBase
                db 1                    ; [15].distance
                db 98h                  ; [15].packedGenAc
                db 0                    ; [15].groupSize
                db 0F0h                 ; [15].attackType._type
                db 69h                  ; [15].attackType.damage
                db 0F0h                 ; [15].attackType._type
                db 69h                  ; [15].attackType.damage
                db 0F0h                 ; [15].attackType._type
                db 6Bh                  ; [15].attackType.damage
                db 0F0h                 ; [15].attackType._type
                db 6Bh                  ; [15].attackType.damage
                db 0                    ; [15].breathFlag
                db 0                    ; [15].breathRange
                db 0Bh                  ; [15].picIndex
                db 64h                  ; [15].rewardLo
                db 0                    ; [15].rewardMid
                db 0                    ; [15].rewardHi
                db 0C0h                 ; [15].flags
                db 13h                  ; [15].breathSaveLo
                db 1Eh                  ; [15].breathSaveHi
                db 28h                  ; [15].oppPriorityLo
                db 46h                  ; [15].oppPriorityHi
                db 0                    ; [15].strongElement
                db 0                    ; [15].weakElement
                db 0                    ; [15].repelFlags
                db 14h                  ; [15].toHitLo
                db 1Eh                  ; [15].toHitHi
                db 0Ah                  ; [15].spellSaveLo
                db 64h                  ; [15].spellSaveHi
                db 'Vanquisher/\s',0,0,0; _name
                db 0E1h                 ; [16].hpDice
                dw 40h                  ; [16].hpBase
                db 11h                  ; [16].distance
                db 9Dh                  ; [16].packedGenAc
                db 0                    ; [16].groupSize
                db 32h                  ; [16].attackType._type
                db 1Eh                  ; [16].attackType.damage
                db 3Dh                  ; [16].attackType._type
                db 1Eh                  ; [16].attackType.damage
                db 32h                  ; [16].attackType._type
                db 1Eh                  ; [16].attackType.damage
                db 42h                  ; [16].attackType._type
                db 1Eh                  ; [16].attackType.damage
                db 0                    ; [16].breathFlag
                db 0                    ; [16].breathRange
                db 36h                  ; [16].picIndex
                db 64h                  ; [16].rewardLo
                db 0                    ; [16].rewardMid
                db 0                    ; [16].rewardHi
                db 82h                  ; [16].flags
                db 16h                  ; [16].breathSaveLo
                db 23h                  ; [16].breathSaveHi
                db 32h                  ; [16].oppPriorityLo
                db 50h                  ; [16].oppPriorityHi
                db 0                    ; [16].strongElement
                db 0                    ; [16].weakElement
                db 0                    ; [16].repelFlags
                db 23h                  ; [16].toHitLo
                db 2Dh                  ; [16].toHitHi
                db 0Ah                  ; [16].spellSaveLo
                db 64h                  ; [16].spellSaveHi
                db 'Blast Dragon/\s',0  ; _name
                db 0E3h                 ; [17].hpDice
                dw 20h                  ; [17].hpBase
                db 11h                  ; [17].distance
                db 9Dh                  ; [17].packedGenAc
                db 0                    ; [17].groupSize
                db 0F0h                 ; [17].attackType._type
                db 6Eh                  ; [17].attackType.damage
                db 80h                  ; [17].attackType._type
                db 6Eh                  ; [17].attackType.damage
                db 80h                  ; [17].attackType._type
                db 6Eh                  ; [17].attackType.damage
                db 0F0h                 ; [17].attackType._type
                db 6Eh                  ; [17].attackType.damage
                db 2                    ; [17].breathFlag
                db 5                    ; [17].breathRange
                db 3Dh                  ; [17].picIndex
                db 64h                  ; [17].rewardLo
                db 0                    ; [17].rewardMid
                db 0                    ; [17].rewardHi
                db 0C2h                 ; [17].flags
                db 17h                  ; [17].breathSaveLo
                db 24h                  ; [17].breathSaveHi
                db 34h                  ; [17].oppPriorityLo
                db 52h                  ; [17].oppPriorityHi
                db 80h                  ; [17].strongElement
                db 0                    ; [17].weakElement
                db 1                    ; [17].repelFlags
                db 24h                  ; [17].toHitLo
                db 2Eh                  ; [17].toHitHi
                db 0Ah                  ; [17].spellSaveLo
                db 64h                  ; [17].spellSaveHi
                db 'One-eyed Angra',0,0 ; _name
                db 0E2h                 ; [18].hpDice
                dw 82h                  ; [18].hpBase
                db 11h                  ; [18].distance
                db 0DAh                 ; [18].packedGenAc
                db 0                    ; [18].groupSize
                db 48h                  ; [18].attackType._type
                db 20h                  ; [18].attackType.damage
                db 4Bh                  ; [18].attackType._type
                db 23h                  ; [18].attackType.damage
                db 4Bh                  ; [18].attackType._type
                db 23h                  ; [18].attackType.damage
                db 2Dh                  ; [18].attackType._type
                db 23h                  ; [18].attackType.damage
                db 0                    ; [18].breathFlag
                db 0                    ; [18].breathRange
                db 36h                  ; [18].picIndex
                db 64h                  ; [18].rewardLo
                db 0                    ; [18].rewardMid
                db 0                    ; [18].rewardHi
                db 80h                  ; [18].flags
                db 19h                  ; [18].breathSaveLo
                db 28h                  ; [18].breathSaveHi
                db 28h                  ; [18].oppPriorityLo
                db 46h                  ; [18].oppPriorityHi
                db 0                    ; [18].strongElement
                db 0                    ; [18].weakElement
                db 0                    ; [18].repelFlags
                db 22h                  ; [18].toHitLo
                db 2Eh                  ; [18].toHitHi
                db 0Ah                  ; [18].spellSaveLo
                db 5Ah                  ; [18].spellSaveHi
                db 'Black Death',0,0,0,0,0; _name
                db 0E9h                 ; [19].hpDice
                dw 64h                  ; [19].hpBase
                db 11h                  ; [19].distance
                db 0A0h                 ; [19].packedGenAc
                db 20h                  ; [19].groupSize
                db 0F7h                 ; [19].attackType._type
                db 0C9h                 ; [19].attackType.damage
                db 0F7h                 ; [19].attackType._type
                db 0E9h                 ; [19].attackType.damage
                db 5Bh                  ; [19].attackType._type
                db 28h                  ; [19].attackType.damage
                db 63h                  ; [19].attackType._type
                db 0                    ; [19].attackType.damage
                db 0                    ; [19].breathFlag
                db 0                    ; [19].breathRange
                db 24h                  ; [19].picIndex
                db 64h                  ; [19].rewardLo
                db 0                    ; [19].rewardMid
                db 0                    ; [19].rewardHi
                db 80h                  ; [19].flags
                db 1Eh                  ; [19].breathSaveLo
                db 28h                  ; [19].breathSaveHi
                db 3Ch                  ; [19].oppPriorityLo
                db 5Ah                  ; [19].oppPriorityHi
                db 0                    ; [19].strongElement
                db 20h                  ; [19].weakElement
                db 0                    ; [19].repelFlags
                db 28h                  ; [19].toHitLo
                db 2Fh                  ; [19].toHitHi
                db 14h                  ; [19].spellSaveLo
                db 64h                  ; [19].spellSaveHi
                db 'Familiar/\s',0,0,0,0,0; _name
                db 49h                  ; [20].hpDice
                dw 32h                  ; [20].hpBase
                db 11h                  ; [20].distance
                db 99h                  ; [20].packedGenAc
                db 0                    ; [20].groupSize
                db 4Ch                  ; [20].attackType._type
                db 32h                  ; [20].attackType.damage
                db 22h                  ; [20].attackType._type
                db 32h                  ; [20].attackType.damage
                db 2Dh                  ; [20].attackType._type
                db 32h                  ; [20].attackType.damage
                db 5Ah                  ; [20].attackType._type
                db 32h                  ; [20].attackType.damage
                db 0                    ; [20].breathFlag
                db 0                    ; [20].breathRange
                db 12h                  ; [20].picIndex
                db 64h                  ; [20].rewardLo
                db 0                    ; [20].rewardMid
                db 0                    ; [20].rewardHi
                db 3                    ; [20].flags
                db 1Eh                  ; [20].breathSaveLo
                db 28h                  ; [20].breathSaveHi
                db 0Ah                  ; [20].oppPriorityLo
                db 14h                  ; [20].oppPriorityHi
                db 4                    ; [20].strongElement
                db 0                    ; [20].weakElement
                db 0                    ; [20].repelFlags
                db 0Ah                  ; [20].toHitLo
                db 0Ah                  ; [20].toHitHi
                db 0Ah                  ; [20].spellSaveLo
                db 0Ah                  ; [20].spellSaveHi
                db 'Black Slayer/\s',0  ; _name
                db 0                    ; [21].hpDice
                dw 0FA0h                ; [21].hpBase
                db 12h                  ; [21].distance
                db 0A7h                 ; [21].packedGenAc
                db 23h                  ; [21].groupSize
                db 0F7h                 ; [21].attackType._type
                db 64h                  ; [21].attackType.damage
                db 0F7h                 ; [21].attackType._type
                db 84h                  ; [21].attackType.damage
                db 0F7h                 ; [21].attackType._type
                db 85h                  ; [21].attackType.damage
                db 0F7h                 ; [21].attackType._type
                db 65h                  ; [21].attackType.damage
                db 0                    ; [21].breathFlag
                db 0                    ; [21].breathRange
                db 41h                  ; [21].picIndex
                db 50h                  ; [21].rewardLo
                db 0C3h                 ; [21].rewardMid
                db 0                    ; [21].rewardHi
                db 80h                  ; [21].flags
                db 28h                  ; [21].breathSaveLo
                db 32h                  ; [21].breathSaveHi
                db 5Ah                  ; [21].oppPriorityLo
                db 78h                  ; [21].oppPriorityHi
                db 0                    ; [21].strongElement
                db 20h                  ; [21].weakElement
                db 10h                  ; [21].repelFlags
                db 28h                  ; [21].toHitLo
                db 3Ch                  ; [21].toHitHi
                db 28h                  ; [21].spellSaveLo
                db 46h                  ; [21].spellSaveHi
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
s_commaAnd		db ', and ',0
align 2
s_commaSpace	db ', ',0
align 2
s_period		db '.',0
aYouHaveFailedT	db 'You have failed to recite the proper alignment pattern!',0
g_cpLocationFour	dd aArefolia, aAcorns ; 0
		dd aArrowsOfLife, aCrystalKey; 2
		dd aCrownOfTruth, aStrifespear; 4
		dd aRainbowRose, aCrystalLens; 6
		dd aSmokeyLens, aBlackLens;	8
		dd aShadowDoor, aShadowLock; 10
		dd aWineskin,	aNightspear; 12
		dd aHammerOfWrath, aWandOfPower; 14
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
sq_north	dw 0
sq_east		dw 0
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
