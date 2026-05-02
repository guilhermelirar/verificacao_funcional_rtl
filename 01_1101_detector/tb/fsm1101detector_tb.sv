`timescale 1ns / 1ps
module testbench;

reg clk;
reg w;
reg allow_overlap;
reg rst;

wire detected;

always #5 clk = ~clk;

fsm1101detector dut (
  .clk(clk),
  .w(w),
  .allow_overlap(allow_overlap),
  .rst(rst),
  .detected(detected)
  );


reg [7:0] test_sequence;

initial begin
  clk = 1;
  $dumpfile("wave.vcd");
  $dumpvars(0, testbench);
 
  test_sequence = 8'b1101_101x;
  rst = 0; allow_overlap = 0;
  w = 0;
  for (int i = 7; i >= 0; i--) begin
    @(posedge clk);
    w <= test_sequence[i];
  end

  #5 allow_overlap = 1;
  for (int i = 7; i >= 0; i--) begin
    @(posedge clk);
    w <= test_sequence[i];
  end



  #20 $finish;
end
endmodule

