// Lo scopo del gioco e quello di sconfiggere l'avversario scegliendo
// un segno (arma) in grado di battere quello dell'altro, secondo le
// seguenti regole:
// 1. Il sasso spezza le forbici (vince il sasso)
// 2. Le forbici tagliano la carta (vincono le forbici)
// 3. La carta avvolge il sasso (vince la carta)
// Se i due giocatori scelgono la stessa arma, il gioco e pari e si gioca di nuovo.
// 
// Creare un modello ASM che permetta di giocare a Morra cinese
// contro il computer. Il modello deve avere le seguenti
// caratteristiche:
// I ogni step della macchina corrisponde ad una singola giocata;
// I l'utente deve avere la possibilita di scegliere uno dei tre simboli;
// I il computer deve scegliere in modo casuale uno dei tre simboli;
// I la macchina deve valutare la giocata e segnalare il vincitore.
asm MorraCinese

import ../provaAsmeta/StandardLibrary

signature: 
	enum domain Scelta = {SASSO | CARTA | FORBICE}
	enum domain Risultato = {PAREGGIO | VINCEGIOCATORE | VINCECOMPUTER}
	dynamic monitored sceltaGiocatore: Scelta
	dynamic controlled sceltaComputer: Scelta 
	dynamic controlled computerChoice: Scelta
	dynamic controlled outMess: String
	static risultatoGiocata: Prod(Scelta, Scelta) -> Risultato
	
definitions:
	
	function risultatoGiocata($sceltapc in Scelta, $sceltagiocatore in Scelta) = 
		if($sceltapc = $sceltagiocatore) then
			PAREGGIO
		else
			switch ($sceltapc, $sceltagiocatore)
	        	case (CARTA, SASSO):
	          		VINCECOMPUTER
	        	case (SASSO, FORBICE):
	          		VINCECOMPUTER
	        	case (FORBICE, CARTA):
	          		VINCECOMPUTER
	        	otherwise
	          		VINCEGIOCATORE
	      	endswitch
      	endif 

	main rule r_main= 
		choose $scelta in Scelta with true do 
			par
				computerChoice:= $scelta
				switch (risultatoGiocata(computerChoice, sceltaGiocatore ))
					case VINCECOMPUTER:
						outMess:="Hai vinto!"
					case VINCEGIOCATORE:
						outMess:="Ha vinto il computer!"
					case PAREGGIO:
						outMess:="Patta"
				endswitch
			endpar
default init s0:
	function outMess=""