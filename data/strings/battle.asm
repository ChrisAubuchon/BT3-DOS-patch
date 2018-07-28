; Various battle related strings

s_specialAttackKilling		db ', killing ',0
s_specialAttackPoisoning	db ', poisoning ',0
s_specialAttackDraining		db ', draining ',0
s_specialAttackCrazing		db ', crazing ',0
s_specialAttackWithering	db ', withering ',0
s_specialAttackPossessing 	db ', possessing ',0
s_specialAttackStoning		db ', stoning ',0
s_specialAttackCritical		db ', critically hitting ',0
s_specialAttackStealing		db ', stealing ',0
s_specialAttackPhazing		db ', phazing ',0

g_specialAttackStringList	dd s_specialAttackKilling		;   0
				dd s_specialAttackPoisoning		;   1
				dd s_specialAttackDraining		;   2
				dd s_specialAttackCrazing		;   3
				dd s_specialAttackWithering		;   4
				dd s_specialAttackPossessing		;   5
				dd s_specialAttackStoning		;   6
				dd s_specialAttackCritical		;   7
				dd s_specialAttackStealing		;   8
				dd s_specialAttackPhazing		;   9

; Battle cry strings
;
s_dissentionInYourRanks	db 'Dissention in your ranks...',0Ah,0Ah,0
s_willThereBeAnEnd	db '"Will there ever be an end to them?" you shout. You see ',0
s_enjoyYourNextLife	db '"Enjoy your next life!" you snarl. You see ',0
s_yourBattlecry	db 'Your battlecry is heard by all as you face ',0
s_yourOnslaught	db 'Your onslaught is greeted with laughter, you face ',0
s_notAgainYouMoan	db '"Not again!" you moan as you face ',0
s_gimmeABreak	db '"Gimme a break! Where do they come from?" You see ',0

g_battleCryList	dd s_dissentionInYourRanks	; 0
		dd s_willThereBeAnEnd		; 1
		dd s_enjoyYourNextLife		; 2
		dd s_yourBattlecry		; 3
		dd s_yourOnslaught		; 4
		dd s_notAgainYouMoan		; 5
		dd s_gimmeABreak		; 6

s_youStillFace		db 'You still face ',0
s_continueQuestion	db 'Do you wish to continue?',0Ah,0
s_butMisses		db ', but misses!',0Ah,0Ah,0
s_periodNlNl		db '.', 0Ah, 0Ah,0
s_exclBlankLine		db '!',0Ah, 0Ah,0
s_jumpsIntoShadows	db ' jumps into the shadows, ',0
s_andSucceeds		db 'and succeeds!',0Ah,0Ah,0
s_butIsDiscovered	db 'but is discovered!',0Ah,0Ah,0
s_summonsHelp		db ' summons help and ',0
s_noneAppears		db 'none appears...',0Ah,0Ah,0
s_anotherJoins		db 'another joins the fray!',0Ah,0Ah,0
s_the			db	'The ',0
s_advances		db ' advance/s\!',0Ah,0Ah,0
s_butMisses_0		db ', but misses',0
s_willYourGallantBand	db 'Will your gallant band choose to:',0Ah
			db '@Fight bravely',0Ah
			db '@Advance ahead',0Ah
			db '@Run away',0Ah,0
s_thePartyAdvances	db 0Ah,0Ah,'The party advances!',0Ah,0Ah,0
s_hasTheseOptions	db ' has these options this battle round:',0Ah,0Ah
			db '@Attack foes ',0
s_attackDistString	db '10',27h,0
s_characterOptionsString	db 0Ah
				db '@Defend',0Ah
				db '@Party attack',0Ah
				db '@Cast a spell',0Ah
				db '@Use an item',0Ah
				db '@Hide in shadows',0Ah
				db '@Bard Song',0Ah,0
s_selectAnOption	db 0Ah,0Ah,'Select an option.',0
s_nlUseOn		db 0Ah,'Use on ',0
s_youCantUseThatItem	db	'You can',27h,'t use that item.',0
s_attack		db 0Ah,'Attack ',0
s_useTheseCommands	db 'Use these commands?',0Ah,0Ah,0
s_andHits		db ', and hits ',0
s_timesFor		db ' times for ',0
s_andHitsFor		db ', and hits for ',0
s_firesBreathes		db ' /fir\breath\es ',0
s_lost			db ' lost ',0
s_voice			db ' voice!',0Ah,0Ah,0
s_plays			db ' plays...',0Ah,0Ah,0
s_hostilePartyMembers	db 'hostile party members!',0Ah,0Ah,0
s_comma			db ',',0
s_and			db 'and ',0
s_party			db 'Party',0
s_sorryBud		db 'Sorry, Bud',0
s_partyHasExpired	db 'Alas, your party has expired, but gone to adventurer heaven.',0
s_memberOneToSeven	db 'member #(1-7)',0
s_memberOne		db 'member #(1)',0
s_or			db ' or ',0
s_experiencePoinsForV	db ' experience points for valor and battle knowledge, and ',0
s_theyDisbelieve	db 'They disbelieve!',0Ah,0Ah,0
s_inGold		db ' in gold.',0Ah,0Ah,0
s_foundA		db ' found a ',0
s_eachCharacterReceives db 'Each character receives ',0
s_thePartyDisbelieves	db 'The party disbelieves...',0Ah,0Ah,0
s_treasure		db 'Treasure',0

s_breathEffectFried	db 'fried',0
s_breathEffectFrozen	db 'frozen',0
s_breathEffectShocked	db 'shocked',0
s_breathEffectDrained	db 'drained',0
s_breathEffectBurnt	db 'burnt',0
s_breathEffectChoked	db 'choked',0
s_breathEffectSteamed	db 'steamed',0
s_breathEffectBlasted	db 'blasted',0
s_breathEffectHit	db 'hit',0
s_breathEffectNuked	db 'nuked',0

g_breathEffectStringList	dd s_breathEffectFried		;   0
				dd s_breathEffectFrozen		;   1
				dd s_breathEffectShocked	;   2
				dd s_breathEffectDrained	;   3
				dd s_breathEffectBurnt		;   4
				dd s_breathEffectChoked		;   5
				dd s_breathEffectSteamed	;   6
				dd s_breathEffectBlasted	;   7
				dd s_breathEffectHit		;   8
				dd s_breathEffectNuked		;   9

s_atTheParty		db 'at the party...',0Ah,0Ah,0
s_partyTooFarAway	db 'But the party was too far away!',0Ah,0Ah,0
s_at			db 'at ',0
s_some			db 'some ',0
s_elipsisNl		db '...',0Ah,0Ah,0
s_one			db 'One ',0
s_repelledAttack	db 'repelled the attack!',0Ah,0Ah,0
s_wasTooFarAway		db 'was too far away!',0Ah,0Ah,0
s_is			db 'is ',0
a_for			db ' for ',0
s_pointsOfDamage	db ' point/\s\ of damage',0
s_capitalAnd		db 'And ',0
s_partyFreezes		db 'and the party freezes',0
s_butItHadNoEffect	db 'but it had no effect!',0Ah,0Ah,0
s_closer		db 'closer',0
s_fartherAway		db 'farther away',0
s_andTheFoesAre		db 'and the foes are ',0
s_theParty		db 'the party!',0
s_earthSwallows		db 'and the earth swallows up ',0
s_whichItem		db 'Which item?',0
s_spellAborted		db 'Spell aborted.',0
s_itemIdentified	db 'Item has been identified!',0
s_dopplganger		db 'Dopplganger',0
s_castsWeapon		db 'casts a weapon ',0
s_breathes		db 'breathes ',0

s_noRoomForSummon	db 'but no room for a summoning!',0Ah,0Ah,0
s_andA			db 'and a ',0
s_appears		db ' appears!',0Ah,0Ah,0
