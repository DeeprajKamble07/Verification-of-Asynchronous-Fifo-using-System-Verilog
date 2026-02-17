class monitor;
  transaction trans;
  virtual intf vif;
  mailbox mon2scb;
  function new(virtual intf vif,mailbox mon2scb);
    this.vif=vif;
    this.mon2scb=mon2scb;
  endfunction
  
  task main();
  forever begin
    @(posedge vif.wclk);
    if (vif.wen) begin
      trans = new();
      trans.wen   = 1;
      trans.wdata = vif.wdata;
      trans.full  = vif.full;
      trans.overflow = vif.overflow;
      mon2scb.put(trans);
      trans.display("MON");
    end

    @(posedge vif.rclk);
    if (vif.ren) begin
      trans = new();
      trans.ren    = 1;
      trans.rdata  = vif.rdata;
      trans.empty  = vif.empty;
      trans.underflow = vif.underflow;
      mon2scb.put(trans);
      trans.display("MON");
    end
  end
endtask

endclass

        
