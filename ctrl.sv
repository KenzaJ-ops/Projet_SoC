module ctrl(
  input reset,

  output reg [3:0] req

  );

  timeunit  1ns;
  timeprecision 1ns;

  logic ack_0;
  logic ack_1;
  logic ack_2;
  logic ack_3;
  real cntr = -1;
  real cntr_req = -1;
  //logic [3:0] req_c;
  logic req_0;
  logic req_1;
  logic req_2;
  logic req_3;




  always @ ( negedge reset ) begin
         ack_1 = 0;
         req_0 = 1;
         req_1 = 0;
         req_2 = 0;
         req_3 = 0;
         req[0] = 1;


  end


 controller ctrl0(
  .req_i(req_0),
  .ack_i1(ack_1),
  .reset(reset),

  .req_i1(req_1),
  .ack_i(ack_0)
  );

  controller ctrl1(
   .req_i(req_1),
   .ack_i1(ack_2),

   .reset(reset),

   .req_i1(req_2),
   .ack_i(ack_1)
   );

   controller ctrl2(
    .req_i(req_2),
    .ack_i1(ack_0),

    .reset(reset),

    .req_i1(req_0),
    .ack_i(ack_2)
    );

    /*controller ctrl3(
     .req_i(req_3),
     .ack_i1(ack_0),
     .reset(reset),

     .req_i1(req_0),
     .ack_i(ack_3)
     );
     */
  always @(posedge req_0)begin
  if (cntr_req == 4) begin
    cntr_req = 0;
    end
  else cntr_req += 1;
  end

  //assign req_c = {req_0,req_1,req_2,req_3};

  initial forever  begin
  @(*) begin

    if (!reset) begin
      case (cntr_req)
        0 : begin
            cntr += 1;
            if (cntr == 4) begin
              cntr = 0;
            end
            case (cntr)
              0:begin  req = {3'b0,req_0};#20 req = 4'b0; end
              1:begin  req = {3'b0,req_1};#20 req = 4'b0; end
              2:begin  req = {3'b0,req_2};#20 req = 4'b0; end
              3:begin  req = {3'b0,req_3};#20 req = 4'b0; end
              default:  req = 4'b0;
              endcase
        end
        1 : begin
            cntr += 1;
            if (cntr == 4) begin
              cntr = 0;
            end
            case (cntr)
              0:begin  req = {2'b0,req_0,1'b0};#20 req = 4'b0; end
              1:begin  req = {2'b0,req_1,1'b0};#20 req = 4'b0; end
              2:begin  req = {2'b0,req_2,1'b0};#20 req = 4'b0; end
              3:begin  req = {2'b0,req_3,1'b0};#20 req = 4'b0; end
              default:  req = 4'b0;
              endcase
        end
        default:  req = 4'b0;
      endcase
    end
  end
  end
endmodule
