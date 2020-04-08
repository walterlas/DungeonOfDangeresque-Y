#!yab
import gui
dim level(31,81)
dim monstername$(35)
dim monsterhp(35)
dim monsterhm(35)

newgame = true
onload = true
gameloop = true

difficulty = 1
maxlevels = 30
columns = 9

sub delay(seconds)
	pause(seconds)
end sub

sub rnd()
	r = ran()
	return r
end sub

sub getDifficulty()
	d = alert "Difficulty Level:","Moderate","Hard","","none"
	return d
end sub

sub getName$()
	local pname$
	pname$=""
	tprint("Enter your character's name> ")
	while (pname$="")
		pname$ = textcontrol get$ "dodInput"
	wend
	return pname$
end sub

sub getIndex(x,y)
	i	=	x+(columns*y)
	return i
end sub

sub fillArray(endtime)
	local col,row,debug,dothis,lvl
	debug = false
	col = 8
	row = 8
	
	if debug = true then 
		Print "Starting room placement"
	endif 
	
	for dothis = 1 to endtime
		for i = 0 to 81
			level(dothis,i) = int(rnd()*7)+1
		next i
	
		h = int(rnd()*3)+1
		for n = 1 to h
			x = int(rnd()*col)+1
			y = int(rnd()*row)+1
			i = getIndex(x,y)
			level(dothis,i) = 8
		next n
	
		s = int(rnd()*4+1)+2
		for n = 1 to s
			x = int(rnd()*col)+1
			y = int(rnd()*row)+1
			i = getIndex(x,y)
			level(dothis,i) = 9
		next n
	
		if debug = true then
			print "Showing level "+str$(dothis)
			idx = 1
			for x = 1 to 8
				for y = 1 to 8
					print level(dothis,idx);
					idx = idx + 1
				next y
				print
			next x
			print "-----------------------------------------"
		endif
	next dothis
end sub

sub monsterSetup()
	mlevel = 0
	for i = 1 to 34
		read monstername$(i)
	next i
	for i = 1 to 34
		read monsterhp(i)
	next i
	for i = 1 to 34
		read monsterhm(i)
	next i
	
	data "Large Dragon","Hideous Ghoul","Lizard Man","Manticore","Purple Worm","Deadly Cobra","Mad Elf","Clay Man","Hairy Beast","Mad Dwarf","Zombie","Berserker","Giant Scorpion","Giant Cockroach","Doppleganger","Giant Fire Beetle","Giant Ant","Giant Tick","Mummy","Nasty Orc","Skeleton","Troll","Goblin","Vampire Bat","Creeping Blob","Mad Dog","Large Spider","Black Cat","Man Eating Plant","Hydra","Gelatinous Cube","Giant Centipede","Giant Rat","Shadow"
	data 6,5,4,6,6,5,5,4,5,4,4,5,6,4,5,1,1,2,3,2,1,3,3,3,3,2,3,2,1,3,2,1,2,2
	data 12,10,8,12,12,10,10,8,10,8,8,10,12,8,10,2,2,4,6,4,2,6,6,6,6,4,6,4,2,6,4,2,4,4
end sub


sub introTop()
	cls()
	tprintc("The Dungeon of Dangeresque\n")
	tprintc("   For Yab (or Yabasic)\n")
	tprintc("(c) 1980 by Howard Berenbon\n")
	tprintc("Adapted from Atari BASIC verson\n")
	tprintc("Of 'Dungeon of Danger'\n")
	tprintc("\n ")
	tprintc("A Fantasy Game\n")
	tprintc("=-=-=-=-=-=-=-=-=-=-\n")
//	tprintc("You will be teleported to...\n")
	tprintc("\n")
end sub

sub introMiddle()
//	print "The. . . "
//	print "Dungeon of Dangeresque!"
	local intro
	
//	intro = open("./intro.txt","r")
	open "intro.txt" for reading as #1
	while (not eof(1))
		 line input #1 iline$
		 tprint(iline$)
	wend
	close #1
end sub

sub introBottom()
	print "You carry a magic sword and "+str$(gold)+" gold pieces with you."
	print "Your hit-point value is "+str$(playerhp)+"."
	print "If it reaches zero, you will die . . . So be careful!"
	delay(1)
	print name$+" . . . You are on your way to the . . ."
	delay(3)
	open "dod-logo.txt" for reading as #1
	while (not eof(1))
		line input #1 iline$
		print iline$
	wend
	close #1
#	cls()
	print
	print "You have arrived at . . . "
	print "The Dungeon of Danger . . . Level "+str$(currentlevel)
	print " "
	print "You will encounter monsters and thieves and . . . gold."
	print "Good luck!"
	delay(4)
end sub


openWindow()
addTV()
addInput()
addLabels()

while(instr(message$, "Quit") = 0)
//	if onload = true then
//		introTop()
//		introMiddle()
//		onload = false
//	endif

	settingsWindow()
	
	if onload = true then
		introTop()
		monsterSetup()
		onload = false
	endif
	
	if newgame = true then
		introMiddle()
//		difficulty 	= getDifficulty()
		maxlevel	= difficulty*10
		currentlevel= maxlevel
		
		fillArray(maxlevel)
		name$=getName$()
		reset(difficulty)
		teleportactive	= false
		introBottom()
		idx = getIndex(playerx,playery)
		level(currentlevel,idx) = 1
		inroom = level(currentlevel,idx)
		targetKills = int(rnd()*4+1)+4
		newgame = false
		killedby$ = " "
		lives = 1
	endif
	print message$
wend
