`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2018 03:50:47 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module ALU(
  input  signed	    [31:0]	alu_a,
  input  signed	    [31:0]	alu_b,
  input	            [5:0]	alu_op,
  output   reg      [31:0]	alu_out,
  output   wire			Zero
);
parameter	A_NOP	= 5'h00;	 	
//parameter	A_ADD	= 5'h01;
parameter   A_ADD = 6'b100000;	
parameter	A_SUB	= 5'h02;	
parameter	A_AND 	= 5'h03;
parameter	A_OR  	= 5'h04;
parameter	A_XOR 	= 5'h05;
parameter	A_NOR   = 5'h06;
parameter    IS_POSIT = 6'b111111;
always@(*)
begin
  case (alu_op)
  	A_NOP:  alu_out = 0;
  	A_ADD:  alu_out = alu_a + alu_b;
  	A_SUB:  alu_out = alu_a - alu_b;
  	A_AND:  alu_out = alu_a & alu_b;
  	A_OR:   alu_out = alu_a | alu_b;
  	A_XOR:  alu_out = alu_a ^ alu_b;
  	A_NOR:  alu_out = ~(alu_a | alu_b);
	IS_POSIT: alu_out = alu_a - 1;
  	default:  alu_out = 0;
  endcase
end

assign Zero = (alu_out == 4'h0000) ? 1:0;
endmodule

