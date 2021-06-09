//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name: Kian Hocking
// Date: 09/06/2021
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module lights_selector(clk, sel, rst, button, light);

input clk, sel, rst, button;
output[23:0] light;

reg[2:0] colour;
reg[23:0] rgb;

LEDs lights(
	.clk (clk),
	.rst (rst),
	.button (button),
	.colour (colour)
	);

colour_converter converter(
	.clk (clk), 
	.colour (colour), 
	.enable (1), 
	.rgb (rgb)
	);

mux Mux(
	.a (24'hffffff),
	.b (rgb),
	.sel (sel),
	.out (light)
	);

endmodule

