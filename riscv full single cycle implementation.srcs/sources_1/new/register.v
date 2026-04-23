`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2026 04:58:15 PM
// Design Name: 
// Module Name: register
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


`timescale 1ns / 1ps
module register #(parameter n = 32)(
    input clk, input reset, input load, input [n-1:0] data, output [n-1:0] out 
    );
    genvar i;
    generate
        for(i = 0; i < n; i = i + 1) begin: genloop
            wire dff_data;
            mux mux(.a(out[i]), .b(data[i]), .s(load), .c(dff_data));
            dff dff(.clk(clk), .reset(reset), .data(dff_data), .out(out[i]));
        end
    endgenerate 
endmodule
