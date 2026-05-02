module fsm1101detector (
  input clk,
  input w,
  input allow_overlap,
  input rst,
  output reg detected
  );

  parameter init = 4'b000,
    s1 = 4'b001,
    s2 = 4'b101,
    s3 = 4'b100,
    s4 = 4'b110;

  reg [2:0] state;
  reg [2:0] next_state;

  always_comb begin 
    case (state)
      init: next_state = w ? s1 : init;
      s1: next_state = w ? s2 : init;
      s2: next_state = w ? s2 : s3;
      s3: next_state = w ? s4 : init;
      s4: 
        if (w) next_state = allow_overlap ? s2 : s1;
        else next_state = init;
      default: next_state = init;
    endcase
  end

  always_ff @(posedge clk) begin
    if (rst) detected <= 0;
    else detected <= (next_state == s4);
    state <= rst ? init : next_state;
  end

endmodule
