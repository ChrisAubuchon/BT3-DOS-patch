; Segment type:	Pure code
seg001 segment word public 'CODE' use16
	assume cs:seg001
;org 0Bh
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
algn_1173B:
align 2
; Attributes: bp-based frame

txt_castSpell proc far

	_instr = word ptr -7
	counter = word ptr -2
	arg_0 = word ptr 6

	func_enter
	push	si
	_chkstk	7
	call	clearTextWindow

	push_ds_string	offset aSpellToCast
	func_printString

	push_imm	4
	push_ss_string	_instr
	func_readString

	push_ss_string	_instr
	std_call	_strlen, 4
	cmp	ax, 4
	jl	loc_txt_castSpell_fail_no_print

	lea	si, [bp+_instr]
	mov	[bp+counter], 0

loc_txt_castSpell_toupper_start:
	cmp	[bp+counter], 4
	jge	loc_txt_castSpell_toupper_exit
	mov	bx, [bp+counter]
	mov	al, ss:[si+bx]
	sub	ah, ah
	push	ax
	std_call	_str_capitalize,2

	mov	bx, [bp+counter]
	mov	ss:[si+bx], al
	inc	[bp+counter]
	jmp	loc_txt_castSpell_toupper_start

loc_txt_castSpell_toupper_exit:
	mov	[bp+counter], 0

loc_txt_castSpell_spellCmp_start:
	cmp	[bp+counter], 7Eh
	jge loc_txt_castSpell_spellNotFound

	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	shl	bx, 1
	mov	si, word ptr spellString.abbreviation[bx]
	lea	di, [bp+_instr]
	push	ss
	pop	es
	mov	cx, 4
	repe	cmpsb
	jz	loc_txt_castSpell_spellFound

	inc	[bp+counter]
	jmp	loc_txt_castSpell_spellCmp_start

loc_txt_castSpell_spellNotFound:
	push_ds_string aNoSpellByThatName
	jmp	loc_txt_castSpell_fail

loc_txt_castSpell_spellFound:
	push	[bp+counter]
	push	[bp+arg_0]
	std_call	mage_hasLearnedSpell, 4
	or	ax, ax
	jz	loc_txt_castSpell_notLearned
	
	mov	ax, [bp+counter]
	jmp	loc_txt_castSpell_exit

loc_txt_castSpell_notLearned:
	push_ds_string	aYouDonTKnowThatSpell

loc_txt_castSpell_fail:
	func_printString

	delayNoTable	2

loc_txt_castSpell_fail_no_print:
	func_return	0FFFFh

loc_txt_castSpell_exit:
	pop	si
	func_exit
	retf
txt_castSpell endp

getKeyboardCmd proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], dosKeys_F1
	jl	short loc_11765
	cmp	[bp+arg_0], dosKeys_F7
	jg	short loc_11765
	push	[bp+arg_0]
	call	castSpell
	add	sp, 2
	jmp	loc_getKeyboardCmd_success
loc_11765:
	cmp	[bp+arg_0], 31h	
	jl	short loc_11786
	cmp	[bp+arg_0], 37h	
	jg	short loc_11786
	mov	ax, [bp+arg_0]
	sub	ax, 31h	
	push	ax
	call	printCharacter
	add	sp, 2
	jmp	loc_getKeyboardCmd_success
	
loc_11786:
	mov	ax, [bp+arg_0]
	jmp	loc_1182E
l_printHelp:
	push	cs
	call	near ptr printCommandHelp
	jmp	loc_getKeyboardCmd_success
l_castSpell:
	sub	ax, ax
	push	ax
	call	castSpell
	add	sp, 2
	jmp	loc_getKeyboardCmd_success
	
l_reorderParty:
	call	reorderParty
	jmp	loc_getKeyboardCmd_success
	
l_saveGame:
	call	saveGame
	jmp	loc_getKeyboardCmd_success
	
l_singBardSong:
	call	song_getNonCombatSinger
	jmp	loc_getKeyboardCmd_success
l_dropMember:
	call	dropPartyMember
	jmp	loc_getKeyboardCmd_success
l_pauseGame:
	cmp	gs:byte_42296, 0FFh
	jnz	short loc_117E1
	jmp	loc_getKeyboardCmd_fail
loc_117E1:
	mov	gs:advanceTimeFlag, 1
	mov	ax, offset aPausing
	push	ds
	push	ax
	call	anotherPrintString
	add	sp, 4
	mov	gs:advanceTimeFlag, 0
	jmp	loc_getKeyboardCmd_success
l_partyAttack:
	mov	partyAttackFlag, 1
	jmp	loc_getKeyboardCmd_fail
l_useItem:
	call	useItem
	jmp	loc_getKeyboardCmd_success
l_toggleSound:
	call	snd_toggle
	jmp	loc_getKeyboardCmd_success
loc_11828:
	jmp	loc_getKeyboardCmd_fail
loc_1182E:
	sub	ax, 42h	
	cmp	ax, 14h
	ja	short loc_11828
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_1183E[bx]
off_1183E dw offset l_singBardSong 
dw offset l_castSpell	
dw offset l_dropMember	
dw offset loc_11828	
dw offset loc_11828	
dw offset loc_11828	
dw offset l_printHelp	
dw offset loc_11828	
dw offset loc_11828	
dw offset loc_11828	
dw offset loc_11828	
dw offset loc_11828	
dw offset l_reorderParty	
dw offset loc_11828	
dw offset l_partyAttack	
dw offset loc_11828	
dw offset loc_11828	
dw offset l_saveGame	
dw offset l_pauseGame	
dw offset l_useItem	
dw offset l_toggleSound	

loc_getKeyboardCmd_fail:
	xor	ax, ax
	jmp	loc_getKeyboardCmd_exit

loc_getKeyboardCmd_success:
	mov	ax, 1

loc_getKeyboardCmd_exit:
	mov	sp, bp
	pop	bp
	retf
getKeyboardCmd endp

; Attributes: bp-based frame
anotherPrintString proc	far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	clearTextWindow
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	printString
	add	sp, 4
	wait4IO
	mov	sp, bp
	pop	bp
	retf
anotherPrintString endp

; Attributes: bp-based frame

printCommandHelp proc far
	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	clearTextWindow
	mov	ax, offset aHelpForThoseInNeed17
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	call	clearTextWindow
	mov	ax, offset aMoreHelpBPlayABardTu
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	mov	sp, bp
	pop	bp
	retf
printCommandHelp endp

; Attributes: bp-based frame

reorderParty proc far

	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_E= word ptr	-0Eh

	push	bp
	mov	bp, sp
	mov	ax, 24h	
	call	someStackOperation
	push	di
	push	si
	call	findEmptyRosterNum
	mov	[bp+var_24], ax
	cmp	ax, 1
	jg	short loc_11902
	jmp	loc_11A89
loc_11902:
	call	clearTextWindow
	mov	[bp+var_12], 0
	jmp	short loc_11911
loc_1190E:
	inc	[bp+var_12]
loc_11911:
	cmp	[bp+var_12], 7
	jge	short loc_1192D
	mov	si, [bp+var_12]
	shl	si, 1
	mov	[bp+si+var_E], 0
	mov	si, [bp+var_12]
	shl	si, 1
	mov	[bp+si+var_22],	0FFFFh
	jmp	short loc_1190E
loc_1192D:
	mov	ax, offset aNewOrder
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+var_12], 0
	jmp	short loc_11944

loc_11941:
	inc	[bp+var_12]

loc_11944:
	mov	ax, [bp+var_24]
	dec	ax
	cmp	ax, [bp+var_12]
	jle	short loc_119B4
	mov	al, byte ptr [bp+var_12]
	add	al, '1'
	mov	byte_42AF5, al
	mov	ax, offset gtChar
	push	ds
	push	ax
	call	sub_16560
	add	sp, 4

loc_11962:
	call	getCharNumber
	mov	[bp+var_10], ax
	or	ax, ax
	jge	short loc_11971
	jmp	loc_11A89

loc_11971:
	mov	ax, [bp+var_24]
	cmp	[bp+var_10], ax
	jge	short loc_11962
	mov	si, [bp+var_10]
	shl	si, 1
	cmp	[bp+si+var_E], 0
	jnz	short loc_11962
	mov	si, [bp+var_10]
	shl	si, 1
	mov	[bp+si+var_E], 1
	mov	si, [bp+var_12]
	shl	si, 1
	mov	ax, [bp+var_10]
	mov	[bp+si+var_22],	ax
	getCharP	[bp+var_10], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	sub_16595
	add	sp, 4
	jmp	short loc_11941

loc_119B4:
	mov	[bp+var_14], 0

loc_119B9:
	mov	si, [bp+var_14]
	shl	si, 1
	cmp	[bp+si+var_E], 0
	jz	short loc_119C9
	inc	[bp+var_14]
	jmp	short loc_119B9

loc_119C9:
	mov	si, [bp+var_24]
	shl	si, 1
	mov	ax, [bp+var_14]
	mov	[bp+si+var_24],	ax
	mov	al, byte ptr [bp+var_24]
	add	al, '0'
	mov	byte_42AF5, al
	mov	ax, offset gtChar
	push	ds
	push	ax
	call	sub_16560
	add	sp, 4
	getCharP	[bp+var_14], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	sub_16595
	add	sp, 4
	mov	ax, offset aUseThisOrder?
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	short loc_11A1A
	jmp	short loc_11A1D
loc_11A1A:
	jmp	loc_11902
loc_11A1D:
	mov	[bp+var_12], 0
	jmp	short loc_11A27
loc_11A24:
	inc	[bp+var_12]
loc_11A27:
	mov	ax, [bp+var_24]
	dec	ax
	cmp	ax, [bp+var_12]
	jle	short loc_11A7F
	mov	di, [bp+var_12]
	shl	di, 1
	mov	si, [bp+di+var_22]
	cmp	[bp+var_12], si
	jz	short loc_11A7D
	push	si
	push	[bp+var_12]
	push	cs
	call	near ptr party_swapMembers
	add	sp, 4
	mov	ax, [bp+var_12]
	inc	ax
	mov	[bp+var_14], ax
	jmp	short loc_11A54
loc_11A51:
	inc	[bp+var_14]
loc_11A54:
	mov	ax, [bp+var_24]
	cmp	[bp+var_14], ax
	jge	short loc_11A6D
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+var_12]
	cmp	[bp+si+var_22],	ax
	jnz	short loc_11A6B
	jmp	short loc_11A6D
loc_11A6B:
	jmp	short loc_11A51
loc_11A6D:
	mov	si, [bp+var_12]
	shl	si, 1
	mov	ax, [bp+si+var_22]
	mov	si, [bp+var_14]
	shl	si, 1
	mov	[bp+si+var_22],	ax
loc_11A7D:
	jmp	short loc_11A24
loc_11A7F:
	mov	byte ptr word_44166,	0
loc_11A89:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
reorderParty endp

; Attributes: bp-based frame

party_swapMembers proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	func_enter
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	copyCharacterBuf
	add	sp, 8
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	getCharP	[bp+arg_2], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	copyCharacterBuf
	add	sp, 8
	getCharP	[bp+arg_2], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	push	dx
	push	ax
	call	copyCharacterBuf
	add	sp, 8
	mov	sp, bp
	pop	bp
	retf
party_swapMembers endp

; Attributes: bp-based frame

saveGame proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aDoYouWishToSaveY
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_11B2A
	jmp	loc_11BF9
loc_11B2A:
	cmp	inDungeonMaybe, 0
	jz	short loc_11B3B
	mov	ax, 4
	jmp	short loc_11B3E
loc_11B3B:
	mov	ax, 2
loc_11B3E:
	mov	buildingRvalMaybe, ax
	mov	ax, 2
	push	ax
	mov	ax, offset aGame_sav
	push	ds
	push	ax
	call	openFile
	add	sp, 6
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_11B88
	call	clearTextWindow
	mov	ax, offset aCanTOpenGameSave
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	mov	buildingRvalMaybe, 0
	jmp	short loc_11BF9
loc_11B88:
	mov	ax, offset aSavingTheGame_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 348h
	push	ax
	mov	ax, offset roster
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_2]
	call	_write
	add	sp, 8
	mov	ax, offset byte_4EECC
	mov	cx, offset currentLocationMaybe
	mov	bx, seg	dseg
	sub	ax, cx
	push	ax
	mov	ax, cx
	mov	dx, bx
	push	dx
	push	ax
	push	[bp+var_2]
	call	_write
	add	sp, 8
	push	[bp+var_2]
	call	_close
	add	sp, 2
	mov	ax, offset aYourGameHasBeenS
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	short loc_11BEF
	mov	ax, 0FFh
	jmp	short loc_11BF1
loc_11BEF:
	sub	ax, ax
loc_11BF1:
	mov	buildingRvalMaybe, ax
loc_11BF9:
	mov	sp, bp
	pop	bp
	retf
saveGame endp

; Attributes: bp-based frame

restoreGame proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	buildingRvalMaybe, 1
	mov	ax, offset aDoYouWishToResto
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_11C2C
	jmp	loc_11CD6
loc_11C2C:
	call	sub_22DA1
	mov	ax, offset aGame_sav
	push	ds
	push	ax
	call	getDisk2
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, 348h
	push	ax
	mov	ax, offset roster
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_2]
	call	_read
	add	sp, 8
	mov	ax, offset byte_4EECC
	mov	cx, offset currentLocationMaybe
	mov	bx, seg	dseg
	sub	ax, cx
	push	ax
	mov	ax, cx
	mov	dx, bx
	push	dx
	push	ax
	push	[bp+var_2]
	call	_read
	add	sp, 8
	push	[bp+var_2]
	call	_close
	add	sp, 2
	mov	[bp+var_4], 0
	jmp	short loc_11C8A
loc_11C87:
	inc	[bp+var_4]
loc_11C8A:
	cmp	[bp+var_4], 5
	jge	short loc_11CAA
	mov	bx, [bp+var_4]
	cmp	lightDuration[bx], 0
	jz	short loc_11CA8
	push	bx
	call	icon_activate
	add	sp, 2
loc_11CA8:
	jmp	short loc_11C87
loc_11CAA:
	cmp	byte_4EEBA, 6
	jb	short loc_11CBE
	cmp	byte_4EEBA, 12h
	jbe	short loc_11CC2
loc_11CBE:
	mov	al, 1
	jmp	short loc_11CC4
loc_11CC2:
	sub	al, al
loc_11CC4:
	mov	gs:isNight, al
	mov	byte ptr word_44166,	0
loc_11CD6:
	mov	sp, bp
	pop	bp
	retf
restoreGame endp

; Attributes: bp-based frame

useItem	proc far

	var_FA=	word ptr -0FAh
	var_3A=	word ptr -3Ah
	var_36=	word ptr -36h
	var_34=	word ptr -34h
	var_32=	word ptr -32h
	var_2= word ptr	-2

	func_enter
	_chkstk 0FAh

	push_ds_string	aWhoWillUseAnItem
	std_call	printStringWClear, 4
	call	getCharNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_11D01
	jmp	loc_11E03
loc_11D01:
	getCharP	[bp+var_2], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_11D18
	jmp	loc_11E03
loc_11D18:
	getCharP	[bp+var_2], bx
	cmp	gs:roster.class[bx], class_monster
	jb	short loc_11D2B
	jmp	loc_11E03
loc_11D2B:
	push_ss_string	var_32
	push_ss_string	var_FA
	push_var_stack	var_2
	std_call	sub_188E8, 0Ah

	mov	[bp+var_36], ax
	or	ax, ax
	jnz	short loc_11D4B
	jmp	loc_11DE7
loc_11D4B:
	push_reg	ax
	push_ss_string	var_32
	push_ds_string	aWhichItem?
	std_call	text_scrollingWindow, 0Ah

	mov	[bp+var_34], ax
	or	ax, ax
	jge	short loc_11D6B
	jmp	loc_11E03
loc_11D6B:
	push	[bp+var_34]
	push	[bp+var_2]
	call	item_canBeUsed
	add	sp, 4
	or	ax, ax
	jz	short loc_11DD8
	mov	bx, curSpellNo
	mov	al, byte_47F94[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+var_3A], ax
	cmp	ax, 4
	jge	short loc_11DB5
	mov	ax, offset aUseOn
	push	ds
	push	ax
	push	[bp+var_3A]
	call	getTarget
	add	sp, 6
	mov	[bp+var_3A], ax
	or	ax, ax
	jge	short loc_11DB5
	jmp	short loc_11E03
loc_11DB5:
	call	clearTextWindow
	sub	ax, ax
	push	ax
	push	curSpellNo
	push	[bp+var_3A]
	push	[bp+var_34]
	push	[bp+var_2]
	push	cs
	call	near ptr sub_11E07
	add	sp, 0Ah
	jmp	short loc_11DE5
loc_11DD8:
	mov	ax, offset aPowerless_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_11DE5:
	jmp	short loc_11DF7
loc_11DE7:
	mov	ax, offset aYourPocketsAreEm
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printStringWClear
	add	sp, 4
loc_11DF7:
	wait4IO
loc_11E03:
	mov	sp, bp
	pop	bp
	retf
useItem	endp

; Attributes: bp-based frame

sub_11E07 proc far

	charNo=	word ptr  6
	arg_2= word ptr	 8
	arg_4= byte ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+arg_2]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	gs:byte_4227E, al
	mov	al, byte ptr [bp+charNo]
	mov	gs:byte_42288, al
	mov	al, [bp+arg_4]
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	push	[bp+arg_8]
	push	[bp+arg_6]
	push	[bp+charNo]
	call	doCastSpell
	add	sp, 8
	push	[bp+arg_2]
	push	[bp+charNo]
	push	cs
	call	near ptr sub_11E5D
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sub_11E07 endp

; Attributes: bp-based frame

sub_11E5D proc far

	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	getCharIndex	ax, [bp+arg_0]
	mov	bx, [bp+arg_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	cmp	gs:roster.inventory.itemCount[bx], 0FFh
	jnz	short loc_11E8B
	mov	ax, 1
	jmp	loc_11F17
loc_11E8B:
	getCharIndex	ax, [bp+arg_0]
	mov	cx, [bp+arg_2]
	mov	dx, cx
	shl	cx, 1
	add	cx, dx
	add	cx, ax
	add	cx, 64h	
	mov	word ptr [bp+var_4], cx
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	dec	byte ptr fs:[bx]
	lfs	bx, [bp+var_4]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_11EBC
	mov	ax, 1
	jmp	short loc_11F17
loc_11EBC:
	mov	ax, [bp+arg_2]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	gs:word_42416, ax
	mov	ax, [bp+arg_0]
	mov	gs:word_4244C, ax
	call	inven_pack
	mov	al, gs:byte_41E62
	sub	ah, ah
	cmp	ax, [bp+arg_0]
	jnz	short loc_11F17
	mov	ax, 6
	push	ax
	push	[bp+arg_0]
	call	inven_hasTypeEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_11F17
	cmp	gs:byte_422A4, 0
	jz	short loc_11F12
	call	bat_endCombatSong
	jmp	short loc_11F17
loc_11F12:
	call	sub_22DA1
loc_11F17:
	mov	sp, bp
	pop	bp
	retf
sub_11E5D endp

; Attributes: bp-based frame
snd_toggle proc	far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	word_42B36, 1
	sbb	ax, ax
	neg	ax
	mov	word_42B36, ax
	push	ax
	call	sub_27E05
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
snd_toggle endp

; This function	prints a string	based on a structure
; that is passed to it.	The optional lines are prefaced
; with a '@'
; Attributes: bp-based frame

printVarString proc far

	var_10A= word ptr -10Ah
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= dword ptr -4
	inString= dword	ptr  6
	arg_4= dword ptr  0Ah
	arg_8= dword ptr  0Eh
	arg_C= dword ptr  12h

	push	bp
	mov	bp, sp
	mov	ax, 10Ah
	call	someStackOperation
	push	si
	sub	ax, ax
	mov	[bp+var_8], ax
	mov	[bp+var_A], ax
	lea	ax, [bp+var_10A]
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], ss
loc_11F5C:
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_6], ax
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	al, byte ptr [bp+var_6]
	mov	fs:[bx], al
	cmp	[bp+var_6], 0
	jz	short loc_11F82
	cmp	[bp+var_6], '@'
	jnz	short loc_11F5C
loc_11F82:
	dec	word ptr [bp+var_4]
	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10A]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	lea	ax, [bp+var_10A]
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], ss
	cmp	[bp+var_6], 0
	jnz	short loc_11FBA
	mov	bx, [bp+var_8]
	lfs	si, [bp+arg_8]
	mov	byte ptr fs:[bx+si], 0
	mov	ax, [bp+var_A]
	jmp	loc_12082
loc_11FBA:
	cmp	[bp+var_6], 40h	
	jz	short loc_11FC3
	jmp	loc_1207F
loc_11FC3:
	mov	bx, [bp+var_8]
	lfs	si, [bp+arg_4]
	cmp	byte ptr fs:[bx+si], 0
	jz	short loc_1204B
	lfs	bx, [bp+inString]
	mov	al, fs:[bx]
	mov	bx, [bp+var_8]
	lfs	si, [bp+arg_8]
	mov	fs:[bx+si], al
	cmp	gs:byte_42419, 0
	jz	short loc_11FEF
	call	txt_newLine
loc_11FEF:
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Eh
	mov	bx, [bp+var_8]
	inc	[bp+var_8]
	shl	bx, 1
	lfs	si, [bp+arg_C]
	mov	fs:[bx+si], ax
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_A], ax
loc_12023:
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_6], ax
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	al, byte ptr [bp+var_6]
	mov	fs:[bx], al
	cmp	[bp+var_6], 0
	jz	short loc_12049
	cmp	[bp+var_6], 40h	
	jnz	short loc_12023
loc_12049:
	jmp	short loc_1207F
loc_1204B:
	mov	bx, [bp+var_8]
	lfs	si, [bp+arg_8]
	mov	byte ptr fs:[bx+si], 0FFh
	mov	bx, [bp+var_8]
	inc	[bp+var_8]
	shl	bx, 1
	lfs	si, [bp+arg_C]
	mov	word ptr fs:[bx+si], 0
loc_12065:
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_6], ax
	or	ax, ax
	jz	short loc_1207C
	cmp	ax, 40h	
	jnz	short loc_12065
loc_1207C:
	inc	word ptr [bp+var_4]
loc_1207F:
	jmp	loc_11F82
loc_12082:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printVarString endp

; Attributes: bp-based frame

cmd_printLocation proc far

	var_126= word ptr -126h
	var_124= word ptr -124h
	var_110= word ptr -110h
	var_10E= word ptr -10Eh
	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 126h
	call	someStackOperation
	mov	[bp+var_10E], offset characterIOBuf
	mov	[bp+var_10C], seg seg022
	mov	ax, offset aYouReIn
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	cmp	currentLocationMaybe, 0
	jnz	short loc_120DF
	mov	ax, offset aThe
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
loc_120DF:
	lea	ax, [bp+var_124]
	push	ss
	push	ax
	push	[bp+var_10C]
	push	[bp+var_10E]
	call	decryptName
	add	sp, 8
	lea	ax, [bp+var_124]
	push	ss
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	bx, currentLocationMaybe
	mov	al, byte_428A6[bx]
	cbw
	mov	cx, sq_north
	sub	cx, ax
	mov	[bp+var_126], cx
	or	cx, cx
	jnz	short loc_12137
	jmp	loc_121CD
loc_12137:
	mov	ax, offset aAnd_2
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	cmp	[bp+var_126], 0
	jge	short loc_1216A
	mov	ax, [bp+var_126]
	neg	ax
	mov	[bp+var_126], ax
	mov	[bp+var_106], 1
	jmp	short loc_12170
loc_1216A:
	mov	[bp+var_106], 0
loc_12170:
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_126]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, [bp+var_126]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_10A]
	mov	ax, offset aPaceS_1
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+var_106]
	push	dx
	push	ax
	mov	ax, offset aNorthSouth_0
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
loc_121CD:
	mov	bx, currentLocationMaybe
	mov	al, byte_428B0[bx]
	cbw
	mov	cx, sq_east
	sub	cx, ax
	mov	[bp+var_102], cx
	or	cx, cx
	jnz	short loc_121F1
	jmp	loc_1228A
loc_121F1:
	mov	ax, offset aAnd_2
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	cmp	[bp+var_102], 0
	jge	short loc_12227
	mov	ax, [bp+var_102]
	neg	ax
	mov	[bp+var_102], ax
	mov	[bp+var_106], 1
	jmp	short loc_1222D
loc_12227:
	mov	[bp+var_106], 0
loc_1222D:
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_102]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, [bp+var_102]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_10A]
	mov	ax, offset aPaceS_1
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+var_106]
	push	dx
	push	ax
	mov	ax, offset aEastWest_0
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
loc_1228A:
	mov	bx, currentLocationMaybe
	mov	al, byte_428BA[bx]
	cbw
	mov	[bp+var_110], ax
	mov	bl, byte_4EEBA
	sub	bh, bh
	mov	al, byte_428C4[bx]
	cbw
	mov	[bp+var_104], ax
	mov	ax, [bp+var_102]
	or	ax, [bp+var_126]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_108]
	push	[bp+var_10A]
	mov	ax, offset aOfAtThe
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	bx, [bp+var_110]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (locationString+2)[bx]
	push	word ptr locationString[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset aItSNow
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	bx, [bp+var_104]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (timeOfDay+2)[bx]
	push	word ptr timeOfDay[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	mov	sp, bp
	pop	bp
	retf
cmd_printLocation endp

; Attributes: bp-based frame

dropPartyMember	proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aWhoWillYouDrop?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getCharNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_12381
	sub	ax, ax
	jmp	short loc_123C4
loc_12381:
	getCharP	[bp+var_2], bx
	cmp	gs:roster.class[bx], 0Dh
	jnb	short loc_123B4
	mov	ax, offset aYouCanTDropAPart
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	sub	ax, ax
	jmp	short loc_123C4
	jmp	short loc_123BF
loc_123B4:
	push	[bp+var_2]
	call	rost_removeMember
	add	sp, 2
loc_123BF:
	mov	ax, 1
	jmp	short $+2
loc_123C4:
	mov	sp, bp
	pop	bp
	retf
dropPartyMember	endp

; Attributes: bp-based frame

quitGame proc far
	func_enter

	push_ds_string	aQuitTheGame?
	std_call	printStringWClear, 4

	call	getYesNo
	or	ax, ax
	jz	short loc_123FE
	push_ds_string	aYouWillLoseYou
	std_call	printStringWClear, 4
	call	getYesNo
	jmp	short loc_12402
	jmp	short loc_12402
loc_123FE:
	sub	ax, ax
	jmp	short $+2
loc_12402:
	mov	sp, bp
	pop	bp
locret_12405:
	retf
quitGame endp

seg001 ends

