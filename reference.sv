class reference;
  transaction trans1,trans2;
  mailbox drv2rm;
  mailbox rm2scb;
  
  function new(mailbox drv2rm, mailbox rm2scb);
    this.drv2rm=drv2rm;
    this.rm2scb=rm2scb;
  endfunction
  
  task main();
    trans1=new();
    trans2=new();
    forever begin
      drv2rm.get(trans1);
      trans2=trans1;
      rm2scb.put(trans2);
    end
  endtask
endclass
