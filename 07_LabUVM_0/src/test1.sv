/*
test1. Create a class called MemTrans that contains the following members, 
  then construct a MemTrans object in an initial block.
  a. An 8-bit data_in of logic type
  b. A 4-bit address of logic type
  c. A void function called print that prints out the 
  value of data_in and address
*/

typedef logic [7:0] byte_t;
typedef logic [3:0] addr_t;

class MemTrans;
  byte_t data_in;
  addr_t address;

  // test2 - custon contructor
  function new (addr_t addr = 0, byte_t data = 0);
  begin 
    this.data_in = data;
    this.address = addr;
  end
  endfunction

  function print();
    $display("[MemTrans] data_in: %h, address: %h", data_in, address);
  endfunction
endclass

module test1;
  initial begin
    MemTrans memtr1 = new(.addr(2));
    MemTrans memtr2 = new(3, 4);
    memtr1.print();
    memtr2.print();
  end 
endmodule
