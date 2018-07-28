s_victoryMessage_1	db '"Welcome, brave heroes. You have succeeded in destroying '
			db 'the threat to all reality. As you know, to do this, you '
			db 'slipped the bonds of time, and traveled forbidden routes '
			db 'through that which has forever been. You pressed your '
			db 'struggle forward despite danger and death, and you '
			db 'accomplished that which the gods themselves were unable to do."'
			db 0Ah,0Ah
			db 'His praise washes over you like a warm ocean wave, and you '
			db 'feel strength infuse your body.',0

s_victoryMessage_2	db '"In doing what you have done, you have proved youself '
			db 'worthy of nothing less than the ultimate reward." He '
			db 'closes his eyes and raises his hands. '
			db '"The death of the gods tore reality asunder, but you '
			db 'bound it up again. The gods of old are dead, therefore '
			db 'I accept you as my new children. You shall be gods yourselves!"'
			db 0Ah,0Ah,0

s_victoryMessage_3	db 'His eyes open again and you look up on infinity. At '
			db 'once you see Skara Brae restored to its former beauty. '
			db 'You see beyond it and the Six cities of the Plains. '
			db 'You see the whole world and each of its cultures, and '
			db 'you realize all of it is now your domain.',0Ah,0Ah,0

s_victoryMessage_4	db '"And so it came to pass that eight new stars burned '
			db 'in the night sky. The least of these, the Companion star, '
			db 'was named Hawkslayer after a hero of legend. '
			db 'The other seven, together known as the Company of Heroes, '
			db 'are each named for one of the New Gods. Each night they '
			db 'can be seen is betokened a good night, and '
			db 'adventurers know these gods smile especially upon them..."',0Ah
			db '-- excerpt from The Gospel of the New Gods (Chap I, Verses 5-9)'
			db 0Ah,0Ah,0Ah,0

s_victoryMessage_5	db 'Your party will now alter time back to the refugee camp.',0Ah
			db 'Who knows what new challenges await you in the future!',0

victoryMessageList	dd s_victoryMessage_1	; 0
			dd s_victoryMessage_2	; 1
			dd s_victoryMessage_3	; 2
			dd s_victoryMessage_4	; 3
			dd s_victoryMessage_5	; 4
