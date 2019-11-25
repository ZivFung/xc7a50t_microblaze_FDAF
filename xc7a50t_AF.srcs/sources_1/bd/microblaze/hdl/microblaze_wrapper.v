//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
//Date        : Sat Jan 26 17:35:29 2019
//Host        : localhost.localdomain running 64-bit unknown
//Command     : generate_target microblaze_wrapper.bd
//Design      : microblaze_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module microblaze_wrapper
   (DDR3_addr,
    DDR3_ba,
    DDR3_cas_n,
    DDR3_ck_n,
    DDR3_ck_p,
    DDR3_cke,
    DDR3_dm,
    DDR3_dq,
    DDR3_dqs_n,
    DDR3_dqs_p,
    DDR3_odt,
    DDR3_ras_n,
    DDR3_reset_n,
    DDR3_we_n,
    MBData0,
    ad_axis_0_tdata,
    ad_axis_0_tlast,
    ad_axis_0_tready,
    ad_axis_0_tvalid,
    ad_axis_1_tdata,
    ad_axis_1_tlast,
    ad_axis_1_tready,
    ad_axis_1_tvalid,
    da_axis_tdata,
    da_axis_tlast,
    da_axis_tready,
    da_axis_tuser,
    da_axis_tvalid,
    gpio_led_tri_o,
    peripheral_aresetn,
    s_aresetn_adfifo,
    spi_flash_io0_io,
    spi_flash_io1_io,
    spi_flash_ss_io,
    sys_clk_i,
    sys_rst,
    ui_addn_clk_100M,
    ui_addn_clk_66M);
  output [12:0]DDR3_addr;
  output [2:0]DDR3_ba;
  output DDR3_cas_n;
  output [0:0]DDR3_ck_n;
  output [0:0]DDR3_ck_p;
  output [0:0]DDR3_cke;
  output [1:0]DDR3_dm;
  inout [15:0]DDR3_dq;
  inout [1:0]DDR3_dqs_n;
  inout [1:0]DDR3_dqs_p;
  output [0:0]DDR3_odt;
  output DDR3_ras_n;
  output DDR3_reset_n;
  output DDR3_we_n;
  output [31:0]MBData0;
  input [31:0]ad_axis_0_tdata;
  input ad_axis_0_tlast;
  output ad_axis_0_tready;
  input ad_axis_0_tvalid;
  input [31:0]ad_axis_1_tdata;
  input ad_axis_1_tlast;
  output ad_axis_1_tready;
  input ad_axis_1_tvalid;
  output [31:0]da_axis_tdata;
  output da_axis_tlast;
  input da_axis_tready;
  output [3:0]da_axis_tuser;
  output da_axis_tvalid;
  output [7:0]gpio_led_tri_o;
  output [0:0]peripheral_aresetn;
  input s_aresetn_adfifo;
  inout spi_flash_io0_io;
  inout spi_flash_io1_io;
  inout [0:0]spi_flash_ss_io;
  input sys_clk_i;
  input sys_rst;
  output ui_addn_clk_100M;
  output ui_addn_clk_66M;

  wire [12:0]DDR3_addr;
  wire [2:0]DDR3_ba;
  wire DDR3_cas_n;
  wire [0:0]DDR3_ck_n;
  wire [0:0]DDR3_ck_p;
  wire [0:0]DDR3_cke;
  wire [1:0]DDR3_dm;
  wire [15:0]DDR3_dq;
  wire [1:0]DDR3_dqs_n;
  wire [1:0]DDR3_dqs_p;
  wire [0:0]DDR3_odt;
  wire DDR3_ras_n;
  wire DDR3_reset_n;
  wire DDR3_we_n;
  wire [31:0]MBData0;
  wire [31:0]ad_axis_0_tdata;
  wire ad_axis_0_tlast;
  wire ad_axis_0_tready;
  wire ad_axis_0_tvalid;
  wire [31:0]ad_axis_1_tdata;
  wire ad_axis_1_tlast;
  wire ad_axis_1_tready;
  wire ad_axis_1_tvalid;
  wire [31:0]da_axis_tdata;
  wire da_axis_tlast;
  wire da_axis_tready;
  wire [3:0]da_axis_tuser;
  wire da_axis_tvalid;
  wire [7:0]gpio_led_tri_o;
  wire [0:0]peripheral_aresetn;
  wire s_aresetn_adfifo;
  wire spi_flash_io0_i;
  wire spi_flash_io0_io;
  wire spi_flash_io0_o;
  wire spi_flash_io0_t;
  wire spi_flash_io1_i;
  wire spi_flash_io1_io;
  wire spi_flash_io1_o;
  wire spi_flash_io1_t;
  wire [0:0]spi_flash_ss_i_0;
  wire [0:0]spi_flash_ss_io_0;
  wire [0:0]spi_flash_ss_o_0;
  wire spi_flash_ss_t;
  wire sys_clk_i;
  wire sys_rst;
  wire ui_addn_clk_100M;
  wire ui_addn_clk_66M;

  microblaze microblaze_i
       (.DDR3_addr(DDR3_addr),
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
        .MBData0(MBData0),
        .ad_axis_0_tdata(ad_axis_0_tdata),
        .ad_axis_0_tlast(ad_axis_0_tlast),
        .ad_axis_0_tready(ad_axis_0_tready),
        .ad_axis_0_tvalid(ad_axis_0_tvalid),
        .ad_axis_1_tdata(ad_axis_1_tdata),
        .ad_axis_1_tlast(ad_axis_1_tlast),
        .ad_axis_1_tready(ad_axis_1_tready),
        .ad_axis_1_tvalid(ad_axis_1_tvalid),
        .da_axis_tdata(da_axis_tdata),
        .da_axis_tlast(da_axis_tlast),
        .da_axis_tready(da_axis_tready),
        .da_axis_tuser(da_axis_tuser),
        .da_axis_tvalid(da_axis_tvalid),
        .gpio_led_tri_o(gpio_led_tri_o),
        .peripheral_aresetn(peripheral_aresetn),
        .s_aresetn_adfifo(s_aresetn_adfifo),
        .spi_flash_io0_i(spi_flash_io0_i),
        .spi_flash_io0_o(spi_flash_io0_o),
        .spi_flash_io0_t(spi_flash_io0_t),
        .spi_flash_io1_i(spi_flash_io1_i),
        .spi_flash_io1_o(spi_flash_io1_o),
        .spi_flash_io1_t(spi_flash_io1_t),
        .spi_flash_ss_i(spi_flash_ss_i_0),
        .spi_flash_ss_o(spi_flash_ss_o_0),
        .spi_flash_ss_t(spi_flash_ss_t),
        .sys_clk_i(sys_clk_i),
        .sys_rst(sys_rst),
        .ui_addn_clk_100M(ui_addn_clk_100M),
        .ui_addn_clk_66M(ui_addn_clk_66M));
  IOBUF spi_flash_io0_iobuf
       (.I(spi_flash_io0_o),
        .IO(spi_flash_io0_io),
        .O(spi_flash_io0_i),
        .T(spi_flash_io0_t));
  IOBUF spi_flash_io1_iobuf
       (.I(spi_flash_io1_o),
        .IO(spi_flash_io1_io),
        .O(spi_flash_io1_i),
        .T(spi_flash_io1_t));
  IOBUF spi_flash_ss_iobuf_0
       (.I(spi_flash_ss_o_0),
        .IO(spi_flash_ss_io[0]),
        .O(spi_flash_ss_i_0),
        .T(spi_flash_ss_t));
endmodule
