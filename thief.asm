include struct.h
include enums.h
include macros.h

; TODO
;
; Look at adding scrolling speed commands
;	- getIOwithDelay. This looks to be fairly complicated since there isn't a text_delay a la BT1.
;
; Check the monster breath effects are correct. e.g. "Frozen for xx" instead of "Burned for xx"
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

.486
;.mmx
.model large

include seg000.asm
include seg001.asm
include seg002.asm
include seg003.asm
include seg004.asm
include seg005.asm
include seg006.asm
include seg007.asm
include seg008.asm
include seg009.asm
include seg010.asm
include seg011.asm
include seg012.asm
include seg013.asm
include seg014.asm
include seg015.asm
include seg016.asm
include seg017.asm
include seg018.asm
include seg019.asm
include seg020.asm
include seg021.asm
include seg022.asm
include seg023.asm
include seg024.asm
include seg025.asm
include seg026.asm
include seg027.asm
include dseg.asm
include seg029.asm
