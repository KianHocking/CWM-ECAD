//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name: Kian Hocking
// Date: 09/06/2021
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

module colour_converter_tb();

parameter CLK_PERIOD = 10;

reg clk, err, enable;
reg[2:0] colour;
wire[23:0] rgb; 
reg[23:0] prev_rgb;

//clock generation
initial
    begin
       clk = 1'b1;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//section to initialise variables and turn on enable after a little while
initial begin

	err = 0;
	enable = 0;
	colour = 0;	
    prev_rgb = 0;
    
    // start with enable off for a bit to allow testing
    #(CLK_PERIOD*24)
    enable = 1;
	
end

//section to increment the colour value 
initial begin
    forever begin
        #(CLK_PERIOD*8)
		colour <= colour + 1;
    end
end

//section to check errors
initial begin

    #(CLK_PERIOD*4) // delays error checking to account for delay retrieving the rgb value from the block memory

    forever begin
    
        #(CLK_PERIOD*8)
	    
	    //checking if the rgb value changes when the colour value changes
		if((enable)&&(prev_rgb  == rgb)) begin
		          $display("Test Failed, rgb not changing when enable is active");
		          err = 1;
		end
		
		//checking if the rgb value remains fixed when enable is not active
		else if ((!enable)&&(prev_rgb != rgb)) begin
                $display("Test Failed, rgb changed when enable is not active");
                err = 1;
        end
    
        //sets the previous rgb value to the rgb value for error checking at the next rgb value.
		prev_rgb = rgb;
		
	end
    
end

//Finish test, check for success
initial begin
        #(80*CLK_PERIOD)
        
        if (err==0) begin
          $display("***TEST PASSED! :) ***");
        end
        
        $finish;
end


colour_converter top(
    .clk (clk), 
    .enable (enable), 
    .colour (colour), 
    .rgb (rgb)
    );

endmodule
