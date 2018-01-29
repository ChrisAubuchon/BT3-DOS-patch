; enum raceList
race_human  = 0
race_elf  = 1
race_dwarf  = 2
race_hobbit  = 3
race_halfElf  =	4
race_halfOrc  =	5
race_gnome  = 6

; enum classEnum
class_warrior  = 0
class_wizard  =	1
class_sorcerer	= 2
class_conjurer	= 3
class_magician	= 4
class_rogue  = 5
class_bard  = 6
class_paladin  = 7
class_hunter  =	8
class_monk  = 9
class_archmage	= 10
class_chronomancer  = 11
class_geomancer	 = 12
class_monster  = 13
class_illusion	= 14

; enum b3_constants
maxDrunkLevel  = 0Ch
inventorySize  = 24h
monStruSize  = 30h
charSize  = 78h

; enum disbelieveFlags
disb_disbelieve = 1
disb_nohelp = 2
disb_nosummon = 40h
disb_disruptill = 80h

; enum spLightFlags
splf_mageflame = 0
splf_lesserrev = 1
splf_greaterrev = 2
splf_cateyes = 3

; enum iconList
icon_light  = 0
icon_compass  =	1
icon_areaEnchant  = 2
icon_shield  = 3
icon_levitation	 = 4

; enum itemFlags
itemFlag_equipped  = 1
itemFlag_unequipable  =	2
itemFlag_identified  = 80h

; enum itemType
itType_item  = 0
itType_weapon  = 1
itType_shield  = 2
itType_armor  =	3
itType_helm  = 4
itType_gloves  = 5
itType_instrument  = 6
itType_figurine	 = 7
itType_ring  = 8
itType_wand  = 9
itType_item0  =	10
itType_bow  = 11
itType_quiver  = 12
itType_container  = 13
itType_armor0  = 14

; enum dosKeys
dosKeys_Enter	= 0Dh
dosKeys_ESC  = 1Bh
dosKeys_F1  = 3B00h
dosKeys_F2  = 3C00h
dosKeys_F3  = 3D00h
dosKeys_F4  = 3E00h
dosKeys_F5  = 3F00h
dosKeys_F6  = 4000h
dosKeys_F7  = 4100h
dosKeys_home		= 4700h
dosKeys_upArrow	 = 4800h
dosKeys_pageUp		= 4900h
dosKeys_leftArrow  = 4B00h
dosKeys_rightArrow  = 4D00h
dosKeys_end		= 4F00h
dosKeys_downArrow  = 5000h
dosKeys_pageDown	= 5100h

; enum directionEnum
dir_north  = 0
dir_east  = 1
dir_south  = 2
dir_west  = 3

; enum itemEffects
itemEff_none  =	0
itemEff_regenHP	 = 1
itemEff_anotherSpptRegen  = 2
itemEff_noSpin	= 3
itemEff_halfSpptUsage  = 4
itemEff_freeSinging  = 5
itemEff_alwaysHide  = 6
itemEff_alwaysRunAway  = 7
itemEff_calmMonster  = 9
itemEff_breathDefense  = 10
itemEff_quaterSpptUse  = 12
itemEff_regenSppt  = 13
itemEff_resurrect  = 14

; enum charStatus (bitfield)
stat_poisoned  = 1
stat_old  = 2
stat_dead  = 4
stat_stoned  = 8
stat_paralyzed	= 10h
stat_possessed	= 20h
stat_nuts  = 40h
stat_unknown  =	80h

; enum questFlag
quest_valarianActive  =	0
quest_valarianDone  = 1
quest_lanatirActive  = 2
quest_lanatirDone  = 3
quest_alliriaActive  = 4
quest_alliriaDone  = 5
quest_ferofistActive  =	6
quest_ferofistDone  = 7
quest_sceaduActive  = 8
quest_sceaduDone  = 9
quest_werraActive  = 0Ah
quest_werraDone	 = 0Bh
quest_tarjanActive  = 0Ch
quest_tarjanDone  = 0Dh
quest_brilhastActive  =	0Eh
quest_brilhastDone  = 0Fh

; enum breathFlags (bitfield)
breath_isBreath	 = 1
breath_oneGroup	 = 40h
breath_allFoes	= 80h

; enum monsterFlags (bitfield)
mon_attackStr  = 0Fh
mon_noSummon  =	20h

; enum specialAttack_t
speAtt_poison  = 1
speAtt_possess	= 5
speAtt_stoning	= 6
speAtt_criticalHit  = 7

; enum targetEnum
target_partyMember  = 1
target_monGroup	 = 2
target_monAndParty  = 3

; enum songEnum
song_sirRobin  = 0
song_safety  = 1
song_sanctuary	= 2
song_bringaround  = 3
song_duotime  =	4
song_watchwood	= 5
song_overture  = 6
song_shield  = 7

; enum levelFile
lev_monsterl  =	1
lev_monsterh  =	2

; enum healFlags
heal_fleshrestore = 1
heal_stoned = 2
heal_possession = 3
heal_resurrect = 4
heal_old = 5
heal_healall = 6
heal_allFlag = 80h
heal_fullHeal = 0FDh
heal_quickfix = 0FEh
heal_levelMul = 0FFh

; enum spellCastFlags
spellcast_spellOnly = 8
spellcast_combatOnly = 10h

; enum miniMapBitmasks
minimap_topWall		= 0
minimap_rightWall	= 1
minimap_bottomWall	= 2
minimap_leftWall	= 3
minimap_dot		= 0Ch
minimap_X		= 0Dh
minimap_undiscovered	= 0Eh

; enum specialCharacters
ch_InsertCursor		= 60h
ch_OverwriteCursor	= 5Fh

; enum gameStates
gameState_inCamp	= 1
gameState_inWilderness	= 2
gameState_inDungeon	= 4
gameState_partyDied	= 5
