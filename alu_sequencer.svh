////////////////////////////////////////
// Module : alu_sequencer.svh
// Project : ALU_Driver             
// Task : Creates the ALU Sequencer class 
// Author : Bansil Vaghasiya          
////////////////////////////////////////

class alu_sequencer extends uvm_sequencer #(itm);
	`uvm_component_utils(alu_sequencer)
	
	function new (string name = "alu_sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
endclass : alu_sequencer

