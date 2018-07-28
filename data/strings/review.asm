; Attribute strings for increase message
;
s_reviewStrength	db 'strength.',0
s_reviewIntelligence	db 'intelligence.',0
s_reviewDexterity	db 'dexterity.',0
s_reviewConstitution	db 'constitution.',0
s_reviewLuck		db 'luck.',0

g_reviewAttributeList	dd s_reviewStrength		;   0
			dd s_reviewIntelligence		;   1
			dd s_reviewDexterity		;   2
			dd s_reviewConstitution		;   3
			dd s_reviewLuck			;   4

; Class strings for changing classes
;
s_reviewWizard		db 'Wizard',0Ah,0
s_reviewSorcerer	db 'Sorcerer',0Ah,0
s_reviewConjurer	db 'Conjurer',0Ah,0
s_reviewMagician	db 'Magician',0Ah,0
s_reviewArchmage	db 'Archmage',0Ah,0
s_reviewChronomancer	db 'Chronomancer',0Ah,0

g_reviewClassList	dd s_reviewWizard		;   0
			dd s_reviewSorcerer		;   1
			dd s_reviewConjurer		;   2
			dd s_reviewMagician		;   3
			dd s_reviewArchmage		;   4
			dd s_reviewChronomancer		;   5

; Spell for sale strings
;
s_reviewSellGilles	db 'Gilles Gills for ',0
s_reviewSellDivine	db 'Divine Intervention for ',0
s_reviewSellNuke	db 'Gotterdamurung for ',0

g_spellsForSaleList	dd s_reviewSellGilles		;   0
			dd s_reviewSellDivine		;   1
			dd s_reviewSellNuke		;   2

s_hallOfWizards	db 'Thou art in the hall of wizards. Would thou like...',0Ah,0Ah
		db 'Advancement',0Ah
		db 'Spell Acquiring',0Ah
		db 'Buy a new spell',0Ah
		db 'Exit the hall',0
		db 0

s_cannotBeRaised		db ' cannot be raised levels.',0
s_eldersTeachLore		db 'The Elders teach you the lore.',0
s_buySpellPrompt		db 'Who seeks the special knowledge of the mystic arts?',0
s_thouMayLearn			db 'Thou may learn ',0
s_inGoldWhoWillPay		db ' in gold. Who will pay?',0

s_lastOfTheGuildElders	db 'The last of the guild elders is here. Would you like...',0Ah,0Ah
			db 'Advancement',0Ah
			db 'Spell Acquiring',0Ah
			db 'Class Change',0Ah
			db 'Talk to the elder',0Ah
			db 'Exit the guild',0

s_elderWeighsMerits		db 'The Guild elder prepares to weigh your merits.',0Ah,0Ah
				db 'Who shall be reviewed?',0

s_elderDeadCharacter		db '"Hmmm... Should I make you into a zombie perhaps?!?"',0
s_guildElderDeems		db 'The Guild elder deems that ',0
s_stillNeedeth			db ' still needeth ',0
s_experiencePoints		db ' experience points prior to advancement.',0
s_hathEarnedLevel		db ' hath earned a level of advancement...',0
s_plusOneTo			db '+1 to ',0
s_whoSeeksKnowledge		db 'Who seeks knowledge of the mystic arts?',0
s_learnedAllSpells		db 'Thou hath learned all the spells in thy art.',0
s_cannotAcquireNewSpells	db 'Thou cannot acquire new spells yet.',0
s_spellLevel			db ' spell level ',0
s_willCost			db ' will cost ',0
s_notEnoughGoldNl		db 'Not enough gold.',0Ah,0
s_elderTeachersLore		db 'The Elder teaches you the lore.',0
s_whichMageSeeksChange		db 'Which mage seeks to change classes?',0
s_cannotChangeClass		db 'Thou cannot change class.',0
s_mustKnowThreeSpellLevels	db 'You must know at least 3 spell levels in your present art first.',0
s_doesntQualifyForNewClass	db 'Thee doesn',27h,'t qualify for any new class.',0
s_newClassPrompt		db 0Ah,'Which class shall thee become?',0

s_convertChronomancerPrompt	db 'Thee understands the sacrifice, dost thou not? '
				db 'Thee will be stripped of all thy spells and '
				db 'knowledge thereof. Thee will be more powerful '
				db 'than ever before, but more vulnerable as well.',0
s_dostThouAccept		db 'Dost thou accept this sacrifice?',0Ah,0Ah,0

s_arboriaSpellText	db '"Know this, the spell to enter Arboria is invoked by '
			db 'uttering ARBO and the spell to return is ENIK. Be wary, '
			db 'for the spells only work in one place in the land."',0
s_arboriaSpellLocation	db '"There is a large grove of trees just south of Skara Brae. '
			db 'The spell will work there."',0

s_beginsNewProfession		db 'Now thou begins thy new profession.',0
s_desertedReviewBoard		db 'The old review board is deserted.',0
s_thouArtNotASpellcaster	db 'Thou art not a spell caster!',0
s_whoSpeaksToElder		db 'Who wishs to speak with the elder?',0

s_gelidiaSpellText	db '"Gelidia, the land of cold, is entered by uttering GELI '
			db 'and the spell to return is ECUL."',0
s_gelidiaSpellLocation	db 'To the north is Cold Peak, your passage to Gelidia is there.',0

s_lucenciaSpellText	db '"Lucencia is entered by uttering LUCE and the spell to '
			db 'return is ILEG."',0
s_lucenciaSpellLocation	db 'To the east is a crystal spring, your passage to Lucencia '
			db 'is there.',0

s_kinestiaSpellText	db '"Kinestia, the dimension of machines, is reached by casting '
			db 'KINE. OBRA will bring you back."',0
s_kinestiaSpellLocation	db '"To the south-west is an old mine, you may reach Kinestia '
			db 'from there."',0

s_tenebrosiaSpellText		db '"Tenebrosia can be reached by uttering OLUK and the spell '
				db 'to return is ECEA."',0
s_tenebrosiaSpellLocation	db '"To the southeast is Shadow Rock, your passage to '
				db 'Tenebrosia is there."',0

s_tarmitiaSpellText	db '"Tarmitia is entered by uttering AECE and the spell to '
			db 'return is KULO."',0
s_tarmitiaSpellLocation	db '"To the south is a vale, your passage to Tarmitia is there."',0

s_timeIsRunningOut	db '"Hurry! Time is running out!"',0
s_teachOnlyChronomancer	db '"I',27h,'ll teach only a Chronomancer the special magic that '
			db 'you need to journey on your quest."',0
s_seekOutBrilhasti	db '"Seek out Brilhasti ap Tarj!"',0

s_questAwardXp_1	db 'The old man awards each member 600000 experience points.',0
s_questAwardXp_2	db 'With a wave of his hand, the old man re-energizes all magic users.',0

s_questBrilhasti_1	db 'The old man in the Review Board scratches his head. "Yes, '
			db 'you are the prophesied ones, but you have come too early. '
			db 'No matter."',0
s_questBrilhasti_2	db '"Beneath Skara Brae you will find one of Tarjan',27h,'s '
			db 'devotees. Brilhasti ap Tarj is a foul Necromancer, and his '
			db 'life impedes my efforts to stave off disaster."',0
s_questBrilhasti_3	db '"You may enter the Catacombs under the Mad God',27h,'s '
			db 'Temple by uttering his master',27h,'s name... ',27h,'Tarjan"',0
s_questBrilhasti_4	db '"Destroy Brilhasti ap Tarj, then return to me for your '
			db 'true quest."',0

s_questValarian_1	db '"Welcome ye children of the prophecy. Upon your shoulders '
			db 'falls a great weight, for you must embark on what will be '
			db 'your greatest adventure ever."',0
s_questValarian_2	db '"That which has laid waste to Skara Brae is an ancient evil '
			db 'recently released. It threatens to destroy all reality and '
			db 'time as it has wrought havoc on Skara Brae."',0
s_questValarian_3	db '"If you cannot stop it, it will consume the universe. If you '
			db 'do stop it, you will be rewarded beyond all your dreams."',0
s_questValarian_4	db '"Prepare thyselves, and hasten to the place of trees, for it '
			db 'is most like the first dimension you must sojourn in to blunt '
			db 'the evil."',0
s_questValarian_5	db '"Aboria, the home of Valarian the bold, is reached through '
			db 'using powerful magic that only a Chronomancer can control."',0
s_questValarian_6	db '"Bring to me Valarian',27h,'s Bow and The Arrows of Life if '
			db 'Valarian will not return here with you."',0
s_questValarian_7	db '"Yes, and be on the lookout for an ally, for you are not the '
			db 'first I have sent on this quest. Though your paths are '
			db 'different, they may cross, and you will do well together."',0

s_questLanatir_1	db 'The old man takes the news of Valarian',27h,'s death hard, '
			db 'but he summons a smile to his lips and breathes deeply.',0
s_questLanatir_2	db '"You have done well, children, and I take well the news that '
			db 'Hawkslayer has survived this long. Now you are bound for a '
			db 'place far distant."',0
s_questLanatir_3	db '"It is the dimension of magic. It is known as Gelidia and if '
			db 'your Chronomancer is able, I will share the spells to get you '
			db 'there and back again."',0
s_questLanatir_4	db '"Bring Lanatir with you, or, if you cannot convince him to '
			db 'come, coax from him the Wand of Power and the Sphere of Lanatir."',0

s_questAlliria_1	db 'The old man appears visibly shaken by the news of '
			db 'Lanatir',27h,'s death. After a long silence he stares off '
			db 'into space and mumbles, "Is it to be that way then?"',0
s_questAlliria_2	db 'His eyes focus upon you again, and a grim look washes over '
			db 'his features. "Now you are bound for Lucencia."',0
s_questAlliria_3	db '"I dare not hope Alliria lives, so I want you to recover '
			db 'the Crown of Truth and the Belt of Alliria. Beware, for she '
			db 'had a jealous consort, and he will protect her as best he can."',0

s_questFerofist_1	db 'The old man',27h,'s look of grim determination withstands '
			db 'news of Alliria',27h,'s death, but the information saps some '
			db 'of his strength.',0
s_questFerofist_2	db '"Quickly then, my children, to distant Kinestia!"',0
s_questFerofist_3	db '"You must return here with The Hammer of Wrath and '
			db 'Ferofist',27h,'s Helm. I know Ferofist yet lives, but I '
			db 'cannot be sure of how long he will survive."',0
s_questFerofist_4	db '"Hurry, the pace quickens, and the outlook is horrible if '
			db 'you fail!"',0

s_questSceadu_1	db 'The old man',27h,'s eyes narrow as you tell of Ferofist',27h,'s end. '
		db '"An alliance with the dark one, did he say? It is well he realized '
		db 'his folly in the end."',0
s_questSceadu_2	db 'He pauses a second, and you see utter weariness send a tremor '
		db 'through him. "Now to Tenebrosia for all of you."',0
s_questSceadu_3	db '"Remember, in the land where night is day and day is night, '
		db 'nothing is as you know it to be. Paradox lives there - trust '
		db 'no one but yourselves."',0
s_questSceadu_4	db '"From there I require the Helm of Justice and Sceadu',27h,'s Cloak."',0

s_questWerra_1	db '"No!" the old man cries out, "not Sceadu as well. The dark one '
		db 'is utterly mad. Still," the old man smiles, "he burns the chaff '
		db 'while I sow the seed."',0
s_questWerra_2	db '"Off with you to Tarmitia, the land of unceasing warfare. A myriad '
		db 'of ages meld together there, and your success depends upon your '
		db 'ability to adapt."',0
s_questWerra_3	db '"Bring me Werra',27h,'s Shield and the Strifespear."',0
s_questWerra_4	db 'His eyes lose their focus. "It is almost done, the circle is almost '
		db 'joined."',0

s_questTarjan_1	db '"I know," the old man gurgles, "Werra lies dead." Blood bubbles '
		db 'up on his lips and joins the dark stains on the rest of his '
		db 'clothing. "I, too, have been slain by the Mad One."',0
s_questTarjan_2	db '"Gather up the prizes you have won, the special ones, those I '
		db 'requested. Hawkslayer has already ventured into Malefia, '
		db 'the land of EVIL."',0
s_questTarjan_3	db '"I have placed the prizes in the storage building near the '
		db 'entrance of Skara Brae."',0
s_questTarjan_4	db '"Get yourselves hence and help him. Destroy the Mad God Tarjan '
		db 'before he destroys all reality!!"',0
s_questTarjan_5	db 'With those final words, the old man slumps over, and his body '
		db 'dissolves into a mist that a slight breeze stirs and blows away.',0

s_reviewBoard	db 'Review Board',0
s_guild		db 'Guild',0
