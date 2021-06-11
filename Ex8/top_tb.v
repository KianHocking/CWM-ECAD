//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name: Kian Hocking
// Date: 11/06/2021
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb (
	);

parameter CLK_PERIOD = 10;

// n is a variable used to track whether we are forcing the temperature to increase or decrease. This forced change in temperature is for testing the heating and cooling switching on and off
reg clk_p, err, n;
wire clk_n;
wire heating, cooling; 
reg[4:0] temperature;

//clock generation
initial begin   	
		clk_p = 1'b1;
		forever begin
		#(CLK_PERIOD/2) clk_p=~clk_p;
		end
end
assign clk_n=~clk_p;

//Section to simulate temperature changing. The temperature will increase and decrease between 16 and 24 degrees
initial begin

	n = 0;
	temperature = 16;
    #(CLK_PERIOD/2) // delay so that temperature doesn't change on positive edge every time (for testing purposes).
    
	forever begin

		#(CLK_PERIOD*2)

		if(n == 0) begin
			if(temperature < 24) begin			
				temperature <= temperature + 1;
			end
			else begin
				n = 1;
			end
		end
		
		else begin
			if(temperature > 16) begin
				temperature <= temperature -1;
			end
			else begin
				n = 0;
			end	
		end
	end
end 

//section to check for errors
initial begin

    err = 0;
    #1 // delay to allow checking of errors 1 tick after a positive edge 
    
	forever begin

		#CLK_PERIOD
		
		// checking not heating at too high of a temperature
		if((heating)&&(temperature >= 20)) begin
			$display("Test Failed, heating when temperature is >= 20");
			err = 1;
		end
		
		// checking not cooling at too low of a temperature
		if((cooling)&&(temperature <= 20)) begin
			$display("Test Failed, cooling when temperature is <= 20");
			err = 1;
		end
		
		// checking it is heating below 18
		if((!heating)&&(temperature <= 18)) begin
			$display("Test Failed, not heating when temperature is <= 18");
			err = 1;
		end

		// checking it is cooling above 22
		if((!cooling)&&(temperature >= 22)) begin
			$display("Test Failed, not cooling when temperature is >= 22");
			err = 1;
		end

		// checking not heating and cooling at the same time
		else if((heating)&&(cooling)) begin
			$display("Test Failed, heating and cooling both on");
			err = 1;
		end

    	end
end

//Finish test, check for success
initial begin
        #500 
        
        if (err==0) begin
          $display("***TEST PASSED! :) ***");
        end
        
        $finish;
end


top top (
	.clk_p(clk_p),
	.clk_n(clk_n),
	.rst_n(rst_n),
	.temperature_0 (temperature[0]), 
	.temperature_1 (temperature[1]), 
	.temperature_2 (temperature[2]),
	.temperature_3 (temperature[3]), 
	.temperature_4 (temperature[4]),
	.heating(heating),
	.cooling(cooling)
	);

endmodule
