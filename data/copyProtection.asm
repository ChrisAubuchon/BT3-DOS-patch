s_cpAcorns		db 'Acorns',0
s_cpArrowsOfLife	db 'Arrows of Life',0
s_cpMalefia		db 'Malefia',0
s_cpValarian		db 'Valarian',0
s_cpLanatir		db 'Lanatir',0
s_cpFerofist		db 'Ferofist',0
s_cpSceadu		db 'Sceadu',0
s_cpWerra		db 'Werra',0
s_cpTarjan		db 'Tarjan',0
s_cpSkaraBrae		db 'Skara Brae',0
s_unterbrae		db 'UnterBrae',0
s_cpArboria		db 'Arboria',0
s_cpGelidia		db 'Gelidia',0
s_cpLucencia		db 'Lucencia',0
s_cpKinestia		db 'Kinestia',0
s_cpTenebrosia		db 'Tenebrosia',0
s_cpTarmitia		db 'Tarmitia',0
s_cpCieraBrannia	db 'Ciera Brannia',0
s_cpCelariaBree		db 'Celaria Bree',0
s_cpBlackScar		db 'Black Scar',0
s_cpDarkCopse		db 'Dark Copse',0
s_cpNowhere		db 'Nowhere',0
s_cpFesteringPit	db 'Festering Pit',0
s_cpSacredGrove		db 'Sacred Grove',0
s_cpIceKeep		db 'Ice Keep',0
s_cpShadowCanyon	db 'Shadow Canyon',0
s_cpTarQuarry		db 'Tar Quarry',0
s_cpColdPeak		db 'Cold Peak',0
s_cpCrystalSpring	db 'Crystal Spring',0
s_cpOldDwarfMine	db 'Old Dwarf Mine',0
s_cpShadowRock		db 'Shadow Rock',0
s_cpSulphurSprings	db 'Sulphur Springs',0
s_cpWarriorsVale	db 'Warriors Vale',0
s_cpBrilhasti		db 'Brilhasti',0
s_urmech		db 'Urmech',0
s_cpTslotha		db 'Tslotha',0
s_cpCyanis		db 'Cyanis',0
s_cpTheOldMan		db 'The Old Man',0
s_cpHawkslayer		db 'Hawkslayer',0
s_cpVioletMountain	db 'Violet Mountains',0
s_cpCrystalPalace	db 'Crystal Palace',0
s_cpCatacombs		db 'Catacombs',0
s_cpTunnels		db 'Tunnels',0
s_cpWorkshop		db 'Workshop',0
s_cpWizardSGuild	db 'Wizard',27h,'s Guild',0
s_copyProtectIntro	db 'To traverse time and space, you must first recite '
			db 'the alignment value of ',0
s_commaCapitalAnd	db ', and ',0
s_commaSpace		db ', ',0
s_period		db '.',0

g_cpLocationFour	dd s_itemArefolia		;   0
			dd s_cpAcorns			;   1
			dd s_cpArrowsOfLife		;   2
			dd s_itemCrystalKey		;   3
			dd s_itemCrownOfTruth		;   4
			dd s_itemStrifespear		;   5
			dd s_itemRainbowRose		;   6
			dd s_itemCrystalLens		;   7
			dd s_itemSmokeyLens		;   8
			dd s_itemBlackLens		;   9
			dd s_itemShadowDoor		;  10
			dd s_itemShadowLock		;  11
			dd s_itemWineskin		;  12
			dd s_itemNightspear		;  13
			dd s_itemHammerOfWrath		;  14
			dd s_itemWandOfPower		;  15

g_cpLocationOne	dd s_cpMalefia		;   0
		dd s_cpValarian		;   1
		dd s_cpLanatir		;   2
		dd s_alliria		;   3
		dd s_cpFerofist		;   4
		dd s_cpSceadu		;   5
		dd s_cpWerra		;   6
		dd s_cpTarjan		;   7
		dd s_cpSkaraBrae	;   8
		dd s_unterbrae		;   9
		dd s_cpArboria		;  10
		dd s_cpGelidia		;  11
		dd s_cpLucencia		;  12
		dd s_cpKinestia		;  13
		dd s_cpTenebrosia	;  14
		dd s_cpTarmitia		;  15

g_cpLocationTwo	dd s_cpCieraBrannia		;   0
		dd s_cpCelariaBree		;   1
		dd s_cpBlackScar		;   2
		dd s_cpDarkCopse		;   3
		dd s_cpNowhere			;   4
		dd s_cpFesteringPit		;   5
		dd s_cpSacredGrove		;   6
		dd s_cpIceKeep			;   7
		dd s_cpShadowCanyon		;   8
		dd s_cpTarQuarry		;   9
		dd s_cpColdPeak			;  10
		dd s_cpCrystalSpring		;  11
		dd s_cpOldDwarfMine		;  12
		dd s_cpShadowRock		;  13
		dd s_cpSulphurSprings		;  14
		dd s_cpWarriorsVale		;  15

g_cpLocationThree	dd s_cpBrilhasti		;   0
			dd s_urmech			;   1
			dd s_cpTslotha			;   2
			dd s_cpCyanis			;   3
			dd s_cpTheOldMan		;   4
			dd s_cpHawkslayer		;   5
			dd s_scrapwood			;   6
			dd s_bardsHall			;   7
			dd s_staggerInn			;   8
			dd s_hicHaven			;   9
			dd s_cpVioletMountain		;  10
			dd s_cpCrystalPalace		;  11
			dd s_cpCatacombs		;  12
			dd s_cpTunnels			;  13
			dd s_cpWorkshop			;  14
			dd s_cpWizardSGuild		;  15

byte_4CA18	db 0		;   0
		db 4		;   1
		db 18		;   2
		db 23		;   3
		db 37		;   4
		db 49		;   5
		db 51		;   6
		db 70		;   7
		db 84		;   8
		db 98		;   9
		db 102		;  10
		db 112		;  11
		db 131		;  12
		db 133		;  13
		db 145		;  14
		db 151		;  15

byte_4CA28	db  13			; 0
		db   7			; 1
		db   0			; 2
		db   2			; 3
		db   6			; 4
		db   9			; 5
		db  15			; 6
		db   3			; 7
		db   5			; 8
		db  12			; 9
		db  10			; 10
		db   1			; 11
		db  14			; 12
		db   8			; 13
		db   4			; 14
		db  11			; 15

g_copyProtectionLengthMask	db    1		;   0
				db  0Fh		;   1
				db  7Fh		;   2
				db 0FFh		;   3
				db    0		;   4
				db    0		;   5
				db    0		;   6
