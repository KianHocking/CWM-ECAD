//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 - Active IoT Devices Monitor
// Student Name: Kian Hocking
// Date: 07/06/2021
//
//  Description: In this exercise, you need to design a counter of active IoT devices, where 
//  if the rst=1, the counter should be set to zero. If event=0, the value
//  should stay constant. If on-off=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, change, on_off
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module monitor (rst, clk, change, on_off, counter_out);


input rst, clk, change, on_off;
output reg[7:0] counter_out;

// set counter to zero on first startup
initial begin
	counter_out <= 0;
end

                    
    //Todo: add registers and wires, if needed

    //Todo: add user logic

    always @(posedge clk)
    begin
    
       //reset
	   if(rst) begin
		  counter_out <= 0;
	   end
	   
	   //increment appropriately when change == 1
	   else
	   if(change) begin
	 
		  if(on_off) begin
			 counter_out <= counter_out + 1;
		  end
		
	  	  else begin 
	   		 counter_out <= counter_out - 1;
	  	  end
	  	
	   end
    end
	  
      
endmodule
