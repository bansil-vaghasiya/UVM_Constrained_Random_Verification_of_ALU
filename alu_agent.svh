////////////////////////////////////////
// Module : alu_agent.svh        
// Project : ALU_Driver             
// Task : Creates the ALU agent class for input to the DUT
// Author : Bansil Vaghasiya          
////////////////////////////////////////

class alu_agent extends uvm_agent;
	`uvm_component_utils(alu_agent)
	
	function new (string name = "alu_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	
	alu_sequencer seq;
	alu_driver drv;
	alu_monitor mon;
	
	virtual alu_interface v_inf;
	uvm_analysis_port #(itm) agent_AP;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent_AP = new("agent_AP", this);
		drv = alu_driver::type_id::create("drv", this);
		seq = alu_sequencer::type_id::create("seq", this);
		mon = alu_monitor::type_id::create("mon", this);
		if(!uvm_config_db #(virtual alu_interface)::get(this, "", "v_inf", v_inf)) 
			begin
				`uvm_fatal(get_type_name(), "Did not get the handle to virtual interface alu_interface")
			end
		uvm_config_db #(virtual alu_interface)::set(this, "drv", "v_inf", v_inf);
		uvm_config_db #(virtual alu_interface)::set(this, "mon", "v_inf", v_inf);
	endfunction : build_phase
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(seq.seq_item_export);
		mon.monitor_AP.connect(agent_AP);
		//uvm_report_info("alu_agent", "Connecting the driver and sequencer classes");
	endfunction : connect_phase
	
endclass : alu_agent
	
	

	



