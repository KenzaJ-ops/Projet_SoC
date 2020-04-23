`ifndef execute
`define execute

`define I_type_ld 7'b0000011 //I_type load
`define S_type 7'b0100011

module execute(
  input req,

  input stall_in,
  //input flush_in,

  input [6:0] alu_opcode_in,
  input [2:0] alu_funct3,
  input [6:0] alu_funct7,

  input [31:0] rs1_value_in,
  input [31:0] rs2_value_in,
  input [31:0] imm_value_in,
  input [31:0] pc_co_in,
  //
  input  reg [4:0] rd_in,

  output reg rd_write,
  output reg [4:0] rd_out,
  //

  output reg alu_non_zero_out,

  output reg [31:0] result_out,
  output reg [31:0] lsu_out,


  output reg [31:0] branch_pc_out,
  output reg branch_mispredicted_out

  );

  reg [31:0] rs1_value; //?????
  reg [31:0] rs2_value; //?????


  reg alu_non_zero;
  reg [31:0] alu_result;



  /*always @ * begin
    if(!stall_in) begin
    rd_write = 1'b0;
    result_out = alu_result;
    rd_out = rd_in;
    alu_non_zero_out <= alu_non_zero;

    end
  end*/
  alu alu(
    .opcode_in(alu_opcode_in),
    .funct3(alu_funct3),
    .funct7(alu_funct7),

    .rs1_value_in(rs1_value_in),
    .rs2_value_in(rs2_value_in),
    .imm_value_in(imm_value_in),

    .non_zero_out(alu_non_zero),

    .result_out(alu_result)
    );



    reg [31:0] branch_pc;

    branch_pc branch (
        .opcode(alu_opcode_in),
        .pc_in(pc_co_in),
        .funct3(alu_funct3),
        .rs1_value_in(rs1_value_in),
        .rs2_value_in(rs2_value_in),
        .imm_value_in(imm_value_in),

        .pc_out(branch_pc_out),
        .branch_mispredicted_out(branch_mispredicted_out)

    );

    always @ ( * ) begin
          if (alu_opcode_in == `I_type_ld || alu_opcode_in == `S_type)
          lsu_out = alu_result;
    end

   always @(posedge req) begin
      if(!stall_in) begin
      rd_write <= 1'b0;
      result_out <= alu_result;
      rd_out <= rd_in;
      alu_non_zero_out <= alu_non_zero;
      end
    end
endmodule

`endif
