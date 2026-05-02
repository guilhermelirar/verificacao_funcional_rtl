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

reg [6:0] last_seven;

always @(posedge clk) begin
  if (rst) last_seven = 7'b0000000;
  else begin 
    last_seven <= {last_seven[5:0], w};
  end 
end

parameter pattern = 4'b1101;

always @(negedge clk) begin
  if (detected) begin
    if (rst) $error("ERRO: detected em modo reset");

    if (last_seven[3:0] != pattern) 
      $error("ERRO: detectado enquanto ultimos 4 foram: %b", last_seven[3:0]);
 
    if (!allow_overlap && last_seven[6:3] == pattern && last_seven[3:0] == pattern)
      $error("ERRO: allow_overlap(0) não obedecido");

  end else if (rst) begin

    if (allow_overlap && last_seven[3:0] == pattern) 
      $error("ERRO: detected não subiu quando deveria");

    if (!allow_overlap && last_seven[3:0] == pattern && last_seven[6:3]) 
      $error("ERRO: detected não subiu quando deveria");

  end

end

initial begin
  clk = 1;
  $dumpfile("wave.vcd");
  $dumpvars(0, testbench);
  $fsdbDumpvars(0, testbench);
 
  rst = 1; allow_overlap = 0;
  repeat (1000) w = $random;

  rst = 0;
  repeat (1000) w = $random;

  allow_overlap = 1;
  repeat (1000) w = $random;

  #20 $finish;
end
endmodule

