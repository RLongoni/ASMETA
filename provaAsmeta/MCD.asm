/* Euclide MCD (internal values)*/
/* HEADER --------------*/
asm MCD
// import ../LIB/StandardLibrary
import StandardLibrary

signature: 
	dynamic controlled numA: Integer
	dynamic controlled numB: Integer
	dynamic monitored numAinit : Integer
	dynamic monitored numBinit : Integer
/* BODY --------------*/
definitions: 
// Main rule
	main rule r_Main = 
		if(numA != numB) then 
			if(numA > numB) then 
				numA := numA - numB
			else 
				numB := numB - numA
			endif
		endif

/* Initialization */
default init s0: 
function numA = numAinit
function numB = numBinit

/**/ 