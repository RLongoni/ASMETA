/*Esercizio introduttivo ASMETA*/
asm prova // il nome del file deve essere uguale al nome dopo asm 

// StardardLibrary DEVE essere nella directory del progetto Li
import StandardLibrary // contiene tutte le operazioni di base; la si trova su Ariel

signature:
	dynamic monitored foo: Integer
	dynamic controlled boo: Integer 
	
definitions: 
//definizioni dei domini e funzioni statiche ecc..
	main rule r_main=  
		boo := foo
	
default init s0: 
	function boo = 1 