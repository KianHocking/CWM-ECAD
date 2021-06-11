//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module AC(clk, temperature, heating, cooling);

input clk;
input[4:0] temperature;
output reg heating, cooling;

//code to turn on/off heating or cooling
	always @(posedge clk) begin
	    
	    //these two if statements are for heating and cooling when starting at temperatures requiring heating or cooling
        if(temperature <= 18) begin
            heating = 1;
            cooling = 0;
        end
        else if(temperature >= 22) begin
            cooling = 1;
            heating = 0;
        end
		
		//these two if statements are for turning off heating and or cooling once the desired temperature has been reached
		else if((heating)&&(temperature >= 20)) begin
	        heating <= 0;
		end

		else if((cooling)&&(temperature <= 20)) begin
			cooling <= 0;
		end
		
	end
		

endmodule
