////////////////////////////////////////
// Module : alu_test.svh        
// Project : ALU_Driver            
// Task : Creates the ALU test class 
// Author : Bansil Vaghasiya          
////////////////////////////////////////
class alu_test extends uvm_test;
	`uvm_component_utils(alu_test)

	virtual alu_interface v_inf;	
	alu_environment env;
	
	function new (string name = "alu_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = alu_environment::type_id::create("env", this);
		if(!uvm_config_db #(virtual alu_interface)::get(this, "", "v_inf", v_inf)) 
			begin
				`uvm_fatal(get_type_name(), "Did not get the handle to virtual interface alu_interface")
			end
		uvm_config_db #(virtual alu_interface)::set(this, "env", "v_inf", v_inf);
	endfunction : build_phase
	
	task run_phase(uvm_phase phase);
		alu_sequence sqr;	
		phase.raise_objection(this);
		sqr = alu_sequence::type_id::create("sqr", this);
		sqr.start(env.agnt.seq);
		#100;
		phase.drop_objection(this);
	endtask : run_phase
	
endclass : alu_test
