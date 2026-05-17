`timescale 1ns/1ns
module ffd (
  input clk,
  input logic d,
  input rst_n,
  output logic q
  );

  always @ (posedge clk, negedge rst_n) begin
    if (~rst_n) q <= 0;
    else q <= d;
  end

  endmodule
