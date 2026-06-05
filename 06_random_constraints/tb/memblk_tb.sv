/**
* Testando diferentes compotamentos do randomize 
* de acordo com as constraints aplicadas, incluindo 
* distribuição de peso em intervalos e valores 
* individuais
*****************************************************/

/* Bloco de memória dentro de uma RAM */
class MemBlk;

  logic [7:0] ram_start;
  logic [7:0] ram_end;

  rand bit[7:0] blk_start;
  rand bit[7:0] blk_end;

  function new (logic [7:0] ram_start, logic [7:0] ram_end);
  begin
    this.ram_start = ram_start;
    this.ram_end   = ram_end;
  end
  endfunction;

  task print;
  begin
    $display("[MemBlk] blk_start: %0h, blk_end: %0h, blk_size: %0h",     
      blk_start, blk_end, blk_start-blk_end);
  end
  endtask

  // Endereço dentro da ram
  constraint range_ok {
    blk_start < ram_end; blk_start < blk_end;
    blk_end > blk_start; blk_end < ram_end;
  }

  // Tamanho deve ser alinhado por 4 bytes
  constraint size_allign {
    blk_start % 4 == 0;
    (blk_end - blk_start) % 4 == 0;
  }

endclass

module top;

  MemBlk blk;
  logic [7:0] ram_start = 8'h0;
  logic [7:0] ram_end   = 8'hfc;

  initial begin
    blk = new (ram_start, ram_end);
    blk.randomize();

    blk.print();
  end


endmodule
