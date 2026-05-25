module adderNbit #(parameter N = 4) (
  input [N-1:0] a, 
  input [N-1:0] b,
  output wire [N-1:0] result,
  output logic carry
  );

  assign {carry, result} = a + b;

endmodule
