s_tavernGreeting	db 'Hail, travelers! Step to the bar and I',27h,'ll draw you a tankard.',0Ah
			db 'You can:',0Ah
			db 'Order a drink',0Ah
			db 'Talk to barkeep',0Ah
			db 'Exit the tavern',0
align 2

s_whoWillOrder		db 'Who will order a drink?',0

s_seatThyself		db 'Seat thyself,',0Ah,0
align 2

s_drinkOptions		db 'What',27h,'ll it be?',0Ah
			db 'Ale',0Ah
			db 'Beer',0Ah
			db 'Mead',0Ah
			db 'Foul spirits',0Ah
			db 'Ginger Ale',0
align 2

s_cantOrder		db 'Thou are in no condition to order anything.',0

s_partyIsDisgrace	db 'In fact, thy party is a disgrace..',0Ah
			db 'Bouncers!!!',0
align 2

s_hereOrToGo		db 'Will you have it...',0Ah
			db 'Here or',0Ah
			db 'To go?',0
align 2
s_burpNotBad		db '(Burp!) Not too bad.',0
align 2
s_goodStuff		db 'My goodness, that',27h,'s good stuff.',0
s_thirstQuencher	db 'Now that',27h,'s a real thirst quencher!',0
align 2

s_littleLightheaded	db 'But you feel a little light-headed.', 0
s_startHiccuping	db 'You start hiccuping',0
s_beginToSing		db 'You begin to sing 99 bottles of beer on the wall.',0
s_hardTimeOnBarstool	db 'You seem to have a hard time staying on the bar stool.',0
align 2
s_collapseOnFloor	db 'You collapse on the floor.',0
align 2

s_sorryBut		db 'Sorry but ',0
align 2
s_cantCarryAnyMore	db ' can',27h,'t carry any more items.',0
align 2
s_barkeepFillsWineskin	db 'The bartender fills a wineskin with your order and hands it to you.',0
s_whoTalksToBarkeep	db 'Who will talk to the barkeep?',0
s_noConditionToTalk	db 'You are in no condition to talk.',0
align 2
s_talkAintCheap		db '"Talk ain',27h,'t cheap,',0
align 2
s_beerBreath		db ' Beer Breath',0
align 2
s_barkeepSays		db '" the barkeep says.',0
s_howMuchWillTip	db 'How much will you tip him?',0
align 2
s_moneyTalks		db '"Money talks, friend," he says.',0
s_sayingStash		db '"There',27h,'s a building in Skara Brae where some of the survivors stashed their goods. It may be helpful," smiles the bartender',0
s_sayingHarmonicGems	db '"Be on the lookout for the magic gems, your spellcasters will need them."',0
s_sayingAnotherBar	db '"There lies another bar in Celaria Bree, seek it. It exists only in the dimension called Lucencia."',0
s_sayingReviewBoard	db '"Seek out the old man in the Review Board. He keeps watch over everything."',0
s_sayingBardsHall	db '"Go to the bard',27h,'s hall and listen to the songs they sing. They contain useful information."',0
s_sayingViolet		db '"There is said to be a key existing in the Violet Mountains, this will gain access to Cyanis',27h,'s Tower."', 0
align 2
s_sayingAck		db '"Ack! It',27h,'s not just a word, but a state of mind."',0
s_sayingFindLock		db '"The key to finding Sceadu is finding the lock."',0
align 2
s_sayingSceadu		db '"Sceadu can be found in the middle of Nowhere."',0
s_sayingWerra		db '"Seek Werra in Tarmitia."',0
s_notEnoughGold		db 'Not enough gold.',0
align 2

barkeepSayings		dd s_sayingStash	; 0
			dd s_sayingHarmonicGems	; 1
			dd s_sayingAnotherBar	; 2
			dd s_sayingReviewBoard	; 3
			dd s_sayingReviewBoard	; 4
			dd s_sayingAck		; 5
			dd s_sayingHarmonicGems	; 6
			dd s_sayingAnotherBar	; 7
			dd s_sayingBardsHall	; 8
			dd s_sayingViolet	; 9
			dd s_sayingHarmonicGems	; 10
			dd s_sayingReviewBoard	; 11
			dd s_sayingWerra	; 12
			dd s_sayingFindLock	; 13
			dd s_sayingSceadu	; 14
s_drinkOptionKeys	db 'ABMFG',0
g_drinkPriceList	db 3, 2, 4, 6, 1, 3	   ; 0
nullDrunkValue		dw 0
drunkString		dd nullDrunkValue	    ; 0
			dd nullDrunkValue	; 1
			dd nullDrunkValue	; 2
			dd nullDrunkValue	; 3
			dd s_littleLightheaded	; 4
			dd s_littleLightheaded	; 5
			dd s_startHiccuping	; 6
			dd s_startHiccuping	; 7
			dd s_beginToSing	; 8
			dd s_hardTimeOnBarstool	; 9
			dd s_hardTimeOnBarstool	; 10
			dd s_collapseOnFloor	; 11
			dd s_collapseOnFloor	; 12

tavern_drinkStrength	db 1, 2, 3, 4, 0, 0	  ; 0

s_scrapwood		db 'Scrapwood',0
s_staggerInn		db 'Stagger Inn',0
s_hicHaven		db 'Hic Haven',0
s_cheers		db 'Cheers',0
s_tavern		db 'Tavern',0

g_tavernData		tavernLoc_t <12, 17, 0, 0, 0>; 0
			tavernLoc_t <7,	12, 3, 2, 5>; 1
			tavernLoc_t <2,	3, 3, 4, 5>; 2
			tavernLoc_t <13, 7, 6, 6, 5>; 3
			tavernLoc_t <99, 99, 99, 8, 10>; 4
			db    0

tavernNames		dd s_scrapwood	    ; 0
			dd s_staggerInn		; 1
			dd s_hicHaven		; 2
			dd s_cheers		; 3
			dd s_tavern		; 4

g_tavernSayingCost	dw 0, 50, 250, 500, 1000 ; 0
			db    0
