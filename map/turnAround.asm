; This function	sets the direction facing in the
; opposite direction. Used when	exiting	buildings.
; If the party was facing north, after this function
; they would be	facing south.
; Attributes: bp-based frame

map_turnAround proc far
	FUNC_ENTER
	mov	ax, g_direction
	add	ax, 2
	and	ax, 3
	mov	g_direction, ax
	FUNC_EXIT
	retf
map_turnAround endp
