////////////////////////////////////////
// Module : alu_agent_op.svh        
// Project : ALU_Driver             
// Task : Creates the ALU agent class for outputs from DUT
// Author : Bansil Vaghasiya          
////////////////////////////////////////

class alu_agent_op extends uvm_agent;
	`uvm_component_utils(alu_agent_op)
	
	function new (string name = "alu_agent_op", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	alu_monitor_op mon_op;
	
	virtual alu_interface v_inf;
	uvm_analysis_port #(itm) agent_AP_op;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent_AP_op = new("agent_AP_op", this);
		mon_op = alu_monitor_op::type_id::create("mon_op", this);
		if(!uvm_config_db #(virtual alu_interface)::get(this, "", "v_inf", v_inf)) 
			begin
				`uvm_fatal(get_type_name(), "Did not get the handle to virtual interface alu_interface")
			end
		uvm_config_db #(virtual alu_interface)::set(this, "mon_op", "v_inf", v_inf);
	endfunction : build_phase
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		mon_op.monitor_AP_op.connect(agent_AP_op);
	endfunction : connect_phase
	
endclass : alu_agent_op
	
	

	



