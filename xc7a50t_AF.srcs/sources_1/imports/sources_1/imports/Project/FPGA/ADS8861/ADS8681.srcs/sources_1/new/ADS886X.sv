`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2018 09:48:05 PM
// Design Name: 
// Module Name: ADS886X
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


module ADS886X#(
    parameter CONVERTIONCNT = 47,
    parameter BITS = 16
    )(
    input wire clk,                      //66M
    input wire rst,
    input wire start, 
    input wire Dout,
    output logic busy = '0,
    output logic CS,
    output logic SCLK,
    output logic signed[15:0]AD886XData,
    output logic Din,
    output logic OutEn
    );
    
    assign Din = 1'b1;
                         //3-wire operation
    logic ConvertionEnd;
    always_ff@(posedge clk)begin
      if(rst)begin
        busy <= 0;
      end
      else begin
        if(start) busy <= 1'b1;
        else if(ConvertionEnd) busy <= 1'b0;
      end
    end
    

    logic [$clog2(CONVERTIONCNT + BITS + 3) - 1: 0] ConvCnt;
    //                             + 3
    Counter #(CONVERTIONCNT + BITS + 1) ConvertionCnt(clk, rst, start | busy, ConvCnt, ConvertionEnd);
    
    logic [BITS - 1:0]Shifter;
    always_ff@(posedge clk)begin        //always_ff@(negedge clk)begin
      if(rst)begin
        Shifter <= 0;
      end
      else begin
        if((ConvCnt > CONVERTIONCNT) & (ConvCnt <= CONVERTIONCNT + BITS))   //if((ConvCnt > CONVERTIONCNT) & (ConvCnt <= CONVERTIONCNT + BITS))
          Shifter <= {Shifter[BITS - 2:0],Dout};
        else if(start)
          Shifter <= 1'b0;
      end
    end
    logic CoDly;always_ff@(posedge clk)CoDly <= ConvertionEnd;
//    logic OutEnDelay;
    always_ff@(posedge clk)begin
      if(rst)begin
        AD886XData <= 0;
      end
      else begin
        if(CoDly)AD886XData <= Shifter; //if(ConvertionEnd)AD886XData <= Shifter;
      end
    end
    
    always_ff@(posedge clk)begin
      OutEn <= CoDly;       //OutEn <= ConvertionEnd;
    end
    
    assign CS = (ConvCnt >= CONVERTIONCNT)? 0 : 1;
    assign SCLK = (ConvCnt > CONVERTIONCNT & ConvCnt <= CONVERTIONCNT + BITS)? clk : 0;
   
endmodule
