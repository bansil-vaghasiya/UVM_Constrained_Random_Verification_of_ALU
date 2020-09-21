////////////////////////////////////////
// Module :  top module        
// Project : ALU_Driver             
// Task : Creates the top module alu_test
// Author : Bansil Vaghasiya          
////////////////////////////////////////
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "defs.svh"
`include "alu_interface.svh"
`include "alu_sequencer.svh"
`include "alu_sequence.svh"
`include "alu_driver.svh"
`include "alu_monitor.svh"
`include "alu_monitor_op.svh"
`include "alu_agent.svh"
`include "alu_agent_op.svh"
`include "alu_scoreboard.svh"
`include "alu_environment.svh"
`include "alu_test.svh"
`include "alu_wrapper.svh"

module top();

alu_interface alu_inf();
alu_wrap dut(alu_inf.alu);

initial begin
	alu_inf.clk = 0;
	forever #5 alu_inf.clk = ~alu_inf.clk;
	#2000;
	$finish;
end

initial begin
	uvm_config_db #(virtual alu_interface)::set(null, "uvm_test_top", "v_inf", alu_inf);
	run_test("alu_test");
end 

endmodule : top 
