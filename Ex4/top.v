//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module LEDs(clk, rst, button, colour);

input clk, rst, button;
output reg[2:0] colour;

// set colour to 001 on first startup
initial begin 
    colour <= 3'b001;
end

    //code to increment colour appropriately
	always @(posedge clk) begin
		
		if(rst) begin
			colour <= 3'b001;
		end 
		
		else if(button) begin
		
			if((colour == 3'b110)||(colour == 3'b111)||(colour == 3'b000)) begin
				colour = 3'b001;
			end
			else begin
				colour <= colour + 1;
			end
		end
		
	end 

endmodule
