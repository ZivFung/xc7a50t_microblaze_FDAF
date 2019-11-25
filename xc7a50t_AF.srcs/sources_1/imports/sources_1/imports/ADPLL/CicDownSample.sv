`timescale 1ns/100ps
module Counter #(
    parameter M = 100
)(
    input wire clk, rst, en,
    output logic [$clog2(M) - 1 : 0] cnt,
    output logic co
);
    assign co = en & (cnt == M - 1);
    always_ff@(posedge clk) begin
        if(rst) cnt <= '0;
        else if(en) begin
            if(cnt < M - 1) cnt <= cnt + 1'b1;
            else cnt <= '0;
        end
    end
endmodule

module InterpDeci #( parameter W = 10 )(
    input wire clk, rst, eni, eno,
    input wire signed [W-1:0] in,
    output logic signed [W-1:0] out
);
    logic signed [W-1:0] candi;
    always_ff@(posedge clk) begin
        if(rst) candi <= '0;
        else if(eni) candi <= in;
        else if(eno) candi <= '0;
    end
    always_ff@(posedge clk) begin
        if(rst) out <= '0;
        else if(eno) out <= candi;
    end
endmodule

module Integrator #( parameter W = 10 )(
    input wire clk, rst, en,
    input wire signed [W-1:0] in,
    output logic signed [W-1:0] out
);
    always_ff@(posedge clk) begin
        if(rst) out <= '0;
        else if(en) out <= out + in;
    end
endmodule

module Comb #( parameter W = 10, M = 1 )(
    input wire clk, rst, en,
    input wire signed [W-1:0] in,
    output logic signed [W-1:0] out
);
    logic signed [W-1:0] dly[M];    // imp z^-M
    generate
        if(M > 1) begin
            always_ff@(posedge clk) begin
                if(rst) dly <= '{M{'0}};
                else if(en) dly <= {in, dly[0:M-2]};
            end
        end
        else begin
            always_ff@(posedge clk) begin
                if(rst) dly <= '{M{'0}};
                else if(en) dly[0] <= in;
            end
        end
    endgenerate
    always_ff@(posedge clk) begin
        if(rst) out <= '0;
        else if(en) out <= in - dly[M-1];
    end
endmodule

module CicDownSampler #( parameter W = 10, R = 4, M = 1, N = 2,DW = 56 )(   //R???? M???????????=2^N? N: ?????
    input wire clk, rst, eni, eno,
    input wire signed [W-1:0] in,
    output logic signed [W-1:0] out
);
    localparam real GAIN = (real'(R) * M)**(N);
//    localparam integer DW = W + $ceil($ln(GAIN)/$ln(2.0));
    logic signed [DW-1:0] intgs_data[N+1];
    assign intgs_data[0] = in;
    generate                                         //N??????
        for(genvar k = 0; k < N; k++) begin : Intgs
            Integrator #(DW) theIntg(
                clk, rst, eni, intgs_data[k], intgs_data[k+1]);
        end
    endgenerate
    logic signed [DW-1:0] combs_data[N+1];
    InterpDeci #(DW) theDeci(                         //????
        clk, rst, eni, eno, intgs_data[N], combs_data[0]);
    generate
        for(genvar k = 0; k < N; k++) begin : Combs
            Comb #(DW, M) theComb(
                clk, rst, eno, combs_data[k], combs_data[k+1]);
        end
    endgenerate
    // Q1.(DW-1)
    wire signed [DW-1:0] attn = (1.0 / GAIN * 2**(DW-1));
//    wire signed [2*DW-1:0] OutTemp = (2*DW)'(combs_data[N]) * (2*DW)'(attn);
    always_ff@(posedge clk) begin
        if(rst) out <= '0;
//        else if(eno) out <= OutTemp >>> 15;
        else if(eno) out <= ((2*DW)'(combs_data[N]) * (2*DW)'(attn)) >>> (DW-1);
    end
endmodule
