module join(

input E1_req,
input E2_req,
output S_req,

input S_ack,
output E1_ack,
output E2_ack

);

c_element c (
  .a(E1_req)
  .b(E2_req)
  .c(S_req)
  );



always @ ( * ) begin
  E1_ack = S_ack;
  E2_ack = S_ack;
end

endmodule
