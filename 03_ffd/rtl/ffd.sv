`timescale 1ns/1ns

interface ffd_if (input logic clk);
  logic d;
  logic rst_n;
  logic q;

  clocking cb @(posedge clk);
    // o quao antes sample inputs, e quão depois drive output
    default input #1step output #0; 
    output d;
    output rst_n;
    input q;
  endclocking

endinterface


module ffd (ffd_if top_if);
  always @ (posedge top_if.clk, negedge top_if.clk) begin
    if (~top_if.rst_n) 
      top_if.q <= 0;
    else 
      top_if.q <= top_if.d;
  end

  endmodule
