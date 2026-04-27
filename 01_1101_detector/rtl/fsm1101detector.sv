module fsm1101detector (
  input clk,
  input w,
  input allow_overlap,
  input rst,
  output reg detected
  );

  parameter INIT = 4'b0000,
    S1 = 4'b001,
    S2 = 4'b101,
    S3 = 4'b100,
    S4 = 4'b110;

  reg [2:0] state = 4'b0000;
  reg [2:0] next_state;

  always_comb begin 
    case (state)
      INIT: next_state = w ? S1 : INIT;
      S1: next_state = w ? S2 : INIT;
      S2: next_state = w ? S2 : S3;
      S3: next_state = w ? S4 : INIT;
      S4: 
        if (w) next_state = allow_overlap ? S2 : S1;
        else next_state = INIT;
      default: next_state = INIT;
    endcase
  end

  always_ff @(posedge clk) begin
    state <= rst ? INIT : next_state;
  end

  assign detected = (state == S4);
endmodule
