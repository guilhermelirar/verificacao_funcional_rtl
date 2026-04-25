 module updown_counter (
  input clk,
  input rst,
  input dir,
  output reg[3:0] out
  );


  // Sensivel a clock ou ao reset
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out <= 4'b0000;

    end else begin
      if (dir) begin     // contagem decrescente
        out <= out - 1;
      end else begin
        out <= out + 1; // contagem crescente
      end
    end
  end

endmodule 
