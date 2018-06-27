divert(`-1')

# Game state values
define(`gameState_inCamp', `1')
define(`gameState_inWilderness', `2')
define(`gameState_inDungeon', `4')
define(`gameState_partyDied', `5')
define(`gameState_quit', `0FFh')

# Character races
define(`race_human', `0')
define(`race_elf', `1')
define(`race_dwarf', `2')
define(`race_hobbit', `3')
define(`race_halfElf', `4')
define(`race_halfOrc', `5')
define(`race_gnome', `6')

# Character classes
define(`class_warrior', `0')
define(`class_wizard', `1')
define(`class_sorcerer', `2')
define(`class_conjurer', `3')
define(`class_magician', `4')
define(`class_rogue', `5')
define(`class_bard', `6')
define(`class_paladin', `7')
define(`class_hunter', `8')
define(`class_monk', `9')
define(`class_archmage', `10')
define(`class_chronomancer', `11')
define(`class_geomancer', `12')
define(`class_monster', `13')
define(`class_illusion', `14')

# Misc constants
define(`maxDrunkLevel', `0Ch')
define(`inventorySize', `24h')
define(`monStruSize', `30h')
define(`charSize', `78h')
define(`c_spellCount', `7Eh')

# Character Status bit masks
define(`stat_poisoned', `1')
define(`stat_old', `2')
define(`stat_dead', `4')
define(`stat_stoned', `8')
define(`stat_paralyzed', `10h')
define(`stat_possessed', `20h')
define(`stat_nuts', `40h')
define(`stat_unknown', `80h')

# Special Attack values
define(`specialAttack_none', `0')
define(`specialAttack_poison', `1')
define(`specialAttack_levelDrain', `2')
define(`specialAttack_nutsify', `3')
define(`specialAttack_age', `4')
define(`specialAttack_possess', `5')
define(`specialAttack_stone', `6')
define(`specialAttack_critical', `7')
define(`specialAttack_unequip', `8')
define(`specialAttack_spptDrain', `9')

# Bigpic labels
define(`bigpic_maleWarrior', `33')
define(`bigpic_reviewBoard', `47')
define(`bigpic_temple', `49')
define(`bigpic_destroyedBuilding', `50')
define(`bigpic_treasure', `52')
define(`bigpic_chest', `53')
define(`bigpic_emptyBuilding', `69')
define(`bigpic_tavern', `83')

# Location numbers
define(`location_skara', `1')

# Tavern drinks
define(`tavern_ale', `0')
define(`tavern_beer', `1')
define(`tavern_mead', `2')
define(`tavern_foulSpirits', `3')
define(`tavern_gingerAle', `4')

# Disbelieve flags
define(`disb_disbelieve', `1')
define(`disb_nohelp', `2')
define(`disb_nosummon', `40h')
define(`disb_disruptill', `80h')

# Light spell flags
define(`splf_mageflame', `0')
define(`splf_lesserrev', `1')
define(`splf_greaterrev', `2')
define(`splf_cateyes', `3')

# Icon values
define(`icon_light', `0')
define(`icon_compass', `1')
define(`icon_areaEnchant', `2')
define(`icon_shield', `3')
define(`icon_levitation', `4')

# Inventory item flags
define(`itemFlag_equipped', `1')
define(`itemFlag_unequipable', `2')
define(`itemFlag_unidentified', `80h')

# Item types
define(`itType_item', `0')
define(`itType_weapon', `1')
define(`itType_shield', `2')
define(`itType_armor', `3')
define(`itType_helm', `4')
define(`itType_gloves', `5')
define(`itType_instrument', `6')
define(`itType_figurine', `7')
define(`itType_ring', `8')
define(`itType_wand', `9')
define(`itType_item0', `10')
define(`itType_bow', `11')
define(`itType_quiver', `12')
define(`itType_container', `13')
define(`itType_armor0', `14')

# DOS Key values
define(`dosKeys_Enter', `0Dh')
define(`dosKeys_ESC', `1Bh')
define(`dosKeys_F1', `3B00h')
define(`dosKeys_F2', `3C00h')
define(`dosKeys_F3', `3D00h')
define(`dosKeys_F4', `3E00h')
define(`dosKeys_F5', `3F00h')
define(`dosKeys_F6', `4000h')
define(`dosKeys_F7', `4100h')
define(`dosKeys_home', ` 4700h')
define(`dosKeys_upArrow', `4800h')
define(`dosKeys_pageUp', `4900h')
define(`dosKeys_leftArrow', `4B00h')
define(`dosKeys_center', `4C00h')
define(`dosKeys_rightArrow', `4D00h')
define(`dosKeys_end', `4F00h')
define(`dosKeys_downArrow', `5000h')
define(`dosKeys_pageDown', `5100h')

# Direction values
define(`dir_north', `0')
define(`dir_east', `1')
define(`dir_south', `2')
define(`dir_west', `3')

# Item effects
define(`itemEff_none', `0')
define(`itemEff_regenHP', `1')
define(`itemEff_anotherSpptRegen', `2')
define(`itemEff_noSpin', `3')
define(`itemEff_halfSpptUsage', `4')
define(`itemEff_freeSinging', `5')
define(`itemEff_alwaysHide', `6')
define(`itemEff_alwaysRunAway', `7')
define(`itemEff_calmMonster', `9')
define(`itemEff_breathDefense', `10')
define(`itemEff_quaterSpptUse', `12')
define(`itemEff_regenSppt', `13')
define(`itemEff_resurrect', `14')

# Quest flags
define(`quest_valarianActive', `0')
define(`quest_valarianDone', `1')
define(`quest_lanatirActive', `2')
define(`quest_lanatirDone', `3')
define(`quest_alliriaActive', `4')
define(`quest_alliriaDone', `5')
define(`quest_ferofistActive', `6')
define(`quest_ferofistDone', `7')
define(`quest_sceaduActive', `8')
define(`quest_sceaduDone', `9')
define(`quest_werraActive', `0Ah')
define(`quest_werraDone', `0Bh')
define(`quest_tarjanActive', `0Ch')
define(`quest_tarjanDone', `0Dh')
define(`quest_brilhastActive', `0Eh')
define(`quest_brilhastDone', `0Fh')

# Breath weapon flags
define(`breath_isBreath', `1')
define(`breath_oneGroup', `40h')
define(`breath_allFoes', `80h')

# Monster flags
define(`mon_attackStr', `0Fh')
define(`mon_noSummon', `20h')
define(`mon_isIllusion', `10h')

# Target values
define(`target_partyMember', `1')
define(`target_monGroup', `2')
define(`target_monAndParty', `3')

# Songs
define(`song_sirRobin', `0')
define(`song_safety', `1')
define(`song_sanctuary', `2')
define(`song_bringaround', `3')
define(`song_duotime', `4')
define(`song_watchwood', `5')
define(`song_overture', `6')
define(`song_shield', `7')

# Level file numbers
define(`lev_monsterl', `1')
define(`lev_monsterh', `2')

# Heal spell flags
define(`heal_fleshrestore', `1')
define(`heal_stoned', `2')
define(`heal_possession', `3')
define(`heal_resurrect', `4')
define(`heal_old', `5')
define(`heal_healall', `6')
define(`heal_allFlag', `80h')
define(`heal_fullHeal', `0FDh')
define(`heal_quickfix', `0FEh')
define(`heal_levelMul', `0FFh')

# Spell cast flags
define(`spellcast_spellOnly', `8')
define(`spellcast_combatOnly', `10h')

# Minimap bitmasks
define(`minimap_topWall', `0')
define(`minimap_rightWall', `1')
define(`minimap_bottomWall', `2')
define(`minimap_leftWall', `3')
define(`minimap_dot', `0Ch')
define(`minimap_X', `0Dh')
define(`minimap_undiscovered', `0Eh')

# Special Characters
define(`ch_InsertCursor', `60h')
define(`ch_OverwriteCursor', `5Fh')

# Items
define(`item_harmonicGem', `195')

# Character actions
define(`charAction_melee', `1')
define(`charAction_defend', `2')
define(`charAction_partyAttack', `3')
define(`charAction_cast', `4')
define(`charAction_use', `5')
define(`charAction_hide', `6')
define(`charAction_sing', `7')
define(`charAction_possessed', `8')

divert`'dnl
