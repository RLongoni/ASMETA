asm AlgoritmoEuclide

import ../provaAsmeta/StandardLibrary

// Implementare sottoforma di asm l'algoritmo di eulcide.
// NB:
// controlled -> viene gestito internamente dalla asm, vedile come variabili locali
// monitored -> valori che vengono dati dall'esterno/utente alla asm, come gli input delle fsm
// dynamic -> il valore può cambiare negli stati successivi
// static -> il valore non cambia negli stati successivi


signature: 
	dynamic controlled numeroA: Integer 
	dynamic controlled numeroB: Integer 
	
definitions:

	main rule r_Main = 
		if(numeroA != numeroB) then
			if(numeroA > numeroB) then
				numeroA := numeroA - numeroB
			else 
				numeroB := numeroB - numeroA
			endif
		endif 
		
default init s0: 
	function numeroA = 36
	function numeroB = 6