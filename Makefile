all: thief.asm

thief.asm: thief.m4
	m4 -Im4 < thief.m4 > thief.asm

.PHONY: thief.asm
