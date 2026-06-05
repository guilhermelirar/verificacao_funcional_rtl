/**
* Testando distribuições de números aleatórios 
* por meio de constraints de peso como := e :/
*/

class RandomNumber;
  rand bit [3:0] n1;
  rand bit [3:0] n2;
  randc bit [3:0] n3;

  task print;
  begin
    $display("[RandomNumber] n1 (:=): %2d, n2 (:/): %2d, n3 (cyclic): %2d",
      n1, n2, n3);
  end
  endtask

  constraint c_dist {
    n1 dist { [1:10] := 100, 15 := 50 }; // cada 1 a 10 tem peso 100
    n2 dist { [1:10] :/ 100, 15 := 50 }; // intervalo 1-10 tem peso 100 
  }

endclass

module random_top;
  RandomNumber r;

  initial begin
    r = new();
    
    for (int i = 0; i < 20; i++) begin 
      r.randomize();
      r.print();
    end

  end
endmodule
