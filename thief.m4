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
include(`cleanupAndExit.asm')
include(`gameLoop.asm')
include(`map/dungeon/main.asm')
include(`map/dungeon/setSquareField4.asm')
include(`map/dungeon/canAdvance.asm')
include(`map/wild/main.asm')
include(`map/wild/canAdvance.asm')
include(`map/wild/enterBuilding.asm')
include(`map/wild/buildView.asm')
include(`map/dungeon/buildView.asm')
include(`map/dungeon/getWalls.asm')
include(`map/dungeon/sub_1156E.asm')
include(`map/wild/getSquare.asm')
include(`lib/wrapNumber.asm')
include(`map/getDataOffsetP.asm')
include(`map/resetLocation.asm')

seg000 ends

; Segment type: Pure code
seg001 segment word public 'CODE' use16
        assume cs:seg001
;org 0Bh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
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
align 2

include(`gfx/bigpic/tile/drawTopology.asm')
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

; Segment type: Pure code
seg006 segment word public 'CODE' use16
        assume cs:seg006
;org 9
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

include(`party/update.asm')
include(`character/update.asm')
include(`character/getDexterityAcBonus.asm')
include(`character/getEquipmentAcBonus.asm')
include(`character/isEffectEquipped.asm')
include(`character/inventory/pack.asm')
include(`character/inventory/addItem.asm')
include(`character/inventory/canBeUsed.asm')
include(`character/hasTypeEquipped.asm')
include(`character/itemTypeCanBeUsed.asm')
include(`character/getTypeEquippedSlot.asm')
include(`character/print/print.asm')
include(`character/inventory/appendCharges.asm')
include(`character/inventory/trade.asm')
include(`character/inventory/discard.asm')
include(`character/inventory/equip.asm')
include(`character/inventory/unequip.asm')
include(`character/inventory/identify.asm')
include(`character/inventory/print.asm')
include(`character/inventory/getOptions.asm')
include(`character/inventory/getItemList.asm')
include(`character/inventory/getItemName.asm')
include(`character/print/printStats.asm')
include(`io/printNumberAndString.asm')
include(`character/print/getAttributeString.asm')
include(`character/getGoldTradee.asm')
include(`character/print/printAbilities.asm')
include(`character/learnedSpell.asm')
include(`character/learnSpell.asm')
include(`character/hasSpecialAbilities.asm')

seg006 ends

; Segment type: Pure code
seg007 segment word public 'CODE' use16
        assume cs:seg007
;org 0Dh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

include(`map/turnAround.asm')
include(`map/moveOneSquare.asm')
include(`map/vm/if.asm')
include(`map/dungeon/changeLevels.asm')
include(`map/dungeon/setExitLocation.asm')
include(`map/vm/functions/downStairs.asm')
include(`map/vm/functions/upStairs.asm')
include(`map/vm/functions/utility.asm')
include(`map/vm/functions/teleport.asm')
include(`map/vm/functions/battle.asm')
include(`map/vm/functions/clearPrintString.asm')
include(`map/vm/functions/clearSpecial.asm')
include(`map/vm/functions/drawBigpic.asm')
include(`map/vm/functions/setTitle.asm')
include(`map/vm/functions/waitForIo.asm')
include(`map/vm/functions/clearText.asm')
include(`map/vm/functions/ifFlag.asm')
include(`map/vm/functions/ifNotFlag.asm')
include(`map/vm/lib/checkProgressFlags.asm')
include(`map/vm/functions/makeDoor.asm')
include(`map/vm/functions/setFlag.asm')
include(`map/vm/functions/clearFlag.asm')
include(`map/vm/lib/updateFlags.asm')
include(`map/vm/functions/ifSpellEq.asm')
include(`map/vm/functions/setMapRval.asm')
include(`map/vm/functions/printString.asm')
include(`map/vm/functions/doNothing.asm')
include(`map/vm/functions/ifLiquid.asm')
include(`map/vm/functions/getItem.asm')
include(`map/vm/functions/ifPartyHasItem.asm')
include(`map/vm/functions/ifPartyNotHasItem.asm')
include(`map/vm/lib/findItem.asm')
include(`map/vm/functions/ifSameSquare.asm')
include(`map/vm/functions/ifYesNo.asm')
include(`map/vm/functions/goto.asm')
include(`map/vm/functions/battleNoCry.asm')
include(`map/vm/functions/setSameSquareFlag.asm')
include(`map/vm/functions/turnAround.asm')
include(`map/vm/functions/removeItem.asm')
include(`map/vm/lib/removeItem.asm')
include(`map/vm/functions/incrementRegister.asm')
include(`map/vm/functions/decrementRegister.asm')
include(`map/vm/functions/ifRegisterClear.asm')
include(`map/vm/functions/ifRegisterSet.asm')
include(`map/vm/functions/drainHp.asm')
include(`map/vm/functions/ifInBox.asm')
include(`map/vm/functions/setLiquid.asm')
include(`map/vm/functions/addToContainer.asm')
include(`map/vm/functions/subtractFromContainer.asm')
include(`map/vm/functions/addToRegister.asm')
include(`map/vm/functions/subtractFromRegister.asm')
include(`map/vm/functions/setDirection.asm')
include(`map/vm/functions/readString.asm')
include(`map/vm/lib/strcmp.asm')
include(`map/vm/functions/ifStringEquals.asm')
include(`map/vm/functions/parseNumber.asm')
include(`map/vm/functions/getCharacter.asm')
include(`map/vm/functions/ifGiveGold.asm')
include(`map/vm/functions/addGold.asm')
include(`map/vm/functions/ifRegisterLt.asm')
include(`map/vm/functions/ifRegisterEq.asm')
include(`map/vm/functions/ifRegisterGe.asm')
include(`map/vm/functions/learnSpell.asm')
include(`map/vm/functions/setRegister.asm')
include(`map/vm/functions/ifHasItem.asm')
include(`map/vm/functions/packInventory.asm')
include(`map/vm/functions/addMonster.asm')
include(`map/vm/functions/ifMonsterInParty.asm')
include(`map/vm/functions/clearPrintOffset.asm')
include(`map/vm/functions/ifIsNight.asm')
include(`map/vm/functions/removeMonster.asm')
include(`map/vm/functions/buggedIfQuestFlagSet.asm')
include(`quest/partyHasFlagSet.asm')
include(`map/vm/functions/ifQuestFlagNotSet.asm')
include(`quest/partyNotHasFlagSet.asm')
include(`map/vm/functions/setQuestFlag.asm')
include(`quest/setFlag.asm')
include(`map/vm/functions/clearQuestFlag.asm')
include(`map/vm/functions/partyUnderLevel.asm')
include(`map/vm/lib/partyUnderLevel.asm')
include(`map/vm/functions/ifWildFace.asm')
include(`map/vm/functions/setWildFace.asm')
include(`map/vm/functions/ifIsClass.asm')
include(`map/vm/functions/printOffset.asm')
include(`map/vm/functions/clearTeleport.asm')
include(`map/vm/execute.asm')
include(`map/vm/functions/notImplemented.asm')

seg007 ends

; Segment type: Pure code
seg008 segment byte public 'CODE' use16
        assume cs:seg008
;org 0Ah
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

include(`battle/init.asm')
include(`battle/doRound.asm')
include(`battle/char/action.asm')
include(`battle/mon/action.asm')
include(`battle/mon/cast.asm')
include(`battle/mon/summonHelp.asm')
include(`battle/mon/breathe.asm')
include(`battle/mon/melee.asm')
include(`battle/mon/tarjan.asm')
include(`battle/mon/getName.asm')
include(`battle/char/getRandom.asm')
include(`battle/mon/meleeRoll.asm')
include(`battle/char/isAttackable.asm')
include(`battle/summon/action.asm')
include(`battle/summon/cast.asm')
include(`battle/summon/melee.asm')
include(`battle/summon/breathe.asm')
include(`battle/char/melee.asm')
include(`battle/getAttackerName.asm')
include(`lib/startsWithVowel.asm')
include(`battle/char/cast.asm')
include(`battle/char/use.asm')
include(`battle/char/hide.asm')
include(`battle/char/sing.asm')
include(`battle/char/possessedAttack.asm')
include(`battle/char/getNextPriority.asm')
include(`battle/mon/getNextPriority.asm')
include(`battle/setPriorities.asm')
include(`battle/setOpponents.asm')
include(`battle/mon/resetGroups.asm')
include(`battle/mon/sortGroups.asm')
include(`battle/mon/swapGroups.asm')
include(`battle/printOpponents.asm')
include(`battle/mon/printGroup.asm')
include(`battle/setBigpic.asm')
include(`battle/mon/copyBuffer.asm')
include(`battle/convertSongToCombat.asm')
include(`battle/dosong.asm')
include(`battle/endsong.asm')
include(`battle/reset.asm')
include(`lib/randomBetweenXandY.asm')
include(`lib/getRndDiceMask.asm')
include(`lib/randomYdX.asm')
include(`battle/party/fightAction.asm')
include(`battle/party/advanceAction.asm')
include(`battle/party/runAction.asm')
include(`battle/char/attackAction.asm')
include(`battle/char/defendAction.asm')
include(`battle/char/castAction.asm')
include(`battle/char/useAction.asm')
include(`battle/char/hideAction.asm')
include(`battle/char/singAction.asm')
include(`battle/char/partyAttackAction.asm')
include(`battle/party/getActions.asm')
include(`battle/party/canAdvance.asm')
include(`battle/mon/inMeleeRange.asm')
include(`battle/char/getAction.asm')
include(`battle/char/getActionTarget.asm')
include(`battle/mon/groupCount.asm')
include(`battle/char/executeMeleeAttack.asm')
include(`battle/char/printMeleeDamage.asm')
include(`battle/appendSpecialAttackString.asm')
include(`battle/damagehp.asm')
include(`battle/mon/damagehp.asm')
include(`battle/mon/applySpecialEffect.asm')
include(`battle/mon/kill.asm')
include(`battle/char/damageHp.asm')
include(`battle/char/applySpecialEffect.asm')
include(`character/applyAgeStatus.asm')
include(`party/died.asm')

seg008 ends

; Segment type: Pure code
seg009 segment word public 'CODE' use16
        assume cs:seg009
;org 9
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

include(`lib/random_2d16.asm')
include(`lib/random_2d8.asm')
include(`lib/random_1d8.asm')
include(`battle/giveExperience.asm')
include(`battle/giveGold.asm')
include(`battle/party/disbelieve.asm')
include(`battle/mon/disbelieve.asm')
include(`battle/party/applyPoison.asm')
include(`party/applyEquipmentEffects.asm')
include(`battle/party/applyHpRegen.asm')
include(`party/applySpptRegen.asm')
include(`battle/postRound.asm')
include(`battle/mon/countGroups.asm')
include(`battle/mon/moveGroup.asm')
include(`battle/party/packBonuses.asm')
include(`battle/mon/groupActive.asm')

include(`seg009.asm')

seg009 ends

; Segment type: Pure code
seg010 segment word public 'CODE' use16
        assume cs:seg010
;org 9
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

include(`spells/nonCombatCast.asm')
include(`spells/getspell.asm')
include(`spells/getsppt.asm')
include(`spells/docast.asm')
include(`spells/light.asm')
include(`spells/possess.asm')
include(`spells/damage.asm')
include(`battle/dobreath.asm')
include(`battle/char/isBreathAttackable.asm')
include(`spells/trapzap.asm')
include(`spells/freezeFoes.asm')
include(`spells/savingThrow.asm')
include(`lib/maxFF.asm')
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

; Segment type: Pure code
seg012 segment byte public 'CODE' use16
        assume cs:seg012
;org 0Eh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

include(`lib/maxFFFF.asm')
include(`building/review/enter.asm')
include(`building/review/checkXp.asm')
include(`building/review/advance.asm')
include(`building/review/getXpDelta.asm')
include(`building/review/learnSpells.asm')
include(`building/review/convert/conjuror.asm')
include(`building/review/convert/magician.asm')
include(`building/review/convert/sorcerer.asm')
include(`building/review/convert/wizard.asm')
include(`building/review/convert/archmage.asm')
include(`building/review/convert/chronomancer.asm')
include(`building/review/changeMageClass.asm')
include(`building/review/convert/learnSpellLevel.asm')
include(`building/review/convert/hasLearnedSpellLevel.asm')
include(`building/review/convert/hasBeenClass.asm')
include(`building/review/convert/countClassesGained.asm')
include(`building/review/convert/removeAllSpells.asm')
include(`building/review/speakToElder.asm')
include(`building/review/elderGelidia.asm')
include(`building/review/elderLucencia.asm')
include(`building/review/elderKinestia.asm')
include(`building/review/elderTenebrosia.asm')
include(`building/review/elderTarmitia.asm')
include(`building/review/isQuestComplete.asm')
include(`building/review/setTitle.asm')
include(`building/review/questBrilhasti.asm')
include(`building/review/questValarian.asm')
include(`building/review/questLanatir.asm')
include(`building/review/questAlliria.asm')
include(`building/review/questFerofist.asm')
include(`building/review/questSceadu.asm')
include(`building/review/questWerra.asm')
include(`building/review/questTarjan.asm')
include(`building/review/quest.asm')
include(`building/review/awardXp.asm')
include(`building/review/partySetFlag.asm')
include(`building/review/removeAgeStatus.asm')
include(`building/review/resetAgeStatus.asm')
include(`building/wizardsHall/enter.asm')
include(`building/wizardsHall/buySpell.asm')

seg012 ends

; Segment type: Pure code
seg013 segment byte public 'CODE' use16
        assume cs:seg013
;org 4
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

include(`map/dungeon/specialSquares/battleCheck.asm')
include(`map/dungeon/specialSquares/trap/trap.asm')
include(`map/dungeon/specialSquares/trap/doDamage.asm')
include(`map/dungeon/specialSquares/trap/levitationCheck.asm')
include(`map/dungeon/specialSquares/darkness.asm')
include(`map/dungeon/specialSquares/spinner.asm')
include(`map/dungeon/specialSquares/antiMagic.asm')
include(`map/dungeon/specialSquares/drainHp.asm')
include(`party/regenHp.asm')
include(`map/dungeon/specialSquares/somethingOdd.asm')
include(`map/dungeon/specialSquares/silence.asm')
include(`map/dungeon/specialSquares/regenSppt.asm')
include(`map/dungeon/specialSquares/drainSppt.asm')
include(`map/dungeon/specialSquares/makeHostile.asm')
include(`map/dungeon/specialSquares/stuck.asm')
include(`map/dungeon/specialSquares/regenHp.asm')
include(`map/dungeon/specialSquares/explosion.asm')
include(`map/dungeon/specialSquares/portalAbove.asm')
include(`map/dungeon/specialSquares/portalBelow.asm')
include(`map/dungeon/specialSquare.asm')
include(`map/vm/brilhasti/bonus.asm')
include(`map/vm/brilhasti/checkQuest.asm')
include(`map/vm/brilhasti/levelMagicUser.asm')
include(`map/vm/brilhasti/setAttributes.asm')
include(`map/vm/geomancer/convert.asm')
include(`map/vm/geomancer/convertEquipment.asm')
include(`map/dungeon/detect/detect.asm')
include(`map/dungeon/detect/getSquares.asm')
include(`map/dungeon/portal/ascend.asm')
include(`map/dungeon/portal/descend.asm')
include(`map/dungeon/portal/decrementLevel.asm')
include(`map/dungeon/portal/incrementLevel.asm')
include(`map/dungeon/wanderingCreature/join.asm')
include(`map/dungeon/wanderingCreature/fight.asm')
include(`map/dungeon/wanderingCreature/leave.asm')
include(`map/dungeon/wanderingCreature/wanderer.asm')

seg013 ends

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



; Segment type: Pure code
seg017 segment word public 'CODE' use16
        assume cs:seg017
;org 3
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

include(`misc/transfer/transfer.asm')
include(`misc/transfer/getTransferCharacters.asm')
include(`misc/transfer/findName.asm')
include(`misc/transfer/bt3transfer.asm')
include(`misc/transfer/import.asm')
include(`misc/transfer/convertSpellLevel.asm')
include(`misc/transfer/bt2transfer.asm')
include(`misc/transfer/bt1transfer.asm')

seg017 ends

; Segment type: Pure code
seg018 segment byte public 'CODE' use16
        assume cs:seg018
;org 0Ch
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

include(`misc/copyProtection/copyProtection.asm')
include(`misc/copyProtection/toDigit.asm')
include(`misc/copyProtection/compareStrings.asm')

seg018 ends

; Segment type: Pure code
seg019 segment word public 'CODE' use16
        assume cs:seg019
;org 3
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:nothing

byte_27433 db 90h, 10h dup(0)

include(`lib/huffman/init.asm')
include(`lib/huffman/flate.asm')
include(`lib/huffman/expandTree.asm')
include(`lib/huffman/getNextBit.asm')
include(`lib/huffman/newNode.asm')
include(`lib/huffman/extractByte.asm')
include(`lib/d3cmp/readData.asm')
include(`lib/d3cmp/sub_27632.asm')
include(`lib/d3cmp/outputToBuffer.asm')
include(`lib/d3cmp/updateMemory.asm')
include(`lib/d3cmp/sub_27724.asm')
include(`lib/d3cmp/getNextWord.asm')
include(`lib/d3cmp/readCopyOffset.asm')
include(`lib/d3cmp/init.asm')
include(`lib/d3cmp/doDecomp.asm')
include(`lib/d3cmp/sub_27980.asm')
include(`lib/d3cmp/flate.asm')
include(`lib/readCh.asm')
include(`lib/random.asm')
include(`lib/open.asm')
include(`lib/close.asm')
include(`lib/read.asm')
include(`lib/write.asm')
include(`lib/lseek.asm')
include(`lib/findFirstFile.asm')
include(`lib/findNextFile.asm')
include(`lib/checkKeyboard.asm')
include(`gfx/bigpic/tile/initBuffers.asm')
include(`gfx/bigpic/tile/copyTopoElement.asm')
include(`gfx/bigpic/tile/copyLeftTopo.asm')
include(`gfx/bigpic/tile/copyRightTopo.asm')

include(`seg019.asm')

seg019 ends

; Segment type: Regular
seg020 segment word public 'DATA' use16
        assume cs:seg020
;org 7
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:nothing
algn_2AD17:
align 2

include(`lib/huffman/data.asm')

seg020 ends

include seg021.asm
include seg022.asm
include(`seg023.asm')
include seg024.asm
include seg025.asm
include seg026.asm
include seg027.asm

; Segment type: Pure data
dseg segment para public 'DATA' use16
        assume cs:dseg

include(`dseg.asm')

dseg ends

; Segment type: Uninitialized
seg029 segment word stack 'STACK' use16
        assume cs:seg029
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:nothing
byte_50070 db 0FA0h dup(?)
seg029 ends

end start
