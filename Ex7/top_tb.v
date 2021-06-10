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
	rst = 1;
	prev_light = 24'h0000ff;
	
    button = 0;
	//prev_light = 24'h0
	
	#40 rst = 0;
	#40 button = 1;
	#40 sel = 0;
	#40 sel = 1;
	#80 button = 0;
	#40 rst = 1;
	#40 rst = 0;
	
end

//section to check errors
initial begin

    #2 // delays error checking to just after positive edge
    forever begin
    
        #(CLK_PERIOD*8)
	    
	    //checking if turning select off causes light to become white
		if((!sel)&&(light != 24'hffffff)) begin
		          $display("Test Failed, light not white when select is off");
		          err = 1;
		end
		
		
		else if(sel) begin
		          
		          //checking if rgb value changes
		          if(button) begin
		          
		              #(CLK_PERIOD*2) //this delays is to allow for the time taken retreiving the value from the rgb converter
		              
		              if(prev_light == light) begin
		                  $display("Test Failed, rgb value not changing");
		                  err = 1;
		                  
		              end
		          end
		
		          //checking if reset works
		          else if((rst)&&(light != 24'h0000ff)) begin
		              
		              #(CLK_PERIOD*2) //this delays is to allow for the time taken retreiving the value from the rgb converter
		              
		              if(light != 24'h0000ff) begin
		                  $display("Test Failed, rgb value not resetting");
		                  err = 1;
		              end
		          end
		          
		 end
			
	end
    
end

//Section to update prev_light value which is used for error checking
initial begin
        #2
        forever begin
        #CLK_PERIOD
        prev_light = light;
        end
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
