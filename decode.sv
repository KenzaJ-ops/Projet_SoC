`ifndef DECODE
`define DECODE

`define R_type 7'b0110011
`define I_type_op 7'b0010011 //I_type operation
`define I_type_ld 7'b0000011 //I_type load
`define U_type 7'b0110111
`define B_type 7'b1100011
`define J_type 7'b1101111
`define S_type 7'b0100011

module decode (

   input req,
   input reset,
   input rs_read,

   input [4:0] rd_in,
   input rd_write_in,
   input [31:0] rd_value_in,

   input [31:0] instr_in,

   input [31:0] pc_in_dec,
   output reg [31:0] pc_out_dec,

   output reg valid_out,
   output reg [2:0] funct3_out,        //needed in ALU
   output reg [6:0] funct7_out,       //needed in ALU
   output reg [6:0] alu_op_out,
   output reg alu_sub_sra_out,   //no need
   output reg [4:0] rd_out,
   output reg rd_write_out,


   output reg [31:0] rs1_value_out,           //needed in ALU
   output reg [31:0] rs2_value_out,          //needed in ALU
   output reg [31:0] imm_value_out          //needed in ALU
);

    logic [4:0] rs2; //wire??
    wire [4:0] rs1;
    wire [4:0] rd;

    logic [2:0] funct3;
    wire [6:0] funct7;
    always @ ( * ) begin
      if (instr_in[6:0] == `R_type ||instr_in[6:0] == `S_type || instr_in[6:0] == `B_type) rs2 = instr_in[24:20];
    end
    assign rs1 = instr_in[19:15];
    assign rd  = instr_in[11:7];

    //assign funct3 = instr_in[14:12];
    assign funct7 = instr_in[31:25];
    always @ ( * ) begin
      if (instr_in[6:0] == 7'b0000000) funct3 = 3'b0;
      else funct3 = instr_in[14:12];
    end



    reg [31:0] rs1_v_out;
    reg [31:0] rs2_v_out;

    regs regs (
        .req(req),
        .rs_read(rs_read),
        .rs1_in(rs1),
        .rs2_in(rs2),
        .rd_in(rd_in),
        .rd_write_in(rd_write_in),

        .rd_value_in(rd_value_in),

        .rs1_value_out(rs1_v_out),
        .rs2_value_out(rs2_v_out)
    );

    reg valid;
    wire rs1_read;
    wire rs2_read;
    reg [6:0] imm;
    reg [6:0] alu_op;
    reg alu_sub_sra;
    reg [2:0] alu_src1;
    reg [2:0] alu_src2;
    reg rd_write;

    reg mem_read;
    reg mem_write;
    reg [3:0] mem_width;
    reg mem_zero_extend;

    reg [3:0] branch_op;
    reg branch_pc_src;



    control_unit control_unit (

        .instr_in(instr_in),


        .valid_out(valid),
        .rs1_read_out(rs1_read),
        .rs2_read_out(rs2_read),
        .imm_out(imm),
        .alu_op_out(alu_op),
        .alu_sub_sra_out(alu_sub_sra),
        .alu_src1_out(alu_src1),
        .alu_src2_out(alu_src2),
        .rd_write_out(rd_write),//active ld
        .mem_read_out(mem_read),//ld
        .mem_write_out(mem_write),//st
        .mem_width_out(mem_width),//word ..
        .mem_zero_extend_out(mem_zero_extend),
        .branch_op_out(branch_op)
    );



    reg [31:0] imm_value;

    immediat immediat (

        .imm_in(imm),

        .instr_in(instr_in),

        .imm_value_out(imm_value)
    );

    always @ ( * ) begin
    rs1_value_out = rs1_v_out;
    rs2_value_out = rs2_v_out;

    end



    always_ff @(posedge req) begin
        if (!rs_read) begin

            pc_out_dec <= pc_in_dec;
            valid_out <= valid;
            alu_op_out <= alu_op;
            alu_sub_sra_out <= alu_sub_sra;
            rd_out <= rd;
            rd_write_out <= rd_write;
            imm_value_out <= imm_value;
            funct3_out <= funct3;
            funct7_out <= funct7;

            if (reset) begin
                   valid_out <= 0;
                   //mem_read_out <= 0;
                   //mem_write_out <= 0;
                   rd_write_out <= 0;
               end


        end


    end
endmodule

`endif
