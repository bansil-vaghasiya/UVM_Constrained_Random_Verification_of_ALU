////////////////////////////////////////
// Module : alu_sequence.svh        
// Project : ALU_Driver             
// Task : Creates the ALU Sequence class 
// Author : Bansil Vaghasiya          
////////////////////////////////////////

class alu_sequence extends uvm_sequence #(itm);
	`uvm_object_utils(alu_sequence)
	`uvm_declare_p_sequencer(alu_sequencer)
		
	function new(string name = "alu_sequence");
		super.new(name);
	endfunction : new 
	
	
	task body();
		itm trx;
		trx = itm::type_id::create("trx");
		
		
		// creating test to check the carry
		$display("Generating 500 patterns to test the carry from bit 5 to bit 6 in a 8 bit ALU");		
		repeat(500) begin 
			start_item(trx);
			//$display("Inside start test 1");
			trx.randomize() with {trx.ctl == 2'b01; (((trx.a[5]^trx.b[5]) && (trx.a[4:0] + trx.b[4:0] > 31)) || (trx.a[5] == 1 && trx.b == 1)); trx.stopin == 1'b0; trx.pushin == 1'b1;};
			trx.rst = 0;
			finish_item(trx);
		end
		
		// creating test to text the XOR
		$display("Generating patterns to text bit XOR");
		repeat(500) begin 
			start_item(trx);
			trx.randomize() with {(trx.ctl == 2'b11); trx.stopin == 1'b0; trx.pushin == 1'b1;};
			finish_item(trx);
			//$display("finished test 1");
		end
		
	endtask : body
	

endclass : alu_sequence
