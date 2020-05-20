asm ferryman_simulator

import StandardLibrary

signature: 
	enum domain Actors = {FERRYMAN | GOAT | CABBAGE | WOLF}
	enum domain Side = {LEFT | RIGHT}
	dynamic controlled position: Actors -> Side 
	dynamic monitored carry: Actors 
	derived oppositeSide: Side -> Side

definitions: 
	
	function oppositeSide($s in Side) = 
		if($s = LEFT) then RIGHT
		else LEFT 
		endif 
		
	rule r_carry($a in Actors) = 
		if(position(FERRYMAN) = position($a)) then 
			par 
				position($a) := oppositeSide(position($a))
				position(FERRYMAN) := oppositeSide(position(FERRYMAN))
			endpar
		endif

	main rule r_Main = r_carry[carry]
	
default init s0: 
	function position($a in Actors) = LEFT 