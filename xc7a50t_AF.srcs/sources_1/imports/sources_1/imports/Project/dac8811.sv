//module Counter #(parameter M = 100)(
//    input wire clk, rst, en,
//    output logic [$clog2(M) - 1 : 0] cnt,
//    output logic co
//);
//    initial begin cnt <= '0; end
//    always_ff@(posedge clk) begin
//        if(rst) cnt <= '0;
//        else if(en) begin
//            if(cnt < M - 1) cnt <= cnt + 1'b1;
//            else cnt <= '0;
//        end
//    end
//    assign co = en & (cnt == M - 1);
//endmodule

module DACx811_15nsClk #(
    parameter HBDIV = 1, // half bit divider
    parameter BITS = 16  // 16 for 8811, 12 for 7811
)(
    input wire clk, rst, start,
    input wire [BITS - 1 : 0] data,
    output logic busy = '0,
    output logic sck, sdo, cs_n
);
    logic hbr_co, hbc_co;
    logic [$clog2(BITS * 2 + 2) - 1 : 0] hbc_cnt;
    Counter #(HBDIV) hbRateCnt(clk, rst, start | busy, , hbr_co);
    Counter #(BITS * 2 + 2) hbCnt(clk, rst, hbr_co, hbc_cnt, hbc_co);
    always_ff@(posedge clk)
    begin
        if(start) busy <= 1'b1;
        else if(hbc_co) busy <= 1'b0;
    end
    logic [BITS - 1 : 0] shifter = '0;
    always_ff@(posedge clk)
    begin
        if(rst) shifter <= '0;
        else if(start) shifter <= data;
        else if(hbr_co & ~hbc_cnt[0]) shifter <= shifter << 1;
    end
    always_ff@(posedge clk)
    begin
        sck <= busy & ~hbc_cnt[0];
        cs_n <= ~busy;
        sdo <= shifter[BITS - 1];
    end
endmodule