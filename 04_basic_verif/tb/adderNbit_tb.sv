//** testbench do adder de 4 bit
module adderNbit_tb;
  localparam BITS = 8;

  logic [BITS-1:0] t_a;
  logic [BITS-1:0] t_b;
  logic [BITS-1:0] t_result;
  logic            t_carry;

  adderNbit #(.N(BITS))
  dut (
    .a(t_a),
    .b(t_b),
    .result(t_result),
    .carry(t_carry)
    );

  initial begin
    t_a = 1; t_b = 0;
    
    #10;
    t_a = 2; t_b = 2;

    #10;
    t_b = 8'hFF; t_a = 1;

  end 

  initial begin
    $monitor("A: %d | B: %d | R: %d | C: %d ", t_a, t_b, 
      t_result, t_carry);
  end

endmodule
