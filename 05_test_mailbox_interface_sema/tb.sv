class transaction;
  rand bit [7:0] data;

  function display ();
    $display ("[%0t] Data = 0x%0h", $time, data);
  endfunction

endclass

class generator;
  mailbox mbx;

  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction

  task gen_data();
    transaction t = new ();
    t.randomize();
    $display("[%0t] [Generator] Putting data into mailbox", $time);
    mbx.put(t);
    $display("[%0t] [Generator] Data was put into mailbox", $time);
  endtask
endclass

module tb_top;
  mailbox mbx;
  generator gen;

  initial begin
    mbx = new();
    gen = new(mbx);

    #10 gen.gen_data();
    #10;
    $finish;
  end
endmodule
