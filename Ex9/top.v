//////////////////////////////////////////////////////////////////////////////////
// Exercise #8  - Simple End-to-End Design
// Student Name: Kian Hocking
// Date: 10/06/2021
//
//  Description: In this exercise, you need to design an air conditioning systems
//
//  inputs:
//           rst_n, clk_n, clk_p, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk_p,
    input clk_n,
     //Todo: add all other ports besides clk_n and clk_p 
    input rst_n,
    input temperature_0,
    input temperature_1,
    input temperature_2,
    input temperature_3,
    input temperature_4,
    input button,
    input blind_switch1,
    input blind_switch2,
    input select,
    input wire [3:0] blind_possible_positions,
    output heating,
    output cooling,
    output wire [23:0] light,
    output blind_position
   );

   //wire [23:0] light;
   //blind_possible_positions = {0, 1, 2, 3};	

   wire [1:0] blind_switches = {blind_switch1, blind_switch2};
   wire [4:0] temperature = {temperature_4, temperature_3, temperature_2, temperature_1, temperature_0};
    

   /* clock infrastructure, do not modify */
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     wire clk; //use this signal as a clock for your design
        
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );

//Add logic here

air_con air_con(
	.clk (clk), 
	.temperature (temperature), 
	.heating (heating), 
	.cooling (cooling)
	);

lights_selector lights_selector(
	.clk (clk), 
	.sel (select), 
	.rst (rst_n), 
	.button (button), 
	.light (light)
	);

blinds blinds(
	.a (blind_switches[0]),
	.b (blind_switches[1]),
	.func (blind_possible_positions),
	.out (blind_position)
	);




endmodule
