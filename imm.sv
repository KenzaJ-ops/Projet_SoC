`ifndef IMM
`define IMM

`define I_type_op 7'b0010011 //I_type operation
`define I_type_ld 7'b0000011  //I_type load
`define U_type 7'b0110111
`define B_type 7'b1100011
`define J_type 7'b1101111
`define S_type 7'b0100011
`define NOP_type 7'b0000000

module immediat (
    input [6:0] imm_in,

    input [31:0] instr_in,

    output reg [31:0] imm_value_out
);

    wire [31:0] imm_i;
    wire [31:0] imm_i_ld;
    wire [31:0] imm_u;
    wire [31:0] imm_b;
    wire [31:0] imm_j;
    wire [31:0] imm_s;

    assign imm_i = instr_in[31:20];
    assign imm_u = instr_in[31:12];
    assign imm_b = {instr_in[7], instr_in[30:25], instr_in[11:8], instr_in[31]};
    assign imm_j = instr_in[31:12];
    assign imm_s = {instr_in[31:25], instr_in[11:7]};

    always @* begin
        case (imm_in)
            `I_type_op:     imm_value_out = imm_i;
            `I_type_ld:     imm_value_out = imm_i;
            `U_type:        imm_value_out = imm_u;
            `B_type:        imm_value_out = imm_b;
            `J_type:        imm_value_out = imm_j;
            `S_type:        imm_value_out = imm_s;
            `NOP_type:      imm_value_out = 32'b0;
        endcase
    end
endmodule

`endif
