`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2018 08:38:43 PM
// Design Name: 
// Module Name: FreqMeasure
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


module FreqMeasure#(
    parameter DW = 16,
    parameter CNTW = 14
    )(
    input wire clk,
    input wire rst,
    input wire [DW - 1:0]Din,
    output logic [CNTW - 1:0]FreqCnt

    );
    logic [1:0]DinCapture;
    always_ff@(posedge clk)begin
      if(rst)DinCapture <=2'b0;
	  else begin
        DinCapture <= {DinCapture[0],Din[DW - 1]};
	  end
    end
    
    wire DinRise = DinCapture == 2'b10;
    
    logic [CNTW - 1:0]Cnt;
    always_ff@(posedge clk)begin
      if(rst)begin Cnt <= 0;FreqCnt <= 0;end
      else begin
        if(DinRise)begin
          FreqCnt <= Cnt;
          Cnt <= 0;
        end
        else begin
          Cnt <= Cnt + 1;
        end
      end
    end
    
endmodule
