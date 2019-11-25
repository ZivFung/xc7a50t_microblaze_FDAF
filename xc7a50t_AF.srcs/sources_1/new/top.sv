`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2018 05:04:41 PM
// Design Name: 
// Module Name: top
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


module top(
    output wire [12:0]DDR3_addr,
    output wire [2:0]DDR3_ba,
    output wire DDR3_cas_n,
    output wire [0:0]DDR3_ck_n,
    output wire [0:0]DDR3_ck_p,
    output wire [0:0]DDR3_cke,
    output wire [1:0]DDR3_dm,
    inout  wire [15:0]DDR3_dq,
    inout  wire [1:0]DDR3_dqs_n,
    inout  wire [1:0]DDR3_dqs_p,
    output wire [0:0]DDR3_odt,
    output wire DDR3_ras_n,
    output wire DDR3_reset_n,
    output wire DDR3_we_n,

    inout  wire spi_flash_io0_io,
    inout  wire spi_flash_io1_io,
    inout  wire [0:0]spi_flash_ss_io,
  
    input wire ADS8861_Dout1,
    output wire ADS8861_SCLK1,
    output wire ADS8861_CS1,
    output wire ADS8861_Din1,

    input wire ADS8861_Dout2,
    output wire ADS8861_SCLK2,
    output wire ADS8861_CS2,
    output wire ADS8861_Din2,
  
    output wire DAC8811_SCK,
    output wire DAC8811_SDO,
    output wire DAC8811_CS,
   
//  input  wire [6:0]key,
    input  wire [0:0]key, 
    output wire [7:0]led,
    input  wire clk

    );
    logic ui_addn_clk_100M;
    logic ui_addn_clk_200M;
    logic ui_addn_clk_66d7M;
    logic reset_66d7M;
    logic keyout;
    (*mark_debug = "true"*)logic [31:0]hl_control;
    logic rstFor66d7;always_ff@(posedge ui_addn_clk_66d7M)rstFor66d7 <= hl_control[0];
    keysprocess
    #(1)(ui_addn_clk_66d7M,key,keyout);
    
    logic SampleRate;
    (*mark_debug = "true"*)logic En1M;
    Counter #(100)En_1M(ui_addn_clk_100M,keyout,1,,En1M);
    Counter #(67)Sample_Rate(ui_addn_clk_66d7M,keyout,1,,SampleRate);
    logic signed[15:0]ADS8861Data1;
    (*mark_debug = "true"*)logic signed[15:0]ADS8861Data2;
    (*mark_debug = "true"*)logic ADS8861DataValid1;
    logic ADS8861DataValid2;
    ADS886X#(
        .CONVERTIONCNT(48),
        .BITS(16)
        )SignalSample(
        .clk(ui_addn_clk_66d7M),                      //66M
        .rst(0),
        .start(SampleRate), 
        .Dout(ADS8861_Dout1),
        .busy(),
        .CS(ADS8861_CS1),
        .SCLK(ADS8861_SCLK1),
        .AD886XData(ADS8861Data1),
        .Din(ADS8861_Din1),
        .OutEn(ADS8861DataValid1)
        ); 
    ADS886X#(
        .CONVERTIONCNT(48),
        .BITS(16)
        )NoiseSample(
        .clk(ui_addn_clk_66d7M),                      //66M 
        .rst(0),
        .start(SampleRate), 
        .Dout(ADS8861_Dout2),
        .busy(),
        .CS(ADS8861_CS2),
        .SCLK(ADS8861_SCLK2),
        .AD886XData(ADS8861Data2),
        .Din(ADS8861_Din2),
        .OutEn(ADS8861DataValid2)
        ); 
        
    (*mark_debug = "true"*)logic[31:0]ad_axis_tdata0,ad_axis_tdata1;
//    (*mark_debug = "true"*)logic signed[15:0]ad_debug;
//    assign ad_debug = ad_axis_tdata0[15:0];
    logic [31:0]ad_data_temp0,ad_data_temp1;
    (*mark_debug = "true"*)logic ad_axis_tready0,ad_axis_tready1,
    ad_axis_tvalid0,ad_axis_tvalid1,
    ad_axis_tlast0,ad_axis_tlast1;
    logic ad_axis_en0,ad_axis_en1;
    always_comb begin
        ad_axis_en0 = ad_axis_tready0 & ad_axis_tvalid0;
        ad_axis_en1 = ad_axis_tready1 & ad_axis_tvalid1;
    end
   
    logic[3:0] ad_axis_tuser,da_axis_tuser;
    always_comb begin
         ad_axis_tdata0 = ad_data_temp0;  
         ad_axis_tdata1 = ad_data_temp1; 
         da_axis_tuser = 4'b0;
    end
    
    (*mark_debug = "true"*)logic [8:0]ad_en_cnt0,ad_en_cnt1;
//    (*mark_debug = "true"*)logic [9:0]ad_en_cnt;
        
    always_ff@(posedge ui_addn_clk_66d7M)begin
//        if(keyout)begin
//            ad_en_cnt <= 0;
//        end
//        else begin
            if(~rstFor66d7)begin
                ad_en_cnt0 <= 0;
            end
            else if(ad_axis_en0)begin
                if(ad_en_cnt0 < 511)ad_en_cnt0 <= ad_en_cnt0 + 1;
//                if(ad_en_cnt < 1023)ad_en_cnt <= ad_en_cnt + 1;
                else ad_en_cnt0 <= 0;
            end
//        end
    end

    always_ff@(posedge ui_addn_clk_66d7M)begin
            if(~rstFor66d7)begin
                ad_en_cnt1 <= 0;
            end
            else if(ad_axis_en1)begin
                if(ad_en_cnt1 < 511)ad_en_cnt1 <= ad_en_cnt1 + 1;
                else ad_en_cnt1 <= 0;
            end
    end
    
//    always_comb ad_axis_tlast = (ad_en_cnt == 10'd1023) & ad_axis_en;
    always_comb begin
        ad_axis_tlast0 = (ad_en_cnt0 == 9'd511) & ad_axis_en0;
        ad_axis_tlast1 = (ad_en_cnt1 == 9'd511) & ad_axis_en1;
    end
    
    logic ad_write_state0,ad_write_state1;
    always_ff@(posedge ui_addn_clk_66d7M)begin
//        if(keyout)begin
//            ad_write_state <= '0;
//            ad_data_temp <= '0;
//        end
//        else begin
            if(~rstFor66d7)begin
                ad_data_temp0 <= 0;
                ad_write_state0 <= 0;
            end
            else if(ADS8861DataValid1)begin
//                ad_data_temp <= {ADS8861Data1,ADS8861Data2};
                ad_data_temp0 <= {16'b0, (ADS8861Data1)};
                ad_write_state0 <= 1;
            end
            else if(ad_axis_en0)ad_write_state0 <= '0;
//        end
    end
    
    always_ff@(posedge ui_addn_clk_66d7M)begin
            if(~rstFor66d7)begin
                ad_data_temp1 <= 0;
                ad_write_state1 <= 0;
            end
            else if(ADS8861DataValid2)begin
                ad_data_temp1 <= {16'b0,(ADS8861Data2)};
                ad_write_state1 <= 1;
            end
            else if(ad_axis_en1)ad_write_state1 <= '0;
    end
    
    always_comb begin
        ad_axis_tvalid0 = ad_write_state0;
        ad_axis_tvalid1 = ad_write_state1;
    end

    
    
    
    logic [31:0]da_axis_tdata;
    (*mark_debug = "true"*)logic da_axis_tlast;
    logic da_axis_tready,da_axis_tvalid;
    (*mark_debug = "true"*)logic da_axis_en;
    assign da_axis_en = da_axis_tready & da_axis_tvalid;
    
    logic signed [15:0]da_data_temp;
    logic signed [15:0]da_data_temp_temp;
    assign da_data_temp = da_axis_tdata[15:0];
    always_ff@(posedge ui_addn_clk_66d7M)da_data_temp_temp <= da_data_temp;
    
    (*mark_debug = "true"*)logic [15:0]DAC8811Data;
    logic da_busy;
//    (*mark_debug = "true"*)logic da_start;
    logic da_read_state;
    (*mark_debug = "true"*)logic da_axis_enDly;
    always_ff@(posedge ui_addn_clk_66d7M)da_axis_enDly <= da_axis_en;
    

//    always_ff@(posedge ui_addn_clk_100M)if(da_axis_en)da_data_temp <= da_axis_tdata;

    assign da_axis_tready = da_read_state & (~da_axis_enDly); 
    always_ff@(posedge ui_addn_clk_66d7M)begin
        if(keyout)begin
            da_read_state <= '0;
        end
        else begin
            if(SampleRate & da_axis_tvalid)da_read_state <= 1;
            else if(da_axis_en)da_read_state <= '0;
        end
    end
    
//    always_ff@(posedge ui_addn_clk_100M)begin
//        if(En1M)da_axis_tready <= 1;
//        else if(da_axis_tready)da_axis_tready <= 0;
//    end
    
//    always_ff@(posedge ui_addn_clk_100M)begin
//        if(keyout)begin
//            da_start <= '0;
//        end
//        else begin
//            if(da_axis_en)da_start <= 1;
//            else if(da_start) da_start <= '0;
//        end
//    end
//    always_ff@(posedge ui_addn_clk_100M)begin
//        if(keyout)DAC8811Data <= '0;
//        else begin
//            if(da_axis_en)DAC8811Data <= da_data_temp[15:0] + 16'd32768;
//        end
//    end
    always_comb DAC8811Data = da_data_temp_temp + 16'd32768;
//    always_ff@(posedge ui_addn_clk_100M)begin
//        if(da_axis_en)DAC8811Data <= (da_data_temp_temp) + 16'd32768;
//    end    


    DACx811_15nsClk #(1, 16)the_DAC881(       
      .clk(ui_addn_clk_66d7M),        
      .rst(keyout),        
      .start(da_axis_enDly),       
      .data(DAC8811Data),       
      .busy(da_busy),       
      .sck(DAC8811_SCK),        
      .sdo(DAC8811_SDO),     
      .cs_n(DAC8811_CS)    
      );  
    
    
    microblaze_wrapper(
        .DDR3_addr(DDR3_addr),
        .DDR3_ba(DDR3_ba),
        .DDR3_cas_n(DDR3_cas_n),
        .DDR3_ck_n(DDR3_ck_n),
        .DDR3_ck_p(DDR3_ck_p), 
        .DDR3_cke(DDR3_cke),
        .DDR3_dm(DDR3_dm),
        .DDR3_dq(DDR3_dq),
        .DDR3_dqs_n(DDR3_dqs_n),
        .DDR3_dqs_p(DDR3_dqs_p),
        .DDR3_odt(DDR3_odt),
        .DDR3_ras_n(DDR3_ras_n),
        .DDR3_reset_n(DDR3_reset_n),
        .DDR3_we_n(DDR3_we_n),
        .gpio_led_tri_o(led),
        
//        .ad_axis_tdata(ad_axis_tdata),
//        .ad_axis_tready(ad_axis_tready),
//        //.ad_axis_tuser(ad_axis_tuser),
//        .ad_axis_tvalid(ad_axis_tvalid),
//        .ad_axis_tlast(ad_axis_tlast),
        .ad_axis_0_tdata(ad_axis_tdata0),
        .ad_axis_0_tlast(ad_axis_tlast0),
        .ad_axis_0_tready(ad_axis_tready0),
        .ad_axis_0_tvalid(ad_axis_tvalid0),
        .ad_axis_1_tdata(ad_axis_tdata1),
        .ad_axis_1_tlast(ad_axis_tlast1),
        .ad_axis_1_tready(ad_axis_tready1),
        .ad_axis_1_tvalid(ad_axis_tvalid1),
        .da_axis_tdata(da_axis_tdata),
        .da_axis_tlast(da_axis_tlast),
        .da_axis_tready(da_axis_tready),
        .da_axis_tuser(da_axis_tuser),
        .da_axis_tvalid(da_axis_tvalid),
        .s_aresetn_adfifo(hl_control[0]),
//        .ad_axis_aresetn(1'b1),
//        .ad_axis_tdata(ad_axis_tdata),
//        .ad_axis_tready(ad_axis_tready),
//        .ad_axis_tkeep(ad_axis_tkeep),
//        .ad_axis_tvalid(ad_axis_tvalid),
////        .ad_axis_tlast(ad_axis_tlast),
//        .fifo_count(fifo_count),
//        .da_axis_tdata(da_axis_tdata),
//        .da_axis_tready(da_axis_tready),
//        .da_axis_tvalid(da_axis_tvalid),
        .spi_flash_io0_io(spi_flash_io0_io),
        .spi_flash_io1_io(spi_flash_io1_io),
        .spi_flash_ss_io(spi_flash_ss_io),
        .MBData0(hl_control),
        .sys_clk_i(clk),
        .sys_rst(1'b1),
        .peripheral_aresetn(reset_66d7M),
        .ui_addn_clk_100M(ui_addn_clk_100M),
        .ui_addn_clk_66M(ui_addn_clk_66d7M)
        );     
        
    
endmodule
