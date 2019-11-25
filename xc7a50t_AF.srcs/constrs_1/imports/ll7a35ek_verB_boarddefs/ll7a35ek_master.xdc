#Clock signal
create_clock -period 10.000 -name sys_clk_pin -add [get_ports clk]

# Clock Pin, 100MHz input
set_property PACKAGE_PIN N11 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
# DDR3 Pins, See ll7a35ek_ddr3.xdc which is used by mig tools, not here

# Flash Pins
set_property PACKAGE_PIN J13 [get_ports spi_flash_io0_io]
set_property PACKAGE_PIN J14 [get_ports spi_flash_io1_io]
##set_property PACKAGE_PIN K15 [get_ports spi_flash_io2_io];     # uncomment this line if using spix4 mode
##set_property PACKAGE_PIN K16 [get_ports spi_flash_io3_io];     # uncomment this line if using spix4 mode
set_property PACKAGE_PIN L12 [get_ports {spi_flash_ss_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports spi_flash_*]

# Keys' Pin
set_property PACKAGE_PIN T4 [get_ports {key[0]}]
#set_property PACKAGE_PIN T3 [get_ports {key[1]}]
#set_property PACKAGE_PIN R1 [get_ports {key[2]}]
#set_property PACKAGE_PIN T2 [get_ports {key[3]}]
#set_property PACKAGE_PIN R2 [get_ports {key[4]}]
#set_property PACKAGE_PIN P1 [get_ports {key[5]}]
#set_property PACKAGE_PIN R3 [get_ports {key[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key[*]}]
# LEDs' Pin
set_property PACKAGE_PIN P5 [get_ports {led[0]}]
set_property PACKAGE_PIN L5 [get_ports {led[1]}]
set_property PACKAGE_PIN N4 [get_ports {led[2]}]
set_property PACKAGE_PIN P4 [get_ports {led[3]}]
set_property PACKAGE_PIN M4 [get_ports {led[4]}]
set_property PACKAGE_PIN L4 [get_ports {led[5]}]
set_property PACKAGE_PIN P3 [get_ports {led[6]}]
set_property PACKAGE_PIN N3 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]


##LCD's pin
#set_property PACKAGE_PIN M6   [get_ports wr];
#set_property PACKAGE_PIN R5   [get_ports rd];
#set_property PACKAGE_PIN T5   [get_ports rst];
#set_property PACKAGE_PIN N6   [get_ports rs];
#set_property PACKAGE_PIN R6   [get_ports cs];
#set_property PACKAGE_PIN T7   [get_ports db[0]];
#set_property PACKAGE_PIN T8   [get_ports db[1]];
#set_property PACKAGE_PIN T9   [get_ports db[2]];
#set_property PACKAGE_PIN T10  [get_ports db[3]];
#set_property PACKAGE_PIN R12  [get_ports db[4]];
#set_property PACKAGE_PIN T12  [get_ports db[5]];
#set_property PACKAGE_PIN R13  [get_ports db[6]];
#set_property PACKAGE_PIN T13  [get_ports db[7]];
#set_property PACKAGE_PIN T15  [get_ports db[8]];
#set_property PACKAGE_PIN T14  [get_ports db[9]];
#set_property PACKAGE_PIN R16  [get_ports db[10]];
#set_property PACKAGE_PIN R15  [get_ports db[11]];
#set_property PACKAGE_PIN P16  [get_ports db[12]];
#set_property PACKAGE_PIN P15  [get_ports db[13]];
#set_property PACKAGE_PIN N16  [get_ports db[14]];
#set_property PACKAGE_PIN M16  [get_ports db[15]];
#set_property IOSTANDARD LVCMOS33 [get_ports db[*]];
#set_property IOSTANDARD LVCMOS33 [get_ports wr];
#set_property IOSTANDARD LVCMOS33 [get_ports rd];
#set_property IOSTANDARD LVCMOS33 [get_ports rs];
#set_property IOSTANDARD LVCMOS33 [get_ports cs];
#set_property IOSTANDARD LVCMOS33 [get_ports rst];

##ADS8681_1's Pins
#set_property PACKAGE_PIN E1 [get_ports ad1_ads8681_cs]
#set_property PACKAGE_PIN D1 [get_ports ad1_ads8681_sdo1]
#set_property PACKAGE_PIN A2 [get_ports ad1_ads8681_sdo2]
#set_property PACKAGE_PIN B2 [get_ports ad1_ads8681_rvs]
#set_property PACKAGE_PIN F2 [get_ports ad1_ads8681_sdi]
#set_property PACKAGE_PIN E2 [get_ports ad1_ads8681_sclk]
#set_property IOSTANDARD LVCMOS33 [get_ports ad1_ads8681_*]
##ADS8681_2's Pins
#set_property PACKAGE_PIN L3 [get_ports ad2_ads8681_cs]
#set_property PACKAGE_PIN H1 [get_ports ad2_ads8681_sdo1]
#set_property PACKAGE_PIN G2 [get_ports ad2_ads8681_sdo2]
#set_property PACKAGE_PIN G1 [get_ports ad2_ads8681_rvs]
#set_property PACKAGE_PIN L2 [get_ports ad2_ads8681_sdi]
#set_property PACKAGE_PIN H2 [get_ports ad2_ads8681_sclk]
#set_property IOSTANDARD LVCMOS33 [get_ports ad2_ads8681_*]

#ADS8861's Pins
set_property PACKAGE_PIN A5 [get_ports ADS8861_CS1]
set_property PACKAGE_PIN B6 [get_ports ADS8861_SCLK1]
set_property PACKAGE_PIN B5 [get_ports ADS8861_Dout1]
set_property PACKAGE_PIN A7 [get_ports ADS8861_Din1]

set_property PACKAGE_PIN A2 [get_ports ADS8861_CS2]
set_property PACKAGE_PIN B4 [get_ports ADS8861_SCLK2]
set_property PACKAGE_PIN A3 [get_ports ADS8861_Dout2]
set_property PACKAGE_PIN A4 [get_ports ADS8861_Din2]
set_property IOSTANDARD LVCMOS33 [get_ports ADS8861_*]

#DAC8811's Pin
set_property PACKAGE_PIN E2 [get_ports DAC8811_SCK]
set_property PACKAGE_PIN D1 [get_ports DAC8811_SDO]
set_property PACKAGE_PIN E1 [get_ports DAC8811_CS]
set_property IOSTANDARD LVCMOS33 [get_ports DAC8811_*]

#set_property PACKAGE_PIN H3 [get_ports NoiseCmp]
#set_property IOSTANDARD LVCMOS33 [get_ports NoiseCmp]
##touch's pin
#set_property PACKAGE_PIN K13  [get_ports mosi];
#set_property PACKAGE_PIN L14  [get_ports tcs];
#set_property PACKAGE_PIN L13  [get_ports pen];
#set_property PACKAGE_PIN M14  [get_ports tclk];
#set_property IOSTANDARD LVCMOS33 [get_ports mosi];
#set_property IOSTANDARD LVCMOS33 [get_ports tcs];
#set_property IOSTANDARD LVCMOS33 [get_ports pen];
#set_property IOSTANDARD LVCMOS33 [get_ports tclk];



# XADC's Vp & Vn, not use(tied ground)
#set_property PACKAGE_PIN H8 [get_ports Vp_Vn_v_p];
#set_property PACKAGE_PIN J7 [get_ports Vp_Vn_v_n];

# LCD pins
#set_property PACKAGE_PIN M2 [get_ports lcd_scl];
#set_property PACKAGE_PIN N1 [get_ports lcd_sda];
#set_property PACKAGE_PIN M1 [get_ports lcd_rstn];

##ad7705's Pin
#set_property PACKAGE_PIN D6  [get_ports adcs];  # p
#set_property PACKAGE_PIN D5  [get_ports addin];  # n
#set_property PACKAGE_PIN D4  [get_ports adclk];  # p
#set_property PACKAGE_PIN D6  [get_ports addout];  # p
#set_property PACKAGE_PIN D5  [get_ports adrst];  # n
#set_property PACKAGE_PIN D4  [get_ports addrdy];  # p
#set_property IOSTANDARD LVCMOS33 [get_ports adcs];
#set_property IOSTANDARD LVCMOS33 [get_ports adsdi];
#set_property IOSTANDARD LVCMOS33 [get_ports adclk];
#set_property IOSTANDARD LVCMOS33 [get_ports addout];
#set_property IOSTANDARD LVCMOS33 [get_ports adrst];
#set_property IOSTANDARD LVCMOS33 [get_ports addrdy];

##ad7683's Pin
#set_property PACKAGE_PIN D4  [get_ports adcs];  # p
#set_property PACKAGE_PIN D5  [get_ports adsdi];  # n
#set_property PACKAGE_PIN D6  [get_ports adclk];  # p
#set_property IOSTANDARD LVCMOS33 [get_ports adcs];
#set_property IOSTANDARD LVCMOS33 [get_ports adsdi];
#set_property IOSTANDARD LVCMOS33 [get_ports adclk];

##dac8811's Pin
#set_property PACKAGE_PIN J1  [get_ports dacs];  # p
#set_property PACKAGE_PIN K2  [get_ports daclk];  # n
#set_property PACKAGE_PIN L2  [get_ports dasdi];  # p
#set_property IOSTANDARD LVCMOS33 [get_ports dacs];
#set_property IOSTANDARD LVCMOS33 [get_ports daclk];
#set_property IOSTANDARD LVCMOS33 [get_ports dasdi];

# PA
#set_property PACKAGE_PIN B7  [get_ports pa04];  # p
#set_property PACKAGE_PIN A7  [get_ports pa05];  # n
#set_property PACKAGE_PIN B6  [get_ports pa07];  # p
#set_property PACKAGE_PIN B5  [get_ports pa08];  # n
#set_property PACKAGE_PIN A5  [get_ports pa10];  # p
#set_property PACKAGE_PIN A4  [get_ports pa11];  # n
#set_property PACKAGE_PIN B4  [get_ports pa13];  # p
#set_property PACKAGE_PIN A3  [get_ports pa14];  # n
#set_property PACKAGE_PIN B2  [get_ports pa16];  # p
#set_property PACKAGE_PIN A2  [get_ports pa17];  # n
#set_property PACKAGE_PIN B1  [get_ports pa24];  # n
#set_property PACKAGE_PIN C1  [get_ports pa25];  # p
#set_property PACKAGE_PIN D1  [get_ports pa27];  # n
#set_property PACKAGE_PIN E2  [get_ports pa28];  # p
#set_property PACKAGE_PIN E1  [get_ports pa30];  # n
#set_property PACKAGE_PIN F2  [get_ports pa31];  # p
#set_property PACKAGE_PIN G1  [get_ports pa33];  # n
#set_property PACKAGE_PIN G2  [get_ports pa34];  # p
#set_property PACKAGE_PIN H1  [get_ports pa36];  # n
#set_property PACKAGE_PIN H2  [get_ports pa37];  # p
#set_property PACKAGE_PIN L3  [get_ports pa44];  # p
#set_property PACKAGE_PIN L2  [get_ports pa45];  # n
#set_property PACKAGE_PIN K3  [get_ports pa47];  # p
#set_property PACKAGE_PIN K2  [get_ports pa48];  # n
#set_property PACKAGE_PIN K1  [get_ports pa50];  # p
#set_property PACKAGE_PIN J1  [get_ports pa51];  # n
#set_property PACKAGE_PIN J3  [get_ports pa53];  # p
#set_property PACKAGE_PIN H3  [get_ports pa54];  # n
#set_property PACKAGE_PIN F4  [get_ports pa56];  # p
#set_property PACKAGE_PIN F3  [get_ports pa57];  # n
#set_property PACKAGE_PIN C2  [get_ports pa64];  # n
#set_property PACKAGE_PIN C3  [get_ports pa65];  # p
#set_property PACKAGE_PIN D3  [get_ports pa67];  # n
#set_property PACKAGE_PIN E3  [get_ports pa68];  # p
#set_property PACKAGE_PIN C4  [get_ports pa70];  # n
#set_property PACKAGE_PIN D4  [get_ports pa71];  # p
#set_property PACKAGE_PIN D5  [get_ports pa73];  # n
#set_property PACKAGE_PIN D6  [get_ports pa74];  # p
#set_property PACKAGE_PIN C6  [get_ports pa76];  # n
#set_property PACKAGE_PIN C7  [get_ports pa77];  # p

# PB
#set_property PACKAGE_PIN R5  [get_ports pb04];  # p
#set_property PACKAGE_PIN T5  [get_ports pb05];  # n
#set_property PACKAGE_PIN T7  [get_ports pb07];  # p
#set_property PACKAGE_PIN T8  [get_ports pb08];  # n
#set_property PACKAGE_PIN T9  [get_ports pb10];  # p
#set_property PACKAGE_PIN T10 [get_ports pb11];  # n
#set_property PACKAGE_PIN R12 [get_ports pb13];  # p
#set_property PACKAGE_PIN T12 [get_ports pb14];  # n
#set_property PACKAGE_PIN R13 [get_ports pb16];  # p
#set_property PACKAGE_PIN T13 [get_ports pb17];  # n
#set_property PACKAGE_PIN T15 [get_ports pb27];  # n
#set_property PACKAGE_PIN T14 [get_ports pb28];  # p
#set_property PACKAGE_PIN R16 [get_ports pb30];  # n
#set_property PACKAGE_PIN R15 [get_ports pb31];  # p
#set_property PACKAGE_PIN P16 [get_ports pb33];  # n
#set_property PACKAGE_PIN P15 [get_ports pb34];  # p
#set_property PACKAGE_PIN N16 [get_ports pb36];  # n
#set_property PACKAGE_PIN M16 [get_ports pb37];  # p
#set_property PACKAGE_PIN K13 [get_ports pb44];  # p
#set_property PACKAGE_PIN L13 [get_ports pb45];  # n
#set_property PACKAGE_PIN L14 [get_ports pb47];  # p
#set_property PACKAGE_PIN M14 [get_ports pb48];  # n
#set_property PACKAGE_PIN N13 [get_ports pb50];  # p
#set_property PACKAGE_PIN P13 [get_ports pb51];  # n
#set_property PACKAGE_PIN N14 [get_ports pb53];  # p
#set_property PACKAGE_PIN P14 [get_ports pb54];  # n
#set_property PACKAGE_PIN P10 [get_ports pb56];  # p
#set_property PACKAGE_PIN P11 [get_ports pb57];  # n
#set_property PACKAGE_PIN R11 [get_ports pb64];  # n
#set_property PACKAGE_PIN R10 [get_ports pb65];  # p
#set_property PACKAGE_PIN P9  [get_ports pb67];  # n
#set_property PACKAGE_PIN N9  [get_ports pb68];  # p
#set_property PACKAGE_PIN R8  [get_ports pb70];  # n
#set_property PACKAGE_PIN P8  [get_ports pb71];  # p
#set_property PACKAGE_PIN R7  [get_ports pb73];  # n
#set_property PACKAGE_PIN R6  [get_ports pb74];  # p
#set_property PACKAGE_PIN N6  [get_ports pb76];  # n
#set_property PACKAGE_PIN M6  [get_ports pb77];  # p

# IO Bank 14 default 3.3V.
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 14]];

# IO Bank 34 default 3.3V.
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];

# IO Bank 35 default 3.3V. You may change this when unloading JP1 and powering VCCO35 by VIOA pin of PA
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];



connect_debug_port dbg_hub/clk [get_nets clk_1]




create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list nolabel_line277/microblaze_i/hier_mem/mig_7series_0/u_microblaze_mig_7series_0_0_mig/u_ddr3_infrastructure/ui_addn_clk_2]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {DAC8811Data[0]} {DAC8811Data[1]} {DAC8811Data[2]} {DAC8811Data[3]} {DAC8811Data[4]} {DAC8811Data[5]} {DAC8811Data[6]} {DAC8811Data[7]} {DAC8811Data[8]} {DAC8811Data[9]} {DAC8811Data[10]} {DAC8811Data[11]} {DAC8811Data[12]} {DAC8811Data[13]} {DAC8811Data[14]} {DAC8811Data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list da_axis_enDly]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list da_axis_tlast]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets ui_addn_clk_66d7M]
