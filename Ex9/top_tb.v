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
reg clk_p, button, blind_switch1, blind_switch2, select, err, n, rst;
wire clk_n, blind_position, heating, cooling;
wire[23:0] light;
reg[23:0] prev_light;
reg[4:0] temperature;
reg[3:0] blind_possible_positions = {0,1,2,3};

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

initial begin

	prev_light = 24'hffffff;
    	rst = 0;
	button = 0;
	blind_switch1 = 0;
	blind_switch2 = 0;
	select = 0;
	
	#80 select = 1;
	#40 rst = 1;
	#20 rst = 0;
	#40 button = 1;
	#40 blind_switch1 = 1;
	#40 blind_switch2 = 1;
	#40 blind_switch1 = 0;

    
end

//section to check for errors
initial begin

    err = 0;
    #1 // delay to allow checking of errors 1 tick after a positive edge 
    
	forever begin

		#CLK_PERIOD

		// --- Section to check for errors in the air con ---
		
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
		if((heating)&&(cooling)) begin
			$display("Test Failed, heating and cooling both on");
			err = 1;
		end

		// --- Section to check for errors in the lighting ---

		 //checking if turning select off causes light to become white
		else if((!select)&&(light != 24'hffffff)) begin
		          $display("Test Failed, light not white when select is off");
		          err = 1;
		end
		
		
		else if(select) begin
		          
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
	.rst_n(rst),
	.temperature_0 (temperature[0]), 
	.temperature_1 (temperature[1]), 
	.temperature_2 (temperature[2]),
	.temperature_3 (temperature[3]), 
	.temperature_4 (temperature[4]),
	.button (button),
	.blind_switch1 (blind_switch1),
	.blind_switch2 (blind_switch2),
	.select (select),
	.blind_possible_positions (blind_possible_positions),
	.heating(heating),
	.cooling(cooling),
	.light (light),
	.blind_position (blind_position)
	);

endmodule
