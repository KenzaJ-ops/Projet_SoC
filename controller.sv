`ifndef controller
`define controller

module controller(
  input req_i,
  input ack_i1,

  input reset,

  output reg req_i1,
  output reg ack_i
  );

  timeunit  1ns;
  timeprecision 1ns;

  initial begin
  req_i1 = ack_i;
  end


  initial forever  begin
  @(*) begin
  if (!reset) begin
      #40
        if (req_i)      ack_i <= 1;
        if (ack_i1)      req_i1 <= 0;
        if (!req_i)      ack_i <= 0;
        if (req_i != ack_i1) begin       req_i1 = req_i & (!ack_i1);ack_i = req_i1; end
        if (req_i == ack_i1) begin       req_i1 = req_i;ack_i = req_i1; end
      end
      end
    end
endmodule

`endif
