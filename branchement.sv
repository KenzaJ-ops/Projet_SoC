`ifndef BRANCH
`define BRANCH


module branch_pc (

    input [6:0] opcode,
    input [31:0] pc_in,
    input funct3,
    input [31:0] rs1_value_in,
    input [31:0] rs2_value_in,
    input [31:0] imm_value_in,

    output reg [31:0] pc_out,
    output reg branch_mispredicted_out
);
    reg branch;
    reg b;
    assign b = 0;

    always @(*) begin
      branch_mispredicted_out = b;
      branch = 0;
      if (opcode == 7'b1100011) begin
        case(funct3)
          000: branch = (rs1_value_in == rs2_value_in) ? 1 : 0;      //beq
          001: branch = (rs1_value_in != rs2_value_in) ? 1 : 0;      //bne
          100: branch = (rs1_value_in < rs2_value_in) ? 1 : 0;       //blt
          101: branch = (rs1_value_in >= rs2_value_in) ? 1 : 0;      //bge
          110: branch = (rs1_value_in < rs2_value_in) ? 1 : 0;       //bltu
          111: branch = (rs1_value_in >= rs2_value_in) ? 1 : 0;      //bgeu
          default:       branch = 0;
        endcase
      end
      if (branch == 1 || opcode == 7'b1101111 ) begin pc_out = pc_in + imm_value_in;
                                                            branch_mispredicted_out = 1;
                                                    end
      if (opcode == 7'b1100111) begin
                                        pc_out = rs1_value_in + imm_value_in;
                                        branch_mispredicted_out = 1;
                                        end
    end

endmodule

`endif
