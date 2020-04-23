`ifndef control_unit
`define control_unit


`include "opcodes.sv"
`include "imm.sv"

//TYPES
`define R_type 7'b0110011
`define I_type_op 7'b0010011  //I_type operation
`define I_type_ld 7'b0000011  //I_type load
`define U_type 7'b0110111
`define B_type 7'b1100011
`define J_type 7'b1101111
`define S_type 7'b0100011
`define NOP_type 7'b0000000

//BRANCH
`define BRANCH_OP_NEVER    4'b0000
`define BRANCH_OP_ZERO     4'b0101
`define BRANCH_OP_NON_ZERO 4'b1010
`define BRANCH_OP_ALWAYS   4'b1111


//MEMOIRE
`define MEM_WIDTH_WORD 4'b0000
`define MEM_WIDTH_HALF 4'b0101
`define MEM_WIDTH_BYTE 4'b1010

module control_unit

(

    input [31:0] instr_in,


    output reg valid_out,
    output reg rs1_read_out,
    output reg rs2_read_out,
    output reg [6:0] imm_out,
    output reg [6:0] alu_op_out,
    output reg [2:0] alu_sub_sra_out,
    output reg [3:0] alu_src1_out,            //type src1 (reg)
    output reg [3:0] alu_src2_out,           // type src2 (reg, imm ...)
    output reg rd_write_out,

    output reg mem_read_out,
    output reg mem_write_out,
    output reg [3:0] mem_width_out,
    output reg mem_zero_extend_out, // 1 si zero extends 0 sinon

    output reg [3:0] branch_op_out
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

      mem_read_out = 0;
      mem_write_out = 0;
      mem_width_out = 4'bx;
      mem_zero_extend_out = 1'bx;

      branch_op_out = `BRANCH_OP_NEVER;


 casez (instr_in)
  `INSTR_ADDI: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SLTI: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SLTIU: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_XORI: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_ORI: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_ANDI: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SLLI: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SRLI: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_SRAI: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `I_type_op;
                 alu_op_out = `I_type_op;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0101;
                 rd_write_out = 1;
             end
  `INSTR_ADD: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SUB: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end

  `INSTR_SLL: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SLT: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SLTU: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_XOR: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out =  `R_type;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SRL: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_SRA: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_OR: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end
  `INSTR_AND: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 alu_op_out = `R_type;
                 alu_src1_out = 4'b0000;
                 alu_src2_out = 4'b0000;
                 rd_write_out = 1;
             end


//new

   `INSTR_LUI: begin
                 valid_out = 0;
                 imm_out = `U_type;
                 alu_op_out = `U_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b1010; //ZERO
                 alu_src2_out = 4'b0101; //IMM
                 rd_write_out = 1;
             end
   `INSTR_AUIPC: begin
                 valid_out = 0;
                 imm_out = `U_type;
                 alu_op_out = `U_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0101; //PC
                 alu_src2_out = 4'b0101; //IMM
                 rd_write_out = 1;
             end
    `INSTR_JAL: begin
                 valid_out = 0;
                 imm_out = `J_type;
                 alu_op_out = `J_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0101; //PC
                 alu_src2_out = 4'b1010; //4
                 branch_op_out = `BRANCH_OP_ALWAYS;
                 rd_write_out = 1;
             end
     `INSTR_JALR: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 imm_out = `J_type;
                 alu_op_out = `J_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0101; //PC
                 alu_src2_out = 4'b1010; //4
                 branch_op_out = `BRANCH_OP_ALWAYS;
                 rd_write_out = 1;
             end
      `INSTR_BEQ: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `B_type;
                 alu_op_out = `B_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out = 4'b0000; //REG
                 branch_op_out = `BRANCH_OP_ZERO;
             end
      `INSTR_BNE: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `B_type;
                 alu_op_out = `B_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out = 4'b0000; //REG
                 branch_op_out = `BRANCH_OP_NON_ZERO;
             end
      `INSTR_BLT: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `B_type;
                 alu_op_out = `B_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out = 4'b0000; //REG
                 branch_op_out = `BRANCH_OP_NON_ZERO;
             end
      `INSTR_BGE: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `B_type;
                 alu_op_out = `B_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out = 4'b0000; //REG
                 branch_op_out = `BRANCH_OP_ZERO;
             end
      `INSTR_BLTU: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `B_type;
                 alu_op_out = `B_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out = 4'b0000; //REG
                 branch_op_out = `BRANCH_OP_NON_ZERO;
             end
      `INSTR_BGEU: begin
                 valid_out = 0;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `B_type;
                 alu_op_out = `B_type;
                 alu_sub_sra_out = 1;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out = 4'b0000; //REG
                 branch_op_out = `BRANCH_OP_ZERO;
             end
      `INSTR_LB: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `I_type_ld;
                 alu_op_out = `I_type_ld;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out =  4'b0101; //IMM
                 mem_read_out = 1;
                 mem_width_out = `MEM_WIDTH_BYTE;
                 mem_zero_extend_out = 0;
                 rd_write_out = 1;
             end
      `INSTR_LH: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `I_type_ld;
                 alu_op_out = `I_type_ld;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out =  4'b0101; //IMM
                 mem_read_out = 1;
                 mem_width_out = `MEM_WIDTH_HALF;
                 mem_zero_extend_out = 0;
                 rd_write_out = 1;
             end
      `INSTR_LW: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `I_type_ld;
                 alu_op_out = `I_type_ld;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out =  4'b0101; //IMM
                 mem_read_out = 1;
                 mem_width_out = `MEM_WIDTH_WORD;
                 rd_write_out = 1;
             end
      `INSTR_LBU: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `I_type_ld;
                 alu_op_out = `I_type_ld;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out =  4'b0101; //IMM
                 mem_read_out = 1;
                 mem_width_out = `MEM_WIDTH_BYTE;
                 mem_zero_extend_out = 1;
                 rd_write_out = 1;
             end
      `INSTR_LHU: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 imm_out = `I_type_ld;
                 alu_op_out = `I_type_ld;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out =  4'b0101; //IMM
                 mem_read_out = 1;
                 mem_width_out = `MEM_WIDTH_HALF;
                 mem_zero_extend_out = 1;
                 rd_write_out = 1;
             end
      `INSTR_SB: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `S_type;
                 alu_op_out = `S_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out =  4'b0101; //IMM
                 mem_write_out = 1;
                 mem_width_out = `MEM_WIDTH_BYTE;
             end
      `INSTR_SH: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `S_type;
                 alu_op_out = `S_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out =  4'b0101; //IMM
                 mem_write_out = 1;
                 mem_width_out = `MEM_WIDTH_HALF;
             end
      `INSTR_SW: begin
                 valid_out = 1;
                 rs1_read_out = 1;
                 rs2_read_out = 1;
                 imm_out = `S_type;
                 alu_op_out = `S_type;
                 alu_sub_sra_out = 0;
                 alu_src1_out = 4'b0000; //REG
                 alu_src2_out =  4'b0101; //IMM
                 mem_write_out = 1;
                 mem_width_out = `MEM_WIDTH_WORD;
             end

      `INSTR_NOP: begin
                            valid_out = 0;
                            rs1_read_out = 1;
                            imm_out = `NOP_type;
                            alu_op_out = `I_type_op;
                            alu_sub_sra_out = 0;
                            alu_src1_out = 4'b0000;
                            alu_src2_out = 4'b0101;
                            rd_write_out = 1;
                  end
             endcase
         end
     endmodule
`endif
