`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2026 11:18:20 AM
// Design Name: 
// Module Name: cpu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module cpu_tb();
    reg clk, reset;
    
    cpu cpu(.clk(clk), .reset(reset));
    
    initial begin
        clk = 0;
        reset = 1;
        forever #100 clk = ~clk;
    end
    
    initial begin
        #5
        reset = 0;
    end
   
endmodule
