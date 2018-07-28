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

# Gender values
define(`gender_male', `0')
define(`gender_female', `1')
define(`gender_neuter', `2')
define(`gender_unique', `3')

# Misc constants
define(`maxDrunkLevel', `0Ch')
define(`inventorySize', `24h')
define(`monStruSize', `30h')
define(`charSize', `78h')
define(`charMaxAttribute', `30')
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
define(`bigpic_camp', `0')
define(`bigpic_wolf', `4')
define(`bigpic_elemental', `5')
define(`bigpic_hero', `10')
define(`bigpic_bulldozer', `11')
define(`bigpic_familiar', `18')
define(`bigpic_zephyr', `20')
define(`bigpic_demon', `23')
define(`bigpic_maleWarrior', `33')
define(`bigpic_giant', `35')
define(`bigpic_blackDeath', `36')
define(`bigpic_reviewBoard', `47')
define(`bigpic_femaleWarrior', `48')
define(`bigpic_temple', `49')
define(`bigpic_destroyedBuilding', `50')
define(`bigpic_ogre', `51')
define(`bigpic_treasure', `52')
define(`bigpic_chest', `53')
define(`bigpic_maleWizard', `54')
define(`bigpic_partyDied', `57')
define(`bigpic_dragon', `61')
define(`bigpic_blackSlayer', `65')
define(`bigpic_emptyBuilding', `69')
define(`bigpic_deadOldMan', `74')
define(`bigpic_femaleWizard', `79')
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
define(`spellcast_targetParty', `1')
define(`spellcast_targetMon', `2')
define(`spellcast_untargetted', `4')
define(`spellcast_spellOnly', `8')
define(`spellcast_noncombatCastable', `10h')
define(`spellcast_partyOnly', `20h')

# Minimap character index
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
define(`item_nothing', `0')
define(`item_torch', `1')
define(`item_lamp', `2')
define(`item_broadsword', `3')
define(`item_shortsword', `4')
define(`item_dagger', `5')
define(`item_waraxe', `6')
define(`item_halbard', `7')
define(`item_longBow', `8')
define(`item_staff', `9')
define(`item_buckler', `10')
define(`item_towerShield', `11')
define(`item_leatherArmor', `12')
define(`item_chainMail', `13')
define(`item_scaleArmor', `14')
define(`item_plateArmor', `15')
define(`item_robes', `16')
define(`item_helm', `17')
define(`item_leatherGloves', `18')
define(`item_gauntlets', `19')
define(`item_mandolin', `20')
define(`item_spear', `21')
define(`item_arrows', `22')
define(`item_mithrilSword', `23')
define(`item_mithrilShield', `24')
define(`item_mithrilChain', `25')
define(`item_mithrilScale', `26')
define(`item_giantFigurine', `27')
define(`item_mithrilBracers', `28')
define(`item_bardsword', `29')
define(`item_fireHorn', `30')
define(`item_litewand', `31')
define(`item_mithrilDagger', `32')
define(`item_mithrilHelm', `33')
define(`item_mithrilGloves', `34')
define(`item_mithrilAxe', `35')
define(`item_shuriken', `36')
define(`item_mithrilPlate', `37')
define(`item_moltenFigurine', `38')
define(`item_spellSpear', `39')
define(`item_shieldRing', `40')
define(`item_finsFlute', `41')
define(`item_kaelsAxe', `42')
define(`item_mithrilArrows', `43')
define(`item_dayblade', `44')
define(`item_shieldStaff', `45')
define(`item_elfCloak', `46')
define(`item_hawkblade', `47')
define(`item_adamantiumSword', `48')
define(`item_adamantiumShield', `49')
define(`item_adamantiumHelm', `50')
define(`item_adamantiumGloves', `51')
define(`item_pureblade', `52')
define(`item_boomerang', `53')
define(`item_alisCarpet', `54')
define(`item_luckshield', `55')
define(`item_dozerFigurine', `56')
define(`item_adamantiumChain', `57')
define(`item_deathStars', `58')
define(`item_adamantiumPlate', `59')
define(`item_adamantiumBracers', `60')
define(`item_slayerFigurine', `61')
define(`item_pureShield', `62')
define(`item_mageStaff', `63')
define(`item_warStaff', `64')
define(`item_thiefDagger', `65')
define(`item_soulMace', `66')
define(`item_ogrewand', `67')
define(`item_katosBracer', `68')
define(`item_sorcerstaff', `69')
define(`item_galtsFlute', `70')
define(`item_frostHorn', `71')
define(`item_agsArrows', `72')
define(`item_diamondShield', `73')
define(`item_bardBow', `74')
define(`item_diamondHelm', `75')
define(`item_elfBoots', `76')
define(`item_vanquisherFigurine', `77')
define(`item_conjurstaff', `78')
define(`item_staffOfLor', `79')
define(`item_flameSword', `80')
define(`item_powerstaff', `81')
define(`item_breathRing', `82')
define(`item_dragonShield', `83')
define(`item_diamondPlate', `84')
define(`item_wargloves', `85')
define(`item_wizhelm', `86')
define(`item_dragonWand', `87')
define(`item_deathring', `88')
define(`item_crystalSword', `89')
define(`item_speedboots', `90')
define(`item_flameHorn', `91')
define(`item_zenArrows', `92')
define(`item_deathdrum', `93')
define(`item_pipesOfPan', `94')
define(`item_powerRing', `95')
define(`item_songAxe', `96')
define(`item_trickBrick', `97')
define(`item_dragonFigurine', `98')
define(`item_mageFigurine', `99')
define(`item_trollRing', `100')
define(`item_aramsKnife', `101')
define(`item_angrasEye', `102')
define(`item_herbFigurine', `103')
define(`item_masterWand', `104')
define(`item_brothersFigurine', `105')
define(`item_dynamite', `106')
define(`item_thorsHammer', `107')
define(`item_stoneblade', `108')
define(`item_holyHandgrenade', `109')
define(`item_masterkey', `110')
define(`item_nospinRing', `111')
define(`item_crystalLens', `112')
define(`item_smokeyLens', `113')
define(`item_blackLens', `114')
define(`item_lanatirSphere', `115')
define(`item_wandOfPower', `116')
define(`item_acorn', `117')
define(`item_wineskin', `118')
define(`item_nightspear', `119')
define(`item_tslothaSHead', `120')
define(`item_tslothaSHeart', `121')
define(`item_arefolia', `122')
define(`item_valariansBow', `123')
define(`item_arrowsOfLife', `124')
define(`item_canteen', `125')
define(`item_titanPlate', `126')
define(`item_titanShield', `127')
define(`item_titanHelm', `128')
define(`item_fireSpear', `129')
define(`item_willowFlute', `130')
define(`item_firebrand', `131')
define(`item_holySword', `132')
define(`item_wandOfFury', `133')
define(`item_lightstar', `134')
define(`item_crownOfTruth', `135')
define(`item_beltOfAlliria', `136')
define(`item_crystalKey', `137')
define(`item_taoRing', `138')
define(`item_stealthArrows', `139')
define(`item_yellowStaff', `140')
define(`item_steadyEye', `141')
define(`item_divineHalbard', `142')
define(`item_incense', `143')
define(`item_iChing', `144')
define(`item_whiteRose', `145')
define(`item_blueRose', `146')
define(`item_redRose', `147')
define(`item_yellowRose', `148')
define(`item_rainbowRose', `149')
define(`item_magicTriangle', `150')
define(`item_hammerOfWrath', `152')
define(`item_ferofistsHelm', `153')
define(`item_helmOfJustice', `156')
define(`item_sceadusCloak', `157')
define(`item_shadelance', `158')
define(`item_blackArrows', `159')
define(`item_werrasShield', `160')
define(`item_strifespear', `161')
define(`item_sheetmusic', `162')
define(`item_rightKey', `163')
define(`item_leftKey', `164')
define(`item_lever', `165')
define(`item_nut', `166')
define(`item_bolt', `167')
define(`item_spanner', `168')
define(`item_shadowLock', `169')
define(`item_shadowDoor', `170')
define(`item_misericorde', `171')
define(`item_holyAvenger', `172')
define(`item_shadowshiv', `173')
define(`item_kalisGarrote', `174')
define(`item_flameKnife', `175')
define(`item_redsStiletto', `176')
define(`item_heartseeker', `177')
define(`item_diamondScale', `181')
define(`item_holyTnt', `182')
define(`item_eternalTorch', `183')
define(`item_osconSStaff', `184')
define(`item_angelSRing', `185')
define(`item_deathhorn', `186')
define(`item_staffOfMangar', `187')
define(`item_teslaRing', `188')
define(`item_diamondBracers', `189')
define(`item_deathFigurine', `190')
define(`item_thunderSword', `191')
define(`item_poisonDagger', `192')
define(`item_sparkBlade', `193')
define(`item_galvanicOboe', `194')
define(`item_harmonicGem', `195')
define(`item_tungShield', `196')
define(`item_tungPlate', `197')
define(`item_minstrelsGlove', `198')
define(`item_huntersCloak', `199')
define(`item_deathHammer', `200')
define(`item_bloodMeshRobe', `201')
define(`item_soothingBalm', `202')
define(`item_magesCloak', `203')
define(`item_familiarFigurine', `204')
define(`item_hourglass', `205')
define(`item_thievesHood', `206')
define(`item_surehandAmulet', `207')
define(`item_thievesDart', `208')
define(`item_shrillFlute', `209')
define(`item_angelSHarp', `210')
define(`item_theBook', `211')
define(`item_trothLance', `212')
define(`item_diamondSuit', `213')
define(`item_diamondFlail', `214')
define(`item_purpleHeart', `215')
define(`item_titanBracers', `216')
define(`item_eelskinTunic', `217')
define(`item_sorcererSHood', `218')
define(`item_diamondStaff', `219')
define(`item_crystalGem', `220')
define(`item_wandOfForce', `221')
define(`item_cliLyre', `222')
define(`item_youthPotion', `223')
define(`item_mithrilSuit', `240')
define(`item_titanSuit', `241')
define(`item_magesGlove', `242')
define(`item_flareCrystal', `243')
define(`item_holyMissile', `244')
define(`item_godsBlade', `245')
define(`item_hunterBlade', `246')
define(`item_staffOfGods', `247')
define(`item_hornOfGods', `248')

# Character actions
define(`charAction_melee', `1')
define(`charAction_defend', `2')
define(`charAction_partyAttack', `3')
define(`charAction_cast', `4')
define(`charAction_use', `5')
define(`charAction_hide', `6')
define(`charAction_sing', `7')
define(`charAction_possessed', `8')

# Character equip masks
define(`equip_warrior', `80h')
define(`equip_wizard', `40h')
define(`equip_sorcerer', `40h')
define(`equip_conjurer', `40h')
define(`equip_magician', `40h')
define(`equip_rogue', `10h')
define(`equip_bard', `8')
define(`equip_paladin', `4')
define(`equip_hunter', `2')
define(`equip_monk', `1')
define(`equip_archmage', `20h')
define(`equip_chronomancer', `60h')
define(`equip_geomancer', `0E0h')
define(`equip_monster', `0')
define(`equip_all', `0FFh')
define(`equip_none', `0')

# Dice indices
define(`dice_d2',   `0')
define(`dice_d4',   `1')
define(`dice_d8',   `2')
define(`dice_d16',  `3')
define(`dice_d32',  `4')
define(`dice_d64',  `5')
define(`dice_d128', `6')
define(`dice_d256', `7')

# Wineskin contents
define(`fluid_water', `0')
define(`fluid_spirits', `1')
define(`fluid_waterOfLife', `2')
define(`fluid_dragonBlood', `3')
define(`fluid_moltenTar', `4')

# Elements
define(`element_none', `0')
define(`element_phys', `1')
define(`element_magic', `4')
define(`element_death', `8')
define(`element_cold', `10h')
define(`element_holy', `20h')
define(`element_fire',	`80h')

# Monster type attackable
define(`mtype_none', `0')
define(`mtype_mage', `20h')
define(`mtype_demon', `40h')
define(`mtype_evil', `80h')

# Spells
define(`spell_mageFlame', `0')
define(`spell_kielsCompass', `4')
define(`spell_greaterRevelation', `11')
define(`spell_majorLevitation', `14')
define(`spell_regeneration', `15')
define(`spell_mysticalArmor', `33')
define(`spell_restoration', `34')
define(`spell_deathStrike', `35')
define(`spell_invisibility', `45')
define(`spell_mindBlade', `50')
define(`spell_sorcerorSight', `52')
define(`spell_flameColumn', `61')
define(`spell_soulWhip', `66')
define(`spell_beyondDeath', `68')
define(`spell_meleeMen', `72')
define(`spell_nightLance', `75')
define(`spell_healAll', `76')
define(`spell_mangarsMallet', `78')
define(`spell_witherfist', `82')
define(`spell_luckChant', `90')
define(`spell_farDeath', `91')
define(`spell_forceOfTarjan', `99')
define(`spell_earthElemental', `110')
define(`spell_sandstorm', `115')

# Monster attack values
define(`mattack_spell', `0')
define(`mattack_breathe', `80h')
define(`mattack_melee', `0F0h')
define(`mattack_none', `0FFh')

# Minimap flag values
define(`minimapFlag_discovered', `1')
define(`minimapFlag_undiscovered', `2')
define(`minimapFlag_special', `4')
define(`minimapFlag_visited', `8')

# Instrument types
define(`instrument_horn', `0')
define(`instrument_guitar', `1')
define(`instrument_flute', `2')
define(`instrument_drum', `3')

# Detect contstants
define(`detectByte_trap', `0')
define(`detectByte_stairs', `0')
define(`detectByte_special', `0')
define(`detectByte_spinner', `1')
define(`detectByte_antiMagic', `1')
define(`detectByte_something', `1')
define(`detectByte_odd', `1')
define(`detectByte_quiet', `1')
define(`detectByte_regenSppt', `1')

define(`detectMask_trap', `10h')
define(`detectMask_stairs', `1')
define(`detectMask_special', `4')
define(`detectMask_spinner', `1')
define(`detectMask_antiMagic', `2')
define(`detectMask_something', `4')
define(`detectMask_odd', `8')
define(`detectMask_quiet', `10h')
define(`detectMask_regenSppt', `20h')

define(`detectMessage_trap', `0')
define(`detectMessage_stairs', `1')
define(`detectMessage_special', `2')
define(`detectMessage_spinner', `3')
define(`detectMessage_antiMagic', `4')
define(`detectMessage_something', `5')
define(`detectMessage_odd', `6')
define(`detectMessage_quiet', `7')

# Dungeon level flags
define(`dunLevel_isOutdoors', `20h')
define(`dunLevel_noTeleport', `80h')
divert`'dnl
