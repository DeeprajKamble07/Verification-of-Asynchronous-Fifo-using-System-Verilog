class transaction;
  rand bit wen,ren;
  rand bit [7:0] wdata;
  bit [7:0] rdata;
  bit full,empty,overflow,underflow;
  
  function void display(string name);
    $display("[%0s] wen=%0b ren=%0b wdata=%0h rdata=%0h full=%0b empty=%0b overflow=%0b underflow=%0b",name,wen,ren,wdata,rdata,full,empty,overflow,underflow);
  endfunction
  constraint c1{wen != ren;}
endclass
