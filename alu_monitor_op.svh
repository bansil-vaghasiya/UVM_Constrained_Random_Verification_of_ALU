////////////////////////////////////////
// Module : alu_monitor_op.svh
// Project : ALU_Driver             
// Task : Creates the ALU monitor class for output from DUT
// Author : Bansil Vaghasiya          
////////////////////////////////////////
class alu_monitor_op extends uvm_monitor;
	`uvm_component_utils(alu_monitor_op)
	
	itm trx;
	virtual alu_interface v_inf;
	uvm_analysis_port #(itm) monitor_AP_op;
	
	function new (string name = "alu_monitor_op", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		monitor_AP_op = new("monitor_AP_op", this);
		if(!uvm_config_db #(virtual alu_interface)::get(this, "", "v_inf", v_inf))
			begin
			`uvm_fatal(get_type_name(), "Did not get the handle to virtual interface alu_interface")
			end
	endfunction : build_phase
	
	virtual task run_phase(uvm_phase phase);
		forever begin 
			trx = itm::type_id::create("trx", this);
				@(posedge v_inf.monitor_op.clk);
				trx.z = v_inf.monitor_op.z;
				trx.cout = v_inf.monitor_op.cout;
				trx.pushout = v_inf.monitor_op.pushout;
				trx.stopout = v_inf.monitor_op.stopout;
				monitor_AP_op.write(trx);
			end
	endtask : run_phase
endclass : alu_monitor_op
				
	

