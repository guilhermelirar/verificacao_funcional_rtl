`timescale 1ns/1ns

module testbench;

  logic clk;
  logic d;
  logic rst_n;
  logic q;

  // DUT
  ffd dut (
    .clk   (clk),
    .d     (d),
    .rst_n (rst_n),
    .q     (q)
  );

  // Clock manual (controlado)
  initial clk = 0;

  initial begin
    $display(" time | clk d rst_n | q");
    $monitor("%4t |  %0b   %0b   %0b   | %0b",
              $time, clk, d, rst_n, q);
  end

assert property (
  @(posedge clk) disable iff (!rst_n)
  1 |=> (q == $past(d))
);

  initial begin
    // init
    rst_n = 0;
    d     = 0;
    #2;

    rst_n = 1;
    #2;

    clk = 0;
    d   = 1;
    #5;

    clk = 1;
    #5;

    clk = 0;
    d   = 0;
    #5;

    clk = 1;
    #5;

    $finish;
  end

endmodule
