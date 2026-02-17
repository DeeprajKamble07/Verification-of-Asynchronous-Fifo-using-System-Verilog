class scoreboard;
  transaction act,exp;
  bit [7:0] act_data, exp_data;
  mailbox mon2scb;
  mailbox rm2scb;
  function new(mailbox mon2scb,mailbox rm2scb);
    this.mon2scb=mon2scb;
    this.rm2scb=rm2scb;
  endfunction
  
  task main();
    forever begin
      fork 
        mon2scb.get(act);
        rm2scb.get(exp);
      join
      act_data=act.rdata;
      exp_data=act.rdata;
      
       if(act.wen)
        begin
          $display("%0h data written inside fifo",exp.wdata);
        end
      
      act.display("SCB");
      
      if (act.ren) 
        begin
      if(act_data==exp_data)
        begin
          $display("SCB: Comparison Passed act_data=%0h exp_data=%0h",act_data,exp_data);
        end
      else
        begin
          $display("SCB: Comparison Failed act_data=%0h exp_data=%0h",act_data,exp_data);
        end
      end
      
    end
  endtask
endclass
