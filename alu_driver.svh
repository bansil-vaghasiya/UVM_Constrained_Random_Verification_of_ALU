////////////////////////////////////////
// Module : ALU_driver.svh
// Project : ALU_Driver             
// Task : Creates the ALU driver class 
// Author : Bansil Vaghasiya          
////////////////////////////////////////

class alu_driver extends uvm_driver #(itm);
	`uvm_component_utils(alu_driver)
	
	virtual alu_interface v_inf;

	 function new (string name = "alu_driver", uvm_component parent = null);
	 	super.new(name, parent);
	 endfunction : new
	 
	 function void build_phase(uvm_phase phase);
	 	super.build_phase(phase);
	 	if(!uvm_config_db #(virtual alu_interface)::get(this, "", "v_inf", v_inf)) 
	 		begin
	 		`uvm_fatal(get_type_name(), "Did not get the handle to virtual interface alu_interface")
	 		end
	 endfunction : build_phase
	  
	 
	 function void connect_phase(uvm_phase phase);
	 	super.connect_phase(phase);
	 endfunction : connect_phase
	 
	 virtual task run_phase(uvm_phase phase);
	 	//trx = new();
	 	super.run_phase(phase);
	 	forever begin 
			itm trx;
	 		seq_item_port.get_next_item(trx);
	 		//$display("Hello got");
	 		@(posedge v_inf.driver.clk);
				//#1;
	 			//$display("Clock seen");
	 			v_inf.driver.a <= trx.a;
	 			v_inf.driver.b <= trx.b;
	 			v_inf.driver.ci <= trx.ci;
	 			v_inf.driver.pushin <= trx.pushin;
	 			v_inf.driver.stopin <= trx.stopin;
	 			v_inf.driver.ctl <= trx.ctl;
	 		seq_item_port.item_done();
	 	end 
	 endtask : run_phase
	 
endclass : alu_driver
