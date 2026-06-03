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

class driver;
  mailbox mbx;

  function new (mailbox mbx);
    this.mbx = mbx;
  endfunction

  task drive_data();
    transaction t = new ();
    $display("[%0t] [Driver] attempting to get a transaction from mailbox",
      $time);
    mbx.get(t);
    $display("[%0t] [Driver] just got a transaction:", $time);
    t.display();
  endtask
endclass

module tb_top;
  mailbox mbx;
  generator gen;
  driver drv;

  initial begin
    mbx = new();
    gen = new(mbx);
    drv = new(mbx);

    $display("[%0t] [Main] fork join will start", $time);
    fork
      #10 gen.gen_data();
      drv.drive_data();
    join
    $display("[%0t] [Main] fork join finished (it blocked main thread)", 
      $time);

    $display("[%0t] [Main] fork join_none will start", $time);
    
    fork
      #10 gen.gen_data();
      drv.drive_data();
    join_none

    $display("[%0t] [Main] fork join_none won't block", $time);

    #50 $finish;
  end
endmodule
