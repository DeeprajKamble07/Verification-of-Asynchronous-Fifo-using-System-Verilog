class driver;
  transaction trans;
  virtual intf vif;
  mailbox gen2drv;
  mailbox drv2scb;
  mailbox drv2rm;
  function new(virtual intf vif,mailbox gen2drv,mailbox drv2scb,mailbox drv2rm);
    this.vif=vif;
    this.gen2drv=gen2drv;
    this.drv2scb=drv2scb;
    this.drv2rm=drv2rm;
  endfunction
  
  task main();
    forever begin
      gen2drv.get(trans);
      if(trans.wen==1)
        begin
          @(posedge vif.wclk);
          vif.wen<=1'b1;
          vif.wdata<=trans.wdata;
          @(posedge vif.wclk);
          vif.wen<=1'b0;
        end
      else if(trans.ren==1)
        begin
          @(posedge vif.rclk);
          vif.ren<=1'b1;
          @(posedge vif.rclk);
          vif.ren<=1'b0;
        end
      drv2scb.put(trans);
      drv2rm.put(trans);
      trans.display("DRV");
    end
  endtask
endclass
