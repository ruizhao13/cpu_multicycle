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
    /*control*/
      wire PCWrite;
      wire Branch;
      wire PCSrc;
      wire [2:0]ALUControl;
      wire [1:0]ALUSrcB;
      wire ALUSrcA;
      wire RegWrite;
      wire lorD;
      wire MemWrite;
      wire IRWrite;
      wire [5:0]Op;
      wire [5:0]Funct; 
      wire RegDst;
      wire MemtoReg; 
    /*conotrol*/

    reg [31:0] PC;
    wire [31:0] PC_NEW;
    wire [4:0]A1, A2, A3;
    wire [31:0] RD1, RD2, WD3;
    wire WE3;
    reg [31:0]instr, A, B, ALUOut, Data;
    wire [31:0]Adr;
    wire [31:0]ALUResult;
    wire Zero;
    wire PCEn;
    wire [31:0] SrcA, SrcB, Signlmm;
    wire [31:0] doutb;


    

    
    assign PCEn = (Zero & Branch) | PCWrite;
    
    assign PC_NEW = PCSrc ? ALUOut : ALUResult;
    always @(posedge clk, negedge rst_n)
    begin
      if (~rst_n) begin
        PC <= 0;
      end else begin
        PC <= PCEn ? PC_NEW : PC;
      end
    end
    
    
    
    
    assign Adr = lorD ? ALUOut : PC;
    memory u_memory (
      .clka(clk),    // input wire clka
      .ena(ena),      // input wire ena
      .wea(MemWrite),      // input wire [0 : 0] wea
      .addra(Adr),  // input wire [7 : 0] addra
      .dina(dina),    // input wire [31 : 0] dina
      .clkb(clk),    // input wire clkb
      .enb(enb),      // input wire enb
      .addrb(Adr),  // input wire [7 : 0] addrb
      .doutb(doutb)  // output wire [31 : 0] doutb
    );
    always@(posedge clk, negedge rst_n)
    begin
      if (rst_n) begin
        instr <= instr; 
        Data <= 0;
      end else begin
        instr <= IRWrite ? doutb : instr;
        Data <= doutb;
      end
    end
    
    assign Signlmm = instr[15] ;
    






















    assign A1 = instr[25:21];
    assign A2 = instr[20:16];
    assign A3 = RegDst ? instr[15:11] : instr[20:16];
    assign WD3 = MemtoReg ? Data : ALUOut;
    assign WE3 = RegWrite;
    REG_FILE u_REG_FILE(
      .clk(clk),
      .rst_n(rst_n),
      .rAddr1(A1),//[4:0]
      .rAddr2(A2),//[4:0]      
      .rDout1(RD1),//[31:0]
      .rDout2(RD2),//[31:0]      
      .wAddr(A3),//[4:0]
      .wDin(WD3),//[31:0]
      .wEna(WE3)
    );
    always@(posedge clk, negedge rst_n)
    begin
      if (~rst_n) begin
        A <= 0;
        B <= 0;
      end else begin
        A <= RD1;
        B <= RD2;
      end
    end

    assign SrcA = ALUSrcA ? A : PC;
    assign SrcB = (ALUSrcB == 2'b00) ? B : (ALUSrcB == 2'b01) ? 4 : (ALUSrcB == 2'b10) ? Signlmm : (ALUSrcB == 2'b11)? Signlmm<<2:0;  
    
    ALU u_ALU(
      .alu_a(SrcA),
      .alu_b(SrcB),
      .alu_op(ALUControl),
      .alu_out(ALUResult),
      .Zero(Zero)
    );
    
    always@(posedge clk, negedge rst_n)
    begin
      if (rst_n) begin
        ALUOut <= 0;  
      end else begin
        ALUOut <= ALUResult;
      end
    end
    
    
    










    assign Op = instr[31:26];
    assign Funct = instr[5:0];
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
      .Funct(Funct),
      .RegDst(RegDst),
      .MemtoReg(MemtoReg)   
    );
endmodule

