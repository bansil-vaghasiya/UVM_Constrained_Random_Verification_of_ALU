////////////////////////////////////////
// Module : defs.svh
// Project : ALU_Driver             
// Task : Creates the ALU transaction 
// Author : Bansil Vaghasiya          
////////////////////////////////////////

class itm extends uvm_sequence_item;
	`uvm_object_utils(itm)
	// random inputs 
	rand logic [7:0] a;
	rand logic [7:0] b;
	rand logic pushin;
	rand logic stopin;
	rand logic ci;
	rand logic [1:0] ctl;
	bit rst;
	// outputs
	bit stopout;
	bit pushout;
	bit cout;
	bit [7:0] z; 
	
	function new (string name = "itm");
		super.new(name);
	endfunction : new
	

endclass : itm

