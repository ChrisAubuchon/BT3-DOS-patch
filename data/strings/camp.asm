s_campMenuString		db 'Thou art in the Camp of Skara Brae.'
				db 0Ah
				db 0Ah
				db '@Add a member',0Ah
				db '@Remove a member',0Ah
				db '@Rename a member',0Ah
				db '@Create a member',0Ah
				db '@Transfer characters',0Ah
				db '@Delete a member',0Ah
				db '@Save the party',0Ah
				db '@Leave the game',0Ah
				db '@Enter wilderness',0

s_saveAndExit			db 'Press <RETURN> to save off all char'
				db 'acters and end game play. Or press '
				db 'ESC to go back.',0

s_genderOptions			db 'Do you wish your character to be',0Ah
				db 'Male or',0Ah
				db 'Female?',0

s_raceOptions			db 'Select a race for your new character:',0Ah,0Ah
				db '1) Human',0Ah
				db '2) Elf',0Ah
				db '3) Dwarf',0Ah
				db '4) Hobbit',0Ah
				db '5) Half-Elf',0Ah
				db '6) Half-Orc',0Ah
				db '7) Gnome',0

s_nameYourCharacter		db 'Name your new character --',0
s_whichPartyMemberToRemove	db 'Select which party member to remove or...',0
s_removeAll			db 'Remove them all!',0
s_askPartyName			db 'Name to save party under?',0
s_deleteWho			db 'Delete Who?',0
s_currentlyInParty		db ' is currently in the party. Remove from the party first.',0
s_confirmDelete			db 'Are you sure you want to delete ',0
s_noCharsOnDisk			db 'There are no characters on this disk.',0
s_whoJoins			db 'Who shall join?',0
s_alreadyInParty		db ' is already in the party.',0
s_nameAlreadyExists		db 'There is already a character with that name in the party.',0
s_rosterIsFull			db 'The roster is full.',0
s_noOneHereNamedThat		db 'There',27h,'s no one here named that!',0
s_renameWho			db 'Rename Who?',0
s_whatIs			db 'What is ',0
s_newName			db 27h,'s new name?',0
s_ruinTitle			db 'The Ruin',0
s_thievesInf			db 'thieves.inf',0
s_partiesInf			db 'parties.inf',0

