//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name: Kian Hocking	
// Date: 09/06/2021
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

module lights_selector_tb();

parameter CLK_PERIOD = 10;

reg clk, sel, rst, button, err;
wire[23:0] light; 
reg[23:0] prev_light;

//clock generation
initial
    begin
       clk = 1'b1;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//section to initialise variables, switch the button on and off and switch select on and off.
initial begin

	err = 0;
	sel = 1;
	rst = 0;	
    	button = 0;
	//prev_light = 24'h0
	
	#50 button = 1;
	#50 sel = 0;
	#50 sel = 1;
	#50 button = 0;
	
end

//Finish test, check for success
initial begin
        #(50*CLK_PERIOD)
        
        if (err==0) begin
          $display("***TEST PASSED! :) ***");
        end
        
        $finish;
end

//instantiating lights selector
lights_selector top(
	.clk (clk), 
	.sel (sel), 
	.rst (rst), 
	.button (button), 
	.light (light)
	);

endmodule
