`ifndef control_unit
`define control_unit


`include "opcodes.v"
`include "imm.v"


`define R_type 7'b0110011
`define I_type_op 7'b0010011 //I_type operation
`define I_type_ld 7'b0000011 //I_type load




module control_unit (

    input [31:0] instr_in,


    output reg valid_out,
    output reg rs1_read_out,
    output reg rs2_read_out,
    output reg [5:0] imm_out,
    output reg [6:0] alu_op_out,
    output reg [2:0] alu_sub_sra_out,
    output reg [3:0] alu_src1_out,            //type src1 (reg)
    output reg [3:0] alu_src2_out,           // type src2 (reg, imm ...)
    output reg rd_write_out

  );


 always @* begin

      valid_out = 0;
      rs1_read_out = 0;
      rs2_read_out = 0;
      imm_out = 6'bx;
      alu_op_out = 7'bx;
      alu_sub_sra_out = 2'bx;
      alu_src1_out = 4'bx;
      alu_src2_out = 4'bx;
      rd_write_out = 0;


 casez (instr_in)
  `INSTR_ADDI: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SLTI: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SLTIU: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_XORI: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_ORI: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_ANDI: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SLLI: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SRLI: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SRAI: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `IMM_I;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_ADD: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SUB: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end

  `INSTR_SLL: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SLT: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SLTU: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_XOR: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out =  `R_type;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SRL: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SRA: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_OR: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_AND: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 2;
                 alu_op_out = `R_type;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end


             endcase
         end
     endmodule
`endif
