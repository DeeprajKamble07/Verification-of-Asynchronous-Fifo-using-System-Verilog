interface intf(input wclk,rclk,rst);
  bit wen,ren;
  bit [7:0] wdata,rdata;
  bit full,empty,overflow,underflow;
endinterface    
