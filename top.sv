`include "interface.sv"
`include "test.sv"
module tb;
  reg wclk,rclk,rst;
  intf intff(wclk,rclk,rst);
  test tst(intff);
  asynfifo #(8,8) dut(.wclk(intff.wclk),.rclk(intff.rclk),.rst(intff.rst),.wen(intff.wen),.ren(intff.ren),.wdata(intff.wdata),.rdata(intff.rdata),.full(intff.full),.empty(intff.empty),.overflow(intff.overflow),.underflow(intff.underflow));
  initial begin
    wclk=0;
    forever #5 wclk=~wclk;
  end
 initial begin
   rclk=0;
   forever #7 rclk=~rclk;
 end
  initial begin
    rst=1;
    #10 rst=0;
    #1000; $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
