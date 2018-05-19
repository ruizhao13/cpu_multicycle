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
      wire [1:0]PCSrc;
      wire [5:0]ALUControl;
      wire [1:0]ALUSrcB;
      wire ALUSrcA;
      wire RegWrite;
      wire IorD;
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
    wire [31:0] SrcA, SrcB, SignImm;
    wire [31:0] doutb;


    

    
    assign PCEn = (Zero & Branch) | PCWrite;
    
    assign PC_NEW[31:28] = PCSrc[1]?PC[31:28]:(PCSrc[0]?ALUOut[31:28]:ALUResult[31:28]);
    assign PC_NEW[27:0] = PCSrc[1]?(instr[25:0]<<2):(PCSrc[0]?ALUOut[27:0]:ALUResult[27:0]);
    
    
    
    always @(posedge clk, negedge rst_n)
    begin
      if (~rst_n) begin
        PC <= 0;
      end else begin
        PC <= PCEn ? PC_NEW : PC;
      end
    end
    
    
    
    
    assign Adr = IorD ? ALUOut : PC;
    memory u_memory (
      .clka(clk),    // input wire clka
      .ena(1),      // input wire ena
      .wea(MemWrite),      // input wire [0 : 0] wea
      .addra(Adr>>2),  // input wire [7 : 0] addra
      .dina(B),    // input wire [31 : 0] dina
      .clkb(clk),    // input wire clkb
      .enb(1),      // input wire enb
      .addrb(Adr>>2),  // input wire [7 : 0] addrb
      .doutb(doutb)  // output wire [31 : 0] doutb
    );
    always@(posedge clk, negedge rst_n)
    begin
      if (~rst_n) begin
        instr <= instr; 
        Data <= 0;
      end else begin
        instr <= IRWrite ? doutb : instr;
        Data <= doutb;
      end
    end
    
    assign SignImm[31:16] = (instr[15])? (16'b1111_1111_1111_1111) : (16'b0000_0000_0000_0000);
    assign SignImm[15:0] = instr[15:0]; 






















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
    assign SrcB = (ALUSrcB == 2'b00) ? B : (ALUSrcB == 2'b01) ? 4 : (ALUSrcB == 2'b10) ? SignImm : (ALUSrcB == 2'b11)? SignImm<<2:0;  
    
    ALU u_ALU(
      .alu_a(SrcA),
      .alu_b(SrcB),
      .alu_op(ALUControl),
      .alu_out(ALUResult),
      .Zero(Zero)
    );
    
    always@(posedge clk, negedge rst_n)
    begin
      if (~rst_n) begin
        ALUOut <= 0;  
      end else begin
        ALUOut <= ALUResult;
      end
    end
    
    
    










    assign Op = instr[31:26];
    assign Funct = instr[5:0];
    control u_control(
      .clk(clk),
      .rst_n(rst_n),
      .PCWrite(PCWrite),
      .Branch(Branch),
      .PCSrc(PCSrc),
      .ALUControl(ALUControl),
      .ALUSrcB(ALUSrcB),
      .ALUSrcA(ALUSrcA),
      .RegWrite(RegWrite),
      .IorD(IorD),
      .MemWrite(MemWrite),
      .IRWrite(IRWrite),
      .Op(Op),
      .Funct(Funct),
      .RegDst(RegDst),
      .MemtoReg(MemtoReg)   
    );
endmodule

