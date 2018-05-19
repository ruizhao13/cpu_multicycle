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
  input	            [2:0]	alu_op,
  output   reg      [31:0]	alu_out,
  output   wire			Zero
);
parameter	A_NOP	= 3'b000;	 	
//parameter	A_ADD	= 5'h01;
parameter   A_ADD 	= 3'b010;	
parameter	A_SUB	= 3'b011;	
parameter	A_AND 	= 3'b100;
parameter	A_OR  	= 3'b101;
parameter	A_XOR 	= 3'b110;
parameter	A_NOR   = 3'b111;
//parameter    IS_POSIT = 6'b111111;
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
	//IS_POSIT: alu_out = alu_a - 1;
  	default:  alu_out = 0;
  endcase
end

assign Zero = (alu_out == 4'h0000) ? 1:0;
endmodule

