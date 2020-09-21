////////////////////////////////////////
// Module : alu_interface.svh        
// Project : ALU_Driver             
// Task : Creates the ALU Interface 
// Author : Bansil Vaghasiya          
/////////////////////////////////////////
interface alu_interface();

logic clk;
logic rst;
logic pushin;
logic stopout;
logic [1:0] ctl;
logic [7:0] a;
logic [7:0] b;
logic ci;
logic pushout;
logic cout;
logic [7:0] z;
logic stopin;

/* ALU driver class drives the ALU DUT on every clock edge*/
modport driver(input clk, input rst, output a, output b, output ci, output pushin, output stopin, output ctl);
/* ALU monitor monitors the transaction sent to DUT*/
modport monitor(input clk, input rst, input a, input b, input ci, input pushin, input stopin, input ctl);
/* ALU output monitor monitors the transaction received from DUT*/
modport monitor_op(input clk, input rst, input z, input cout, input pushout, input stopout);
/* modport for ALU duts */
modport alu (input clk, input rst, input pushin, output stopout, input ctl, input a, input b, input ci, output pushout, output cout, output z, input stopin);
endinterface : alu_interface
