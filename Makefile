OBJS=thief.obj

.SUFFIXES: .asm .obj

.asm.obj:
	ml /c /Fo $@ $<

all: thiefp.exe

thiefp.exe: $(OBJS)
	link16 $<,$@,nul.map,.lib,nul.def
#	link16 /exepack $<,$@,nul.map,.lib,nul.def

thief.obj: thief.asm
seg000.obj: seg000.asm

install: thiefp.exe
	cp thiefp.exe /cygdrive/c/Aubuchon/dosbox/patch
