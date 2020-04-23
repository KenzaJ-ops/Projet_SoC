module tb;

timeunit  1ns;
timeprecision 1ns;

bit reset = 1'b1;
reg req_0,req_1,req_2,req_3;
bit data;


 ctrl ctrl(
   .reset(reset),

   .req_0(req_0),
   .req_1(req_1),
   .req_2(req_2),
   .req_3(req_3)
  );



  initial forever begin
    $timeformat(-9, 1, "ns", 12);

  /*  always @ (*) begin
        data = 1'b1;
    end*/

    #100 {reset} = 1'b0; $display("HELLO");


    #100



    $display ("TESTE PASSED");

    end
endmodule
