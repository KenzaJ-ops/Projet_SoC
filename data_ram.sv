`define WORD 4'b0001
`define HALF 4'b001_?
`define BYTE 4'b1_???

module data_ram (
    input req,

    input [31:0] data_add_in,//
    input data_we_in,//
    input [3:0] data_be_in,//
    input [31:0] data_wdata_in,//
    input data_req_in,
    input reg [4:0] rd_in_data,//
    output  reg [4:0] rd_out_data,//

    output reg data_gnt_o,
    output reg data_rvalid,//
    output reg [31:0] data_rdata_o //

);
    reg [31:0] mem [7999:0];
    //reg [31:0] read_value;
    /*wire [2:0] add ;
    assign add = data_add_in % 4;
    */
    wire [31:0] add;
    assign add = data_add_in[15:0] / 4;

    //assign data_rdata_o = data_we_in ? 32'bx : read_value;

    always @(posedge req) begin

      //read_value = 0;
      data_rvalid = 0;
      data_gnt_o = 0;
      data_rdata_o = 32'bx;
      rd_out_data <= rd_in_data;
      
      if (data_req_in) begin
        data_gnt_o <= 1;
        if (!data_we_in) begin
          data_rdata_o = {mem[add][7:0], mem[add][15:8], mem[add][23:16], mem[add][31:24]};
          data_rvalid = 1'b1;
        end
        if (data_we_in) begin
          casez (data_be_in)
            //word
            `WORD:  begin mem[data_add_in[15:0]][7:0] = data_wdata_in[31:24];
                          mem[data_add_in[15:0]][15:8] = data_wdata_in[23:16];
                          mem[data_add_in[15:0]][23:16] = data_wdata_in[15:8];
                          mem[data_add_in[15:0]][31:24] = data_wdata_in[7:0];
                    end
            //half_word
            `HALF:  begin
                        casez (data_be_in)
                          4'b0010:  begin
                                    mem[data_add_in[15:0]] = {16'b0,data_wdata_in[23:16],data_wdata_in[31:24]};
                                    end
                          4'b0011:  begin
                                    mem[data_add_in[15:0]] = {data_wdata_in[7:0],data_wdata_in[15:8],16'b0};
                                    end
                          endcase
                    end
            `BYTE:  begin
                        casez (data_be_in)
                          4'b1000:     mem[data_add_in[15:0]/4][31:24] = {data_wdata_in[7:0]};
                          4'b1001:     mem[data_add_in[15:0]/4][23:16] = {data_wdata_in[7:0]};
                          4'b1010:     mem[data_add_in[15:0]/4][15:8] = {data_wdata_in[7:0]};
                          4'b1100:     mem[data_add_in[15:0]/4][7:0] = {data_wdata_in[7:0]};
                        endcase
                     end
          endcase
        end
      end
    end
endmodule
