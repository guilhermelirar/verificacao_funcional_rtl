parameter 
  // arithmetic
  op_add = 4'b0001, 
  op_sub = 4'b0010,
  op_inc = 4'b1001,
  op_dec = 4'b1010,
  
  // logic
  op_and = 4'b0011,
  op_or  = 4'b0100,
  op_nor = 4'b0101,
  op_xor = 4'b0111,
  op_sll = 4'b1000,
  op_srl = 4'b1100;

module ula_16b(
  input wire [3:0] alu_op,
  input wire [15:0] op_a,
  input wire [15:0] op_b,
  output reg [15:0] out,
  output reg [3:0] flags  // [Z, N,  C, V]
  );

 
  logic zero, negative, carry, overflow;
  logic sign_a, sign_b, sign_out;

  assign sign_a   = op_a[15];
  assign sign_b   = op_b[15];
  assign sign_out = out[15];
  
  always_comb begin
    case (alu_op)
      op_add: begin 
        {carry, out} = op_a + op_b;
      end

      op_sub: begin
        out = op_a - op_b;
      end

      op_inc: begin 
        {carry, out} = op_a + 1;
      end

      op_dec: begin 
        out = op_a - 1;
      end
      
      op_and: out  = op_a & op_b;
      op_or:  out  = op_a | op_b;
      op_nor: out  = ~ (op_a | op_b);
      op_xor: out  = op_a ^ op_b;
      op_sll: out  = op_a << op_b;
      op_sll: out  = op_a >> op_b;
    endcase

    zero = !out;
    negative = out[15];

    if (alu_op == op_add)
      overflow = (sign_a == sign_b) && (sign_out != sign_a);

    else if (alu_op == op_sub)
      overflow = (sign_a != sign_b) && (sign_out != sign_a);

    else if (alu_op == op_inc)
      overflow = (sign_a == 0 && sign_out == 1);

    else if (alu_op == op_dec)
      overflow = (sign_a == 1 && sign_out == 0);

    else 
      overflow = 0;

    flags = {zero, negative, carry, overflow};
  end

endmodule
