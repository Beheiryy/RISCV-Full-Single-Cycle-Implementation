`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2026 05:19:35 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit (
    input [4:0] MEM_WB_rd, ID_EX_rs1, ID_EX_rs2,
    input MEM_WB_reg_write,
    output reg forward_a, forward_b
    );
    always @(*) begin
        forward_a = 1'b0;
        forward_b = 1'b0;
        if (MEM_WB_reg_write && MEM_WB_rd != 5'b0 && ID_EX_rs1 == MEM_WB_rd)
            forward_a = 1'b1;
        else
            forward_a = 1'b0;
            
        if (MEM_WB_reg_write && MEM_WB_rd != 5'b0 && ID_EX_rs2 == MEM_WB_rd)
            forward_b = 1'b1;
        else
            forward_b = 1'b0;
            
    end
endmodule
// 1+   1-   2+   2-   3+   3-   4+   4-   5+   5-
// if   id   ex   mem  wb
//      no   no   no   no   no
//           if   id   ex   mem  wb
//                no   no   no   no  no
//                     if   id   ex  mem wb