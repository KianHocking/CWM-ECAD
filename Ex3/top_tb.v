//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name: Kian Hocking	
// Date: 07/06/2021
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
reg clk, rst, change, on_off, err;
wire[7:0] counter_out;
reg[7:0] counter_prev;

//Todo: Clock generation
initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//Todo: User logic
//Section to toggle on and off the different inputs at different times
initial begin
	rst = 1;
	change = 0;
	on_off = 1;
	err = 0;
	counter_prev = 0;

	#10 rst = 0;
	#40 change = 1;
	#70 on_off = 0;
	#30 rst = 1;   
	
end 

//section to check for errors
initial begin
    #(CLK_PERIOD/2 + 1) // delay to allow checking of errors 1 tick after a positive edge 
	forever begin
		#CLK_PERIOD
		
		if(rst) begin
                	if(counter_out != 0) begin
				$display("Test Failed, counter did not reset");
				err = 1;
			end
		end
		      
		else if(change) begin	
					
            	    if((on_off)&&(counter_out - counter_prev != 1)) begin  
                        $display("Test Failed, counter not increasing by 1");
                        err = 1;
                    end
                    
	                else if ((!on_off)&&(counter_prev - counter_out != 1)) begin 
                		$display("Test Failed, counter not decreasing by 1");
                 		err = 1;
              	    end
		
   	    end	 
   	    
   	    else if(counter_out != counter_prev) begin
   	            $display("Test Failed, counter changed when change = 0");
                err = 1;
        end
        
     end
		      

end

// save previous value of counter for use in error checking
always @(posedge clk) 
begin 
                counter_prev <= counter_out;
end

    
//Todo: Finish test, check for success
initial begin
        #250 
        
        if (err==0) begin
          $display("***TEST PASSED! :) ***");
        end
        
        $finish;
end

//Todo: Instantiate counter module
monitor top(
	.rst (rst), 
	.clk (clk), 
	.change (change), 
	.on_off (on_off),
	.counter_out (counter_out)
	);
 
endmodule 
