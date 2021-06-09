//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 - RGB Colour Converter
// Student Name: Kian Hocking
// Date: 09/06/2021
//
//
//  Description: In this exercise, you need to design a memory with 8 entries, 
//  converting colours to their RGB code.
//
//  inputs:
//           clk, colour [2:0], enable
//
//  outputs:
//           rgb [23:0]
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module colour_converter(clk, colour, enable, rgb);

input clk, enable;
input[2:0] colour;
output[23:0] rgb;


//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
blk_mem_gen_0 your_instance_name (
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire enable
  .wea(wea),      
  .addra(colour),      // input wire [2:0] colour
  .dina(0),    // input wire [23 : 0] dina
  .douta(rgb)  // output wire [23 : 0] douta
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

endmodule
