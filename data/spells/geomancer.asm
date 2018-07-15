dnl	A dungeon square is five bytes long. The first two bytes define the walls
dnl	around the square. The last three are reserved for flags. The following array
dnl	holds two bytes:
dnl		1:	Target byte of the square. Offset starts at 0
dnl		2:	Square type bitmask
dnl
dnl	So, for example, geomanSp_t<3, 20h> marks squares with the 20h bit set
dnl	in the minimap.
dnl
g_geomancerSpellMasks	geomanSp_t <3, 20h>	; 0
			geomanSp_t <4, 40h>	; 1
			geomanSp_t <3, 4>	; 2
			geomanSp_t <3, 2>	; 3

dnl	The entries that contain dun_revealSpSquare are linked with the g_geomancerSpellMasks
dnl	array above: g_geomancerSpellList[x] -> g_geomancerSpellMasks[x-1].
dnl
dnl	So Succor Song, which is g_geomancerSpellList index 2, uses:
dnl		g_geomancerSpellMasks[1] -> geomanSp_t <4, 40h>
dnl
g_geomancerSpellList	dd spGeo_removeTrap		; 0: Earth Ward. Remove all traps from level
			dd dun_revealSpSquare		; 1: Sanctuary. Reveal all mage regeneration squares
			dd dun_revealSpSquare		; 2: Succor Song. Reveal party heal squares
			dd dun_revealSpSquare		; 3: Roscoe's Alert. Reveal all anti-magic squares
			dd dun_revealSpSquare		; 4: Earth song. Reveal all drain HP squares
			dd spGeo_revealSquare		; 5: Pathfinder. Reveals all squares to the minimap
