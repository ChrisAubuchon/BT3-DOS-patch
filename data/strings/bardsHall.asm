s_dragonSong_1	db 'Dragon, dragon,',0Ah
		db 'Why do you lair?',0Ah
		db 'Unfurl your wings, Take to the air!',0Ah
		db 'Soar high above, Far away fly,',0Ah
		db 'Or is that where, You wish to die?',0

s_dragonSong_2	db 'Hawkslayer, Hawkslayer,',0Ah
		db 'Why do you ask? Killing me is a difficult task. My claws are sharp, '
		db 'my fangs sharper yet, And my breath flames, let us not forget.',0

s_dragonSong_3	db 'Dragon, dragon,',0Ah
		db 'Thou art quite strong. Your scales are bright and talons are long, '
		db 'But a duty I have and it is clear: Whatever it takes, I will drive '
		db 'you from here.',0

s_dragonSong_4	db 'Hawkslayer, Hawkslayer,',0Ah
		db 'Such a brief life. Have you no wish to again see your wife? '
		db 'Imagine her tears and grief and despair, Walk away from this fight, '
		db 'you have not a prayer.',0

s_dragonSong_5	db 'Dragon, dragon,',0Ah
		db 'How wise thou art.',0Ah
		db 'A massive beast with such a kind heart.',0Ah
		db 'I do wish to kiss my wife and my heir,',0Ah
		db '"Pray, fly to the mountains and await me there.',0

s_dragonSong_6	db 'Hawkslayer, Hawkslayer,',0Ah
		db 'I thought you were brave. Here I await you, deep in this cave. '
		db 'Come, little man, and I',27h,'ll eat your brain, Then ravage '
		db 'Lucencia again and again.',0

s_dragonSong_7	db 'Dragon, dragon,',0Ah
		db 'Great is your heart. Massive your body, but you are not smart. '
		db 'The rumble you hear and the dust in the air? I',27h,'ve closed the '
		db 'cave off and trapped you in there.',0

s_dragonSong_8	db 'Hawkslayer, Hawkslayer,',0Ah
		db 'Others will come.',0Ah
		db 'I will wait but I will not succumb.',0Ah
		db 'Hero you are, and incredibly sly,',0Ah
		db 'But the future I know and a hero you',27h,'ll die...',0

s_flowerBallad_1	db 'He was born with the red, red rose, Sign of his blood, '
			db 'was the link to the past.',0

s_flowerBallad_2	db 'In battle, he won the blue, blue rose, Blossom of his valor, '
			db 'his weapons were cast.',0

s_flowerBallad_3	db 'She was for him the yellow, yellow rose, Her spirit divine, '
			db 'his love would always last.',0

s_flowerBallad_4	db 'His pledge he made o',27h,'er the white, white rose, And she '
			db 'accepted it as sooth, and remained his steadfast.',0

s_flowerBallad_5	db 'So he made for her the rainbow rose, Like Alliria',27h,'s '
			db 'beauty, a blossom unsurpassed.',0

s_galeOfGods_1	db 'Mad god, bad god,',0Ah
		db 'Thrust from the sky,',0Ah
		db 'Foolish god, ghoulish god.',0Ah
		db 'We can',27h,'t hear you cry.',0

s_galeOfGods_2	db 'Rude god, crude god,',0Ah
		db 'Why must you terrify?',0Ah
		db 'Error god, terror god,',0Ah
		db 'Do not your future scry.',0

s_galeOfGods_3	db 'Clever god, never god,',0Ah
		db 'Your time is nigh.',0Ah
		db 'Dire god, liar god,',0Ah
		db 'Why won',27h,'t you just die?',0

s_evilsBane_1	db 'In the land of no time,',0Ah
		db 'The Clock within burns like a flame,',0

s_evilsBane_2	db 'Locking each in his own crime:',0Ah
		db 'One can only leave when he came.',0

s_bardHallGreeting	db 'Welcome and be happy o',27h,' weary travelers! Step to the '
			db 'stage and listen to my tales.',0Ah,0Ah
			db 'You can:',0Ah,0Ah
			db 'Listen to the bard',0Ah
			db 'Exit the hall',0
s_songTitleList	db 'These are the songs I know...',0Ah,0Ah
		db '@Dragon Song',0Ah
		db '@Flower Ballad',0Ah
		db '@Kiel',27h,'s Overture',0Ah
		db '@Gale of Gods',0Ah
		db '@Evil',27h,'s Bane',0Ah
		db '@Minstrel Shield',0

g_bardSongLyricsList	dd g_dragonSongLyricList		;   0
			dd g_flowerBalladLyricList		;   1
			dd 0					;   2
			dd g_galeOfGodsLyricList		;   3
			dd g_evilsBaneLyricList			;   4
			dd 0					;   5

g_dragonSongLyricList	dd s_dragonSong_1
			dd s_dragonSong_2
			dd s_dragonSong_3
			dd s_dragonSong_4
			dd s_dragonSong_5
			dd s_dragonSong_6
			dd s_dragonSong_7
			dd s_dragonSong_8

g_flowerBalladLyricList	dd s_flowerBallad_1
			dd s_flowerBallad_2
			dd s_flowerBallad_3
			dd s_flowerBallad_4
			dd s_flowerBallad_5

g_galeOfGodsLyricList	dd s_galeOfGods_1
			dd s_galeOfGods_2
			dd s_galeOfGods_3

g_evilsBaneLyricList	dd s_evilsBane_1
			dd s_evilsBane_2

s_bardSmiles	db 'The bard smiles and says, "That one will cost thee for your '
		db 'bards will learn the magic of my song."',0
s_itWillCostYou	db '"It will cost you ',0
s_bardPlaysSong	db 'The bard plays the song and you memorize the lines.',0
s_bardsHall	db 'Bard',27h,'s Hall',0
