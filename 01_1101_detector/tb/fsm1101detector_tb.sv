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

// PROPERTIES & ASSERTIONS
assert property (@(posedge clk) detected |-> !rst)
else $error("(ERRO) detect em reset");

assert property (
  @(posedge clk) detected |-> last_seven[3:0] == pattern
)
else $error("(ERROR) falso positivo");

assert property (@(posedge clk) disable iff (rst) 
  (allow_overlap 
  or last_seven[6:3] != pattern) 
  and last_seven[3:0] == pattern 
  |-> detected
) else $error("(ERRO) sequencia válida %b mas detected foi 0 (allow_overlap=%b)", 
      last_seven, allow_overlap);

assert property (@(posedge clk) !allow_overlap and detected 
  |=> !detected[*3]
) else $error("(ERRO) allow_overlap 0 foi violado");


initial begin
  clk = 1;
  rst = 1; allow_overlap = 0; w = 0;
  
  repeat (5) @(negedge clk); 
  
  $dumpfile("fsm1101.vcd");
  $dumpvars(0, testbench);
  
  rst = 0;
  $display("--- Iniciando Teste: allow_overlap: 0 ---");
  repeat (1000) begin
    @(negedge clk); 
    w = $random;
  end

  allow_overlap = 1;
  $display("--- Iniciando Teste: allow_overlap: 1 ---");
  repeat (1000) begin
    @(negedge clk);
    w = $random;
  end

  #20 $finish;
end
endmodule
