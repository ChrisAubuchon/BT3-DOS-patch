\masm32\bin\ml /c /Fo thief.obj thief.asm
\masm32\bin\link thief.obj,thiefp.exe,nul.map,,nul.def
copy thiefp.exe \bard3
cd \bard3
