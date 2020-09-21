////////////////////////////////////////
// Module : alu_monitor.svh
// Project : ALU_Driver             
// Task : Creates the ALU monitor class for Inputs to DUT
// Author : Bansil Vaghasiya          
////////////////////////////////////////
class alu_monitor extends uvm_monitor;
	`uvm_component_utils(alu_monitor)
	
	itm trx;
	virtual alu_interface v_inf;
	uvm_analysis_port #(itm) monitor_AP;
	
	function new (string name = "alu_monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		monitor_AP = new("monitor_AP", this);
		if(!uvm_config_db #(virtual alu_interface)::get(this, "", "v_inf", v_inf))
			begin
			`uvm_fatal(get_type_name(), "Did not get the handle to virtual interface alu_interface")
			end
	endfunction : build_phase
	
	virtual task run_phase(uvm_phase phase);
		forever begin 
			trx = itm::type_id::create("trx", this);
			@(posedge v_inf.monitor.clk);
				trx.a = v_inf.monitor.a;
				trx.b = v_inf.monitor.b;
				trx.ci = v_inf.monitor.ci;
				trx.pushin = v_inf.monitor.pushin;
				trx.stopin = v_inf.monitor.stopin;
				trx.ctl = v_inf.monitor.ctl;
				monitor_AP.write(trx);
			end
	endtask : run_phase
endclass : alu_monitor 
				
	

