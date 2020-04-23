`ifndef alu
`define alu


`define R_type 7'b0110011
`define I_type_op 7'b0010011 //I_type operation
`define I_type_ld 7'b0000011 //I_type load
`define S_type 7'b0100011


module alu(
  input [6:0] opcode_in,
  input [2:0] funct3,
  input [6:0] funct7,


  input [31:0] rs1_value_in,
  input [31:0] rs2_value_in,
  input [31:0] imm_value_in,

  output wire non_zero_out,

  output reg [31:0] result_out
  );
  reg [31:0] src1;
  reg [31:0] src2;

  //detection du signe des operandes
  wire src1_sign;
  wire src2_sign;

  //imm de decalage
  wire [4:0] shift;
  //wire [6:0] fct_imm;

  // la sortie des oprerations add sub srl sra en R_type et I_type
  wire [31:0] srl_sra;
  wire [32:0] add_sub;
  // definition d'une variable qui modelise le fait qu'on a funct7 = 0x20
  wire sub_or_sra;
  assign sub_or_sra = (funct7 == 7'h20 || imm_value_in[11:5] == 7'h20)? 1'b0 : 1'b1;

  wire carry;
  wire sign;
  wire ovf;

  //less then
  wire lt;
  wire ltu;

  always @* begin // affectation des operandes
        case (opcode_in)
            `R_type:  begin
                      src1 = rs1_value_in;
                      src2 = rs2_value_in;
                      end
            `I_type_op, `I_type_ld, `S_type: begin
                                      src1 = rs1_value_in;
                                      src2 = imm_value_in;
                                      end
        endcase
  end

  //detection de signe
  assign src1_sign = src1[31];
  assign src2_sign = src2[31];

  assign shift = src2[4:0];

  assign add_sub = sub_or_sra ? src1 + src2 : src1 - src2;
  assign srl_sra = (opcode_in == `R_type)? ($signed({sub_or_sra ? 1'b1 : src1_sign , src1}) >>> src2) : ($signed({sub_or_sra ? 1'b1 : src1_sign , src1}) >>> shift);

  assign carry = add_sub[32];
  assign sign  = add_sub[31];
  assign ovf   = (!src1_sign && src2_sign && sign) || (src1_sign && !src2_sign && !sign);

  assign lt  = sign != ovf;
  assign ltu = carry;

    always @* begin
      case (opcode_in)
        `R_type:
          case (funct3)
            3'b000: result_out = add_sub[31:0]; //add or sub
            3'b100: result_out = src1 ^ src2;   //xor
            3'b110: result_out = src1 | src2;   //or
            3'b111: result_out = src1 & src2;   //and
            3'b001: result_out = src1 << src2;  //sll
            3'b101: result_out = srl_sra;       //srl or sla
            3'b010: result_out = {31'b0, lt};   //slt
            3'b011: result_out = {31'b0, ltu};  //sltu
          endcase

        `I_type_op:
          case (funct3)
            3'b000: result_out = add_sub[31:0]; //addi  (fonct7 = 0)
            3'b100: result_out = src1 ^ src2;   //xori
            3'b110: result_out = src1 | src2;   //ori
            3'b111: result_out = src1 & src2;   //andi
            3'b001: result_out = src1 << src2;  //slli
            3'b101: result_out = srl_sra;       //srli or srai
            3'b010: result_out = {31'b0, lt};   //slti
            3'b011: result_out = {31'b0, ltu};  //sltiu
          endcase

        `I_type_ld , `S_type:
              result_out = add_sub[31:0]; //rs1 + imm for lsu

      endcase
    end

    assign non_zero_out = |result_out;

endmodule


`endif
