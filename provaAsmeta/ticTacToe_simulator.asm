asm ticTacToe_simulator
import StandardLibrary

signature: 
	domain Coord subsetof Integer
	enum domain Sign = {CROSS | NOUGHT}
	enum domain Status = {TURN_USER | TURN_PC}
	
	controlled board: Prod(Coord, Coord) -> Sign // definizione di una funzione
	controlled status: Status
	monitored userChoiceR: Coord // scelta coordinata R dell'utente
	monitored userChoiceC: Coord // scelta coordinata C dell'utente
	derived winner: Sign -> Boolean 
	derived endOfGame: Boolean
	
	/* Le funzioni derivate DEVONO essere definite*/
definitions: 
	domain Coord = {1:3}
	
	function winner ($s in Sign) = 
		(exist $r in Coord with (forall $c in Coord with board($r, $c) = $s)) 
		or
		(exist $c2 in Coord with (forall $r2 in Coord with board($r2, $c2) = $s))
		or 
		(forall $d in Coord with board($d, $d) = $s)
		or 
		(forall $d1 in Coord with board($d1, 4 - $d1) = $s) 

	function endOfGame = 
		(exist $s in Sign with winner($s)) 
		or 
		(forall $r in Coord, $c in Coord with isDef(board($r, $c)))
	
	rule r_moveUser = 
		let ($r = userChoiceR, $c = userChoiceC) in 
			if(isUndef(board($r, $c))) then
				par 
					board($r, $c) := CROSS
					status := TURN_PC
				endpar
			endif
		endlet
		
	rule r_movePC = 
		choose $r in Coord, $c in Coord with isUndef(board($r, $c)) do
			par 
				board($r, $c) := NOUGHT
				status := TURN_USER
			endpar
			
	main rule r_Main = 
	if(not(endOfGame)) then 
		if(status = TURN_USER) then
			r_moveUser[]
		else 
			r_movePC[]
		endif
	endif

default init s0: 
	function status = TURN_USER 