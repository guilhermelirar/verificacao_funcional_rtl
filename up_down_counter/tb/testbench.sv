module testbench;

reg clk;
reg dir;
reg rst;

wire [3:0] out;
  updown_counter dut (
    .clk(clk),
    .rst(rst),
    .dir(dir),
    .out(out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(1, testbench);

    clk = 0;
    rst = 1;
    dir = 0;  // counting up

    // Contagem habilitada
    #15; rst = 0; 

    #155;    // 10 ns * 16 states = 160ns
    dir = 1; // counting down 

    #170 $finish;
  end 
endmodule

