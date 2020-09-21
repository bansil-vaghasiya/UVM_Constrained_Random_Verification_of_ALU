////////////////////////////////////////
// Module : alu_scoreboard.svh
// Project : ALU_Driver             
// Task : Creates the ALU scoreboard class 
// Author : Bansil Vaghasiya          
////////////////////////////////////////
class alu_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(alu_scoreboard)
	
	reg [8:0] actual_op, golden_op;
	
	function new (string name = "alu_scoreboard", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	uvm_analysis_export #(itm) alu_actual;     // received outputs
	uvm_analysis_export #(itm) alu_golden;     // golden outputs
	
	uvm_tlm_analysis_fifo #(itm) fifo_actual;  // store received outputs
	uvm_tlm_analysis_fifo #(itm) fifo_golden;  // store golden outputs
	
	itm trx_actual;                            // for actual data
	itm trx_golden;                            // for golden reference data
	  
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		alu_actual = new("alu_actual", this);
		alu_golden = new("alu_golden", this);
		fifo_actual = new("fifo_actual", this);
		fifo_golden = new("fifo_golden", this);
	endfunction : build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		alu_actual.connect(fifo_actual.analysis_export);
		alu_golden.connect(fifo_golden.analysis_export);
	endfunction : connect_phase
	
	task run_phase(uvm_phase phase);
	trx_actual = itm::type_id::create("trx_actual", this);
	trx_golden = itm::type_id::create("trx_golden", this);
	fifo_actual.get(trx_actual);
	fork
	forever begin
	fifo_actual.get(trx_actual);
	fifo_golden.get(trx_golden);
		if(trx_actual.pushout) begin
			case(trx_golden.ctl)
				0: golden_op = {1'b0, trx_golden.a};
				1: golden_op = trx_golden.a + trx_golden.b + {7'b0, trx_golden.ci};
				2: golden_op = {1'b0, trx_golden.a} - {1'b0, trx_golden.b} + {7'b0, trx_golden.ci};
				3: golden_op = trx_golden.a^trx_golden.b;
				default: `uvm_info("DEFAULT", "ALU in default mode", UVM_LOW)
			endcase
			
			actual_op = {trx_actual.cout, trx_actual.z};
			
			if(actual_op == golden_op)
				begin
				`uvm_info("RESULT", $sformatf("Test SUCCESSFUL ---- Control = %b Golden output = %b, Recieved output = %b", trx_golden.ctl, golden_op, actual_op), UVM_MEDIUM)
				end
			else begin
			`uvm_info("RESULT", $sformatf("Test FAILED ---- control = %b Golden output = %b Recieved output = %b", trx_golden.ctl, golden_op, actual_op), UVM_MEDIUM)
			end
		end
	end			
	join_none;
	
	endtask : run_phase

endclass : alu_scoreboard
		
		
		
	
