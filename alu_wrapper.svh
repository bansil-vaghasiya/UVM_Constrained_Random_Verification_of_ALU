////////////////////////////////////////
// Module : alu_wrapper.svh        
// Project : ALU_Driver            
// Task : Creates the ALU wrapper module 
// Author : Bansil Vaghasiya          
////////////////////////////////////////


`include "/home/014552590/ALU_driver/duts/alu0.svp"


module alu_wrap(alu_interface.alu alu_inf);

alu alu_dut(.clk(alu_inf.clk), .rst(alu_inf.rst), .pushin(alu_inf.pushin), .stopout(alu_inf.stopout), .ctl(alu_inf.ctl), .a(alu_inf.a), .b(alu_inf.b), .ci(alu_inf.ci), .pushout(alu_inf.pushout), .cout(alu_inf.cout), .z(alu_inf.z), .stopin(alu_inf.stopin));

endmodule : alu_wrap

