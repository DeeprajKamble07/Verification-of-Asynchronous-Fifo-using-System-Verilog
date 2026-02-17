module asynfifo #(parameter width=8, depth=8, addr=$clog2(depth))(wclk,rclk,rst,wen,ren,wdata,rdata,full,empty,overflow,underflow);
  input wclk,rclk,rst,wen,ren;
  input [width-1:0] wdata;
  output reg [width-1:0] rdata;
  output reg full,empty,overflow,underflow;
  
  reg [width-1:0] fifo [0:depth-1];
  reg [addr-1:0] wptr,rptr,wptr_rclk,rptr_wclk;
  reg wr_toggle,rd_toggle,wr_toggle_rclk,rd_toggle_wclk;
  integer i;
  
  always @(posedge wclk)
    begin
      if(rst)
        begin
          rdata=0;full=0;empty=0;overflow=0;underflow=0;
          wptr=0;rptr=0;wptr_rclk=0;rptr_wclk=0;
          wr_toggle=0;rd_toggle=0;wr_toggle_rclk=0;rd_toggle_wclk=0;
          for(i=0;i<depth;i++)
            fifo[i]=0;
        end
      else
        begin
          if(wen)
            begin
              if(full)
                overflow=1;
              else
                begin
                  fifo[wptr]=wdata;
                  if(wptr==depth-1)
                    begin
                      wptr=0;
                      wr_toggle=~wr_toggle;
                    end
                  else
                    wptr=wptr+1;
                end
            end
        end
    end
  always @(posedge rclk)
    begin
      if(rst==0)
        begin
          if(ren)
            begin
              if(empty)
                underflow=1;
              else
                begin
                  rdata=fifo[rptr];
                  if(rptr==depth-1)
                    begin
                      rptr=0;
                      rd_toggle=~rd_toggle;
                    end
                  else
                    rptr=rptr+1;
                end
            end
        end
    end
  
  always @(posedge wclk)
    begin
      rptr_wclk<=rptr;
      rd_toggle_wclk<=rd_toggle;
    end
  
  always @(posedge rclk)
    begin
      wptr_rclk<=wptr;
      wr_toggle_rclk<=wr_toggle;
    end
  
  always@(*)
    begin
      if(rptr_wclk==wptr_rclk  &&  rd_toggle_wclk==wr_toggle_rclk)
        empty=1;
      else
        empty=0;
      if(rptr_wclk==wptr_rclk  &&  rd_toggle_wclk!=wr_toggle_rclk)
        full=1;
      else
        full=0;
    end
endmodule
