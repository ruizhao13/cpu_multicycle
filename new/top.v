`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2018 03:49:21 PM
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst_n
    );
  

    memory u_memory (
      .clka(clk),    // input wire clka
      .ena(ena),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addra),  // input wire [7 : 0] addra
      .dina(dina),    // input wire [31 : 0] dina
      .clkb(clkb),    // input wire clkb
      .enb(enb),      // input wire enb
      .addrb(addrb),  // input wire [7 : 0] addrb
      .doutb(doutb)  // output wire [31 : 0] doutb
    );
    
    
    REG_FILE u_REG_FILE(
      .clk(clk),
      .rst_n(rst_n),
      .rAddr1(instr[25:21]),//[5:0]
      .rAddr2(instr[20:16]),//[5:0]      
      .rDout1(read_data1),//[31:0]
      .rDout2(read_data2),//[31:0]      
      .wAddr(write_reg_addr),//[5:0]
      .wDin(write_reg_data),//[31:0]
      .wEna(RegWrite)
    );
    
    ALU u_ALU(
      .alu_a(read_data1),
      .alu_b(alu_b),
      .alu_op(ALUControl),
      .alu_out(ALU_result)
    );


    control u_control(
      .clk(clk),
      .PCWrite(PCWrite),
      .Branch(Branch),
      .PCSrc(PCSrc),
      .ALUControl(ALUControl),
      .ALUSrcB(ALUSrcB),
      .ALUSrcA(ALUSrcA),
      .RegWrite(RegWrite),
      .lorD(lorD),
      .MemWrite(MemWrite),
      .IRWrite(IRWrite),
      .Op(Op),
      .Funct(Funct) 
      .RegDst(RegDst),
      .MemtoReg(MemtoReg)   
    );
endmodule

