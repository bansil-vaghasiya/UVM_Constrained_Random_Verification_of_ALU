////////////////////////////////////////
// Module : alu_environment.svh class        
// Project : ALU_Driver             
// Task : Creates the ALU environment class 
// Author : Bansil Vaghasiya          
////////////////////////////////////////
class alu_environment extends uvm_env;
	`uvm_component_utils(alu_environment)
	
	alu_agent agnt;
	alu_agent_op agnt_op;
	alu_scoreboard sb;
	
	virtual alu_interface v_inf;
	
	function new (string name = "alu_environment", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt = alu_agent::type_id::create("agnt", this);
		agnt_op = alu_agent_op::type_id::create("agnt_op", this);
		sb = alu_scoreboard::type_id::create("sb", this);
		if(!uvm_config_db #(virtual alu_interface)::get(this, "", "v_inf", v_inf)) 
			begin
				`uvm_fatal(get_type_name(), "Did not get the handle to virtual interface alu_interface")
			end
		uvm_config_db #(virtual alu_interface)::set(this, "agnt", "v_inf", v_inf);
		uvm_config_db #(virtual alu_interface)::set(this, "agnt_op", "v_inf", v_inf);
	endfunction : build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agnt.agent_AP.connect(sb.alu_golden);
		agnt_op.agent_AP_op.connect(sb.alu_actual);
	endfunction : connect_phase
	
endclass : alu_environment
