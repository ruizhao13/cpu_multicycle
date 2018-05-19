`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2018 03:52:59 PM
// Design Name: 
// Module Name: control
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

module control(
      input clk,
      input rst_n, 
      output reg PCWrite,
      output reg Branch,
      output reg PCSrc,
      output reg [5:0]ALUControl,
      output reg [1:0]ALUSrcB,
      output reg ALUSrcA,
      output reg RegWrite,
      output reg IorD,
      output reg MemWrite,
      output reg IRWrite,
      input  [5:0]Op,
      input  [5:0]Funct,
      output reg RegDst,
      output reg MemtoReg  
    );
    parameter	A_NOP	= 3'b000;	 	
    //parameter	A_ADD	= 5'h01;
    parameter   A_ADD 	= 6'b100_000;	
    parameter	A_SUB	= 6'b100010;	
    parameter	A_AND 	= 6'b100100;
    parameter	A_OR  	= 6'b100101;
    parameter	A_XOR 	= 6'b100110;
    parameter	A_NOR   = 6'b100111;
    parameter    IS_POSIT = 6'b111111;


    reg	[3:0]	curr_state, next_state;
    parameter S0 = 4'b0000; //Instruction Fetch
	parameter S1 = 4'b0001; //Instruction Decode
	parameter S2 = 4'b0010;
	parameter S3 = 4'b0011;
	parameter S4 = 4'b0100;
	parameter S5 = 4'b0101;
	parameter S6 = 4'b0110;
	parameter S7 = 4'b0111;
	parameter S8 = 4'b1000;
	parameter S9 = 4'b1001;  //Memory Write	
	parameter S10 = 4'b1010; //Register Write
	parameter S11 = 4'b1011;
	parameter S12 = 4'b1100;
	parameter S13 = 4'b1101;
	parameter S14 = 4'b1110;
    
    
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter R_type = 6'b000_000;
    parameter BEQ = 6'b000100;
    parameter ADDI = 6'b001000;

    always @(posedge clk, negedge rst_n)
    begin
    if (~rst_n) begin
      curr_state <= S0;
    end else begin
        curr_state <= next_state;      
    end
    end

    always @ *
    begin
      case (curr_state)
        S0: next_state <= S1;
        S1: next_state <= S2;
        S2: begin
          if (Op == LW || Op == SW) begin
            next_state <= S3;
          end else if (Op == R_type) begin
            next_state <= S8;
          end else if (Op == BEQ) begin
            next_state <= S10;
          end else begin
            
          end
        end
        S3: begin
          if (Op == LW) begin
            next_state <= S4;
          end else if (Op == SW) begin
            next_state <= S7;
          end else if (Op == ADDI) begin
            next_state <= S11;
          end
        end
        S4: next_state <= S5;
        S5: next_state <= S6;
        S6: next_state <= S0;
        S7: next_state <= S0;
        S8: next_state <= S9;
        S9: next_state <= S0;
        S10: next_state <= S0;
        S11: next_state <= S12;
        S12: next_state <= S0;
        default: next_state = S0;
      endcase
    end





    always@(posedge clk, negedge rst_n)
    begin
      if (~rst_n) begin
        
      end else if (next_state == S0) begin
        PCWrite <= 0;
        Branch <= 0;
        PCSrc  <= 0;
        ALUControl  <= A_ADD;
        ALUSrcB <= 2'b01;
        ALUSrcA <= 0;
        RegWrite <= 0;
        IorD <= 0;  //Adr <- PC
        MemWrite <= 0;
        IRWrite <= 0;
        //RegDst <= 
        //MemtoReg 
      end else if (next_state == S1) begin
        PCWrite <= 1;   //PC = PC + 4
        Branch <= 0;
        PCSrc  <= 0;
        ALUControl  <= A_ADD;
        ALUSrcB <= 2'b01;
        ALUSrcA <= 0;
        RegWrite <= 0;
        IorD <= 0;
        MemWrite <= 0;
        IRWrite <= 1; //ins <- M[PC]
        //RegDst <= 
        //MemtoReg 
      end else if (next_state == S2) begin//instr update done which means a1, a2, a3 update done
        PCWrite <= 0;
        Branch <= 0;
        //PCSrc  <= 0;
        ALUControl  <= A_ADD;
        ALUSrcB <= 2'b11;
        ALUSrcA <= 0;
        RegWrite <= 0;
        //IorD <= 0;
        MemWrite <= 0;
        IRWrite <= 0;
        //RegDst <= 
        //MemtoReg 
        
      end else if (next_state == S3)begin//A, B, ALURESULT update done
        /* LW OR SW */
        PCWrite <= 0;
        Branch <= 0;
        //PCSrc  <= 0;
        ALUControl  <= A_ADD;
        ALUSrcB <= 2'b10;
        ALUSrcA <= 1;
        RegWrite <= 0;
        //IorD <= 0;
        MemWrite <= 0;
        IRWrite <= 0;
        //RegDst <= 
        //MemtoReg 
      end else if (next_state == S4) begin//ALUOUT IS DONE
        PCWrite <= 0;
        Branch <= 0;
        //PCSrc  <= 0;
        ALUControl  <= A_ADD;
        ALUSrcB <= 2'b10;
        ALUSrcA <= 1;
        RegWrite <= 0;
        IorD <= 1;
        MemWrite <= 0;
        IRWrite <= 0;
        //RegDst <= 
        //MemtoReg 
      end else if (next_state == S5) begin//
        PCWrite <= 0;
        Branch <= 0;
        //PCSrc  <= 0;
        ALUControl  <= A_ADD;
        ALUSrcB <= 2'b01;
        ALUSrcA <= 0;
        RegWrite <= 0;
        IorD <= 1;
        MemWrite <= 0;
        IRWrite <= 0;
        //RegDst <= 
        //MemtoReg 
      end else if (next_state == S6) begin//Data update done
        RegDst <= 0;
        MemtoReg <= 1;
        RegWrite <= 1;
      end else if (next_state == S7) begin//ALUout is done
        IorD <= 1;
        MemWrite <= 1;
        
      end else if (next_state == S8) begin//A, B, ALURESULT update done
        ALUSrcA <= 1;
        ALUSrcB <= 2'b00;
        ALUControl <= Funct;
      end else if (next_state == S9) begin
        RegDst <= 1;
        MemtoReg <= 0;
        RegWrite <= 1;
      end else if (next_state == S10) begin
        ALUSrcA <= 1;
        ALUSrcB <= 2'b00;
        ALUControl <= IS_POSIT;
        PCSrc <= 1;
        Branch <= 1;
      end else if (next_state == S11) begin
        ALUSrcA <= 1;
        ALUSrcB <= 2'b10;
        ALUControl <= A_ADD;
      end else if (next_state == S12) begin
        RegDst <= 0;
        MemtoReg <= 0;
        RegWrite <= 1;
      end 
    end


endmodule