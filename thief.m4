include(`macros.m4')dnl
include struct.h
include enums.h
include macros.h

; TODO
;
;


; Still Testing
;

; DONE
;
; Make monster breathe
; Fix monster special attack
; Divine intervention doesn't convert illusion to real monster
; Make the Up Arrow act like it should.
; Fix a bug where if a monster's attack priority is lower than all of the party's attack priorities the monster can't attack.
; Fix Horn of Gods and Wand of Fury.
; Set a maximum negative AC of -50 to match Apple II. Otherwise it can wrap.
; Fix the incorrect saving throw values for monsters in _savingThrowCheck
; Fix the groupSize when a new monster group is created by summoning
; Clear the monHostile flag after the check.
; Fix the dun_monHostile function to affect the party only when there is a monster in the party.
; Call doSummon() with 15h (Black Slayer) 10 times as Tarjan's only attack.
; COSMETIC: Print a blank line between attacks from a breath attack 
; COSMETIC: Print an '!' after the kill string
; COSMETIC: Fix the output of get_Reward if you leave the chest. It skipped over "you recieved 0 pieces of gold"
; Add text casting of spells
; Lights now stay on when hitting an anti-magic square. 
; Fixed Sorcerer Sight spell to detect more than just trap squares.
; Fixed monster rosters for levels. 
; Fizzle spells when cast on an anti-magic square like BT1 and BT2.
; Print full spell name under "Known Spells" screen of a magic user
; Removed wait4IO from dunsq_doTrap
; Made the outdoor levels outdoor. Basically just call a different setBG routine and make lightDistance 4 in dun_buildView
; COSMETIC: Clear the screen after certain actions in dunMainLoop and wildMainLoop. Messages would linger and be confusing.
; COSMETIC: Fixed the spacing of "XX points of damage" in a breath attack
; Add poison damage check to the periodic check loop
; Fixed the drop rate for Harmonic Gems
; Fix HP Regen squares
; Fixed the level of chest traps
; Fix a bug in tavern_talkToBarkeep where the top 16 bits of the gold donated were
;   ignored. So if you tipped 65537, only 1 gold was removed.

.486
;.mmx
.model large

; Segment type: Pure code
seg000 segment byte public 'CODE' use16
        assume cs:seg000
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
        ; Attributes: bp-based frame

include(`main.asm')

include(`seg000.asm')

seg000 ends

; Segment type: Pure code
seg001 segment word public 'CODE' use16
        assume cs:seg001
;org 0Bh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
algn_1173B:
align 2

include(`io/textCastSpell.asm')
include(`io/executeKeyboardCommand.asm')
include(`io/printStringWithWait.asm')
include(`io/printCommandHelp.asm')
include(`party/reorder.asm')
include(`party/swapMembers.asm')
include(`misc/saveGame.asm')
include(`misc/restoreGame.asm')
include(`item/use.asm')
include(`item/doSpell.asm')
include(`item/useCharge.asm')
include(`misc/soundToggle.asm')
include(`io/printVarString.asm')
include(`io/printLocation.asm')
include(`party/dropMember.asm')
include(`misc/quitGame.asm')

seg001 ends

; Segment type: Pure code
seg002 segment byte public 'CODE' use16
        assume cs:seg002
;org 6
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

include(`building/camp/addMember.asm')
include(`building/camp/insertParty.asm')
include(`building/camp/removeMember.asm')
include(`party/pack.asm')
include(`party/clear.asm')
include(`building/camp/renameMember.asm')
include(`building/camp/createMember.asm')
include(`building/camp/getGender.asm')
include(`building/camp/getRace.asm')
include(`party/nameExists.asm')
include(`roster/nameExists.asm')
include(`io/printListItem.asm')
include(`building/camp/deleteMember.asm')
include(`building/camp/deleteParty.asm')
include(`building/camp/saveParty.asm')
include(`roster/partyExists.asm')
include(`roster/makeParty.asm')
include(`roster/countParties.asm')
include(`building/camp/saveAndExit.asm')
include(`building/camp/exit.asm')
include(`building/camp/enter.asm')
include(`io/readRosterFiles.asm')
include(`io/writeCharacterFile.asm')
include(`io/writePartyFile.asm')
include(`roster/writeParty.asm')
include(`roster/writeCharacter.asm')
include(`misc/copyCharacterBuf.asm')
include(`roster/countCharacters.asm')
include(`building/camp/optionList.asm')
include(`party/findEmptySlot.asm')
include(`party/notEmpty.asm')
include(`party/getLastSlot.asm')
include(`party/isSlotActive.asm')
include(`building/tavern/enter.asm')
include(`building/tavern/order.asm')
include(`character/removeGold.asm')
include(`building/tavern/drink.asm')
include(`building/tavern/getWineskin.asm')
include(`building/tavern/isPartyDrunk.asm')
include(`building/tavern/setTitle.asm')
include(`building/tavern/talkToBarkeep.asm')
include(`building/temple/enter.asm')
include(`building/temple/getHealee.asm')
include(`io/printCharPronoun.asm')
include(`building/temple/setTitle.asm')
include(`building/temple/getHealPrice.asm')
include(`building/temple/getStatusAilment.asm')
include(`building/temple/clearStatus.asm')
include(`building/temple/getGoldPoolee.asm')
include(`io/readSlotNumber.asm')
include(`misc/poolGold.asm')
include(`misc/getLevelXp.asm')
include(`building/empty/enter.asm')
include(`building/storage/enter.asm')
include(`building/storage/getItem.asm')
include(`io/writeInventoryFile.asm')
include(`io/readInventoryFile.asm')
include(`building/storage/createItemList.asm')
include(`party/addCharacter.asm')
include(`io/openFile.asm')

seg002 ends

; Segment type: Pure code
seg003 segment byte public 'CODE' use16
        assume cs:seg003
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
; Attributes: bp-based frame

include(`misc/disk1Swap.asm')
include(`io/getYesNo.asm')
include(`io/getKey.asm')
include(`io/mouse/setScrollingIcon.asm')
include(`io/mouse/updateIcon.asm')
include(`io/mouse/getClick.asm')
include(`io/readChNoMouse.asm')
include(`misc/doRealtimeEvents.asm')
include(`misc/isAlphaNum.asm')
include(`io/timedGetKey.asm')
include(`io/textDelayNoTable.asm')
include(`io/textDelayWithTable.asm')
include(`io/getKeyWithDelay.asm')
include(`map/dungeon/minimap/show.asm')
include(`map/dungeon/minimap/getWalls.asm')
include(`map/vm/getString.asm')
include(`map/vm/unpackChar.asm')
include(`map/vm/extractChar.asm')
include(`misc/unmaskString.asm')
include(`io/text/scrollingWindow.asm')
include(`io/text/printScrollingArrows.asm')
include(`io/text/checkScrollingArrowClick.asm')
include(`io/readString/readString.asm')
include(`io/readString/insertCursor.asm')
include(`io/readString/overwriteCursor.asm')
include(`io/readString/printChar.asm')
include(`io/readString/echoChar.asm')
include(`io/readGold.asm')
include(`lib/strcat.asm')
include(`lib/itoa.asm')
include(`lib/itoaCountDigits.asm')
include(`io/printStringAndThreeDigits.asm')
include(`io/printThiefAbilValues.asm')
include(`lib/pluralize.asm')
include(`misc/stairsPluralHelper.asm')
include(`io/printStringWClear.asm')
include(`io/printString.asm')
include(`io/text/nlWriteString.asm')
include(`io/text/writeString.asm')
include(`io/text/newLine.asm')
include(`io/text/scroll.asm')
include(`misc/introScroll.asm')
include(`misc/victory.asm')
include(`io/text/wrapLongString.asm')
include(`party/print/print.asm')
include(`party/print/clearAndPrintLine.asm')
include(`party/print/printAt.asm')
include(`gfx/bigpic/setTitle.asm')
include(`lib/centerString.asm')
include(`io/writeStringAt.asm')
include(`io/printAt.asm')
include(`io/text/clear.asm')
include(`io/text/characterWidth.asm')
include(`gfx/icons/read.asm')
include(`gfx/bigpic/drawPictureNumber.asm')
include(`gfx/bigpic/configureCells.asm')
include(`map/read.asm')
include(`map/readGraphics.asm')
include(`map/readMonsters.asm')
include(`misc/printMessageAndExit.asm')

include(`seg003.asm')

seg003 ends

; Segment type: Pure code
seg004 segment word public 'CODE' use16
        assume cs:seg004
;org 7
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
algn_17737:
align 2

include(`gfx/bigpic/drawTopology.asm')
include(`gfx/bigpic/setBackground.asm')

seg004 ends

; Segment type: Pure code
seg005 segment byte public 'CODE' use16
        assume cs:seg005
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
; Attributes: bp-based frame

include(`gfx/icons/deactivate.asm')
include(`gfx/icons/activate.asm')
include(`gfx/animate.asm')
include(`gfx/icons/draw.asm')

seg005 ends

include seg006.asm
include seg007.asm
include(`seg008.asm')
include seg009.asm

; Segment type: Pure code
seg010 segment word public 'CODE' use16
        assume cs:seg010
;org 9
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
algn_1FC89:
align 2

include(`spells/nonCombatCast.asm')
include(`spells/getspell.asm')
include(`spells/getsppt.asm')
include(`spells/docast.asm')
include(`spells/light.asm')
include(`spells/possess.asm')
include(`spells/damage.asm')
include(`battle/dobreath.asm')
include(`spells/trapzap.asm')
include(`spells/freezeFoes.asm')
include(`spells/savingThrow.asm')
include(`spells/compass.asm')
include(`spells/heal.asm')
include(`spells/levitate.asm')
include(`spells/summon.asm')
include(`spells/teleport.asm')
include(`spells/farfoes.asm')
include(`spells/vorpal.asm')
include(`spells/detect.asm')
include(`spells/shield.asm')
include(`spells/strength.asm')
include(`spells/phase.asm')
include(`spells/acbonus.asm')
include(`spells/disbelieve.asm')
include(`spells/scry.asm')
include(`spells/antimag.asm')
include(`spells/wordfear.asm')
include(`spells/spellbind.asm')
include(`spells/haltfoe.asm')
include(`spells/meleemen.asm')
include(`spells/batch.asm')
include(`spells/camarade.asm')
include(`io/printFizzled.asm')
include(`spells/luck.asm')
include(`spells/identify.asm')
include(`spells/earthmaw.asm')
include(`io/printNoEffect.asm')
include(`spells/divine.asm')
include(`spells/map.asm')
include(`spells/uselight.asm')
include(`spells/useacorn.asm')
include(`spells/useWineskin.asm')
include(`io/cantUse.asm')
include(`spells/useWeapon.asm')
include(`spells/reenergize.asm')
include(`spells/useFigurine.asm')
include(`misc/rndxd4.asm')
include(`battle/inrange.asm')
include(`spells/cast.asm')
include(`spells/batchCast.asm')
include(`spells/checkSpellpoints.asm')
include(`misc/strcatTargetName.asm')

seg010 ends

; Segment type: Pure code
seg011 segment word public 'CODE' use16
        assume cs:seg011
;org 1
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
algn_229C1:
align 2

include(`song/singnc.asm')
include(`song/cansing.asm')
include(`song/canplay.asm')
include(`song/getsubt.asm')
include(`song/getsong.asm')
include(`song/playsong.asm')
include(`song/stopsong.asm')
include(`song/endhelpr.asm')
include(`song/strtnonc.asm')
include(`song/endnonc.asm')

seg011 ends

include seg012.asm
include seg013.asm

; Segment type: Pure code
seg014 segment byte public 'CODE' use16
        assume cs:seg014
;org 8
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

include(`building/bardsHall/enter.asm')
include(`building/bardsHall/listen.asm')
include(`building/bardsHall/printLyrics.asm')
include(`building/bardsHall/learnSong.asm')
include(`building/bardsHall/configOptionList.asm')

seg014 ends

; Segment type: Pure code
seg015 segment word public 'CODE' use16
        assume cs:seg015
;org 0Dh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

include(`spells/summon/execute.asm')
include(`spells/summon/partySummon.asm')
include(`spells/summon/monSummon.asm')
include(`spells/summon/getMatchingMonsterGroup.asm')
include(`spells/summon/addMonToGroup.asm')
include(`spells/summon/newMonsterGroup.asm')
include(`spells/summon/maskSummonName.asm')
include(`spells/summon/printNoRoom.asm')

seg015 ends

; Segment type: Pure code
seg016 segment byte public 'CODE' use16
        assume cs:seg016
;org 0Eh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

include(`misc/configureBT3.asm')

seg016 ends

include seg017.asm
include seg018.asm
include seg019.asm
include seg020.asm
include seg021.asm
include seg022.asm
include(`seg023.asm')
include seg024.asm
include seg025.asm
include seg026.asm
include seg027.asm
include dseg.asm
include seg029.asm
