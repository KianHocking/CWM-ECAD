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
wire[7:0] counter_prev;

//Todo: Clock generation
initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//Todo: User logic
initial begin
	rst = 1;
	change = 0;
	on_off = 1;
	err = 0;
	
	#50 rst = 0;
	#50 change = 1;
	#50 on_off = 0;

	forever begin
		#CLK_PERIOD	
				if((on_off)&&(counter_out - counter_prev != 1)) begin  
					$display("Test Failed");
					err = 1;
				end
	end
end


    
//Todo: Finish test, check for success
initial begin
        #200 
        if (err==0) begin
          $display("***TEST PASSED! :) ***");
        $finish;
        end
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
