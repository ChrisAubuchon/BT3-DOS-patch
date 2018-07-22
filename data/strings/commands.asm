s_pausing		db 'pausing',0
s_whoToDrop		db 'Who will you drop?',0
s_cantDropCharacter	db 'You can',27h,'t drop a party member.',0
s_whoUsesItem		db 'Who will use an item?',0
s_UseOn			db 'Use on ',0
s_powerless		db 'Powerless.',0
s_confirmRestore	db 'Do you wish to restore your last saved game?',0
s_confirmSave		db 'Do you wish to save your game?',0
s_savingTheGame		db 'Saving the game.',0
s_gameHasBeenSaved	db 'Your game has been saved to disk.',0Ah, 0Ah
			db 'Do you wish to exit to DOS?',0
s_helpMessage1		db 'HELP for those in need:',0Ah, 0Ah
			db '1-7 = Player info',0Ah
			db 'Arrows = Move, turn',0Ah
			db '? = Where are we',0Ah
			db 'N = New march order',0Ah
			db 'S = Save the game',0Ah
			db 'T = Time out',0Ah
			db 'V = Sound on/off',0Ah,0
s_helpMessage2		db 'More HELP:',0Ah, 0Ah
			db 'B = Play a Bard tune',0Ah
			db 'C = Cast a spell',0Ah
			db 'F1-F7 = Cast a spell',0Ah
			db 'E = Ascend portal',0Ah
			db 'W = Descend portal',0Ah
			db 'P = Party combat',0Ah
			db 'D = Drop special party member',0Ah
			db 'U = Use an item',0Ah,0
s_newOrder		db 'New Order:',0Ah,0Ah,0
s_reorderListItem	db '>x ',0
s_useThisOrder		db 0Ah,'Use this order?',0
s_gameSav		db 'game.sav',0
s_cantOpenGameSave	db 'Can',27h,'t open game save file',0
s_confirmQuit		db 'Quit the game?',0
s_loseProgressConfirm	db 'You will lose your game status.',0Ah
			db 0Ah, 0Ah, 0Ah
			db '  Do you wish to quit?',0
