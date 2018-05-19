`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2018 03:48:48 PM
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE(
    input clk,
    input rst_n,
    input [4:0] rAddr1,
    input [4:0] rAddr2,
    output [31:0] rDout1,    
    output [31:0] rDout2,
    input [4:0] wAddr,
    input [31:0] wDin,
    input  wEna
    );
    reg [31:0] regfile[0:31];
    
    assign rDout1 = regfile[rAddr1];
    assign rDout2 = regfile[rAddr2];

    integer i;
    always @(posedge clk)begin
      
      if ( ~rst_n ) begin
        regfile[0] <= 1;
        regfile[1] <= 2;
        for (i = 2; i < 32; i = i + 1 ) begin
          regfile[i] <= 3;
        end
      end else begin
        if (wEna) begin
          regfile[wAddr] <= wDin;
        end
      end
    end
endmodule
