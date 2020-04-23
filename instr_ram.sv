
module instr_ram(

  //input req,
  input instr_req_in,
  input [31:0] instr_addr_in,
  input [31:0] inst_mem [8000:0],


  output reg instr_rvalid_o,
  output reg instr_gnt_o,
  output reg [0:31] instr_rinstr_o
  );

/*  module instr_read (
    .valid( 1'b1 ),
    .mem (inst_mem)
    );
*/
  always @* begin

    instr_rvalid_o = 0;
    instr_gnt_o = 0;
    if (instr_req_in) begin
      instr_gnt_o = 1;
      if (instr_addr_in[31:16] == 16'h0000) begin
        instr_rinstr_o = inst_mem[instr_addr_in[15:0]][31:0];
        instr_rvalid_o = 1'b1;
      end
      else  instr_gnt_o = 0;

    end
  end
endmodule
