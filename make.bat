\masm32\bin\ml /c /Fo thief.obj thief.asm
\masm32\bin\link16 thief.obj,thiefp.exe,nul.map,.lib,nul.def
copy thiefp.exe \users\Sparky\dosbox\bard3
