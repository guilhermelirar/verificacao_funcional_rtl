`timescale 1ns/1ns

module testbench;
  logic clk;

  ffd_if top_if (clk);

  ffd dut (top_if);

  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  initial begin
    @top_if.cb;
    top_if.cb.rst_n <= 0;
    top_if.cb.d     <= 0;

    @top_if.cb;
    $display("d = %b; q = %b", top_if.d, top_if.cb.q);
    top_if.cb.rst_n <= 1; // Desativa reset
    
    @top_if.cb;
    $display("d = %b; q = %b", top_if.d, top_if.cb.q);
    top_if.cb.d <= 1; 

    @top_if.cb;
    $display("d = %b; q = %b", top_if.d, top_if.cb.q);
    top_if.cb.d <= 0;

    @top_if.cb;
    $display("d = %b; q = %b", top_if.d, top_if.cb.q);
    top_if.cb.d <= 1;

    @top_if.cb;
    $display("d = %b; q = %b", top_if.d, top_if.cb.q);
    top_if.cb.rst_n <= 0;

    @top_if.cb;
    $display("rst_n: %b; d = %b |-> q = %b", top_if.rst_n, 
      top_if.d, top_if.cb.q);

    $finish;
  end

endmodule
