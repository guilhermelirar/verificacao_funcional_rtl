/*
test1. Create a class called MemTrans that contains the following members, 
  then construct a MemTrans object in an initial block.
  a. An 8-bit data_in of logic type
  b. A 4-bit address of logic type
  c. A void function called print that prints out the 
  value of data_in and address
*/

class MemTrans;
  logic [7:0] data_in;
  logic [3:0] address;

  function print();
    $display("[MemTrans] data_in: %h, address: %h", data_in, address);
  endfunction
endclass

module test1;
  initial begin
    MemTrans memtr = new();
    memtr.print();
  end 
endmodule
