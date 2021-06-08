//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

module LEDs_tb();

parameter CLK_PERIOD = 10;

reg clk, rst, button, err;
wire[2:0] colour;
reg[2:0] colour_prev;

//clock generation
initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//Section to toggle on and off the button and reset
initial begin
	rst = 1;
	button = 1;
	err = 0;
	colour_prev = 1;

	#20 rst = 0;
	#80 button = 0;
	#20 rst = 1;  
	#20 rst = 0;
	#20 button = 1;	
end 

//section to check for errors
initial begin
    #(CLK_PERIOD/2 + 1) // delay to allow checking of errors 1 tick after a positive edge 
	forever begin

		#CLK_PERIOD

		if(rst) begin
                	if(colour != 3'b001) begin
				        $display("Test Failed, colour did not reset");
				        err = 1;
			        end
		end
		
		else if(button) begin
		
			if(colour == 1) begin
			    if(colour_prev != 6) begin		
			 	   $display("Test Failed, colour not looping back from 110 to 001");
				   err = 1;
				end
			end
							 
			else if (colour - colour_prev != 1) begin
				$display("Test Failed, colour not changing when button is on");
				err = 1;
			end
		end
    end
end

// save previous value of colour for use in error checking
always @(posedge clk) 
begin 
                colour_prev <= colour;
end

//Finish test, check for success
initial begin
        #250 
        
        if (err==0) begin
          $display("***TEST PASSED! :) ***");
        end
        
        $finish;
end


LEDs top(
    .clk (clk), 
    .rst (rst), 
    .button (button), 
    .colour (colour)
    );

endmodule
