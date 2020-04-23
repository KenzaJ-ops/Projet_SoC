module c_element(
input a,
input b,
output wire c
);

always @ ( * ) begin
  if (a == b == 1'b0)  c = 1'b0;
  else if (a == b == 1'b1)  c = 1'b1;
end
endmodule
