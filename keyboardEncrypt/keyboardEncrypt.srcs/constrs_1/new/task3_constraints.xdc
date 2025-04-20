## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## USB HID (PS/2)
set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports ps2_clk]
set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports ps2_data]
# set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports reset]
#  set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports send]


##7 Segment Display
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {ssdAnode[6]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {ssdAnode[5]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {ssdAnode[4]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {ssdAnode[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {ssdAnode[2]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {ssdAnode[1]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {ssdAnode[0]}]

set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {ssdCathode[3]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {ssdCathode[2]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {ssdCathode[1]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {ssdCathode[0]}]


# State Indicator LEDs (3 LEDs)
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {stateled[2]}]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports {stateled[1]}]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports {stateled[0]}]

# Data Display LEDs (8 LEDs)
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports {data_led}]
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports {data_led[1]}]
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports {data_led[2]}]
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports {data_led[3]}]
#set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports {data_led[4]}]

# Word Index Indicator LEDs (3 LEDs)

set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports {wordindexLed[7]}]
set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports {wordindexLed[6]}]
set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports {wordindexLed[5]}]
set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports {wordindexLed[4]}]
set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports {wordindexLed[3]}]


set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports {wordindexLed[2]}]
set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports {wordindexLed[1]}]
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports {wordindexLed[0]}]


# set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports {busy}]
 
 
 set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports reset]
 set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports task_button]
 set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports send]
 set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports btnL]
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports btnR]
 
 set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports {typeEnable}]
   set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports {displayEnable}]
  set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {displaySwitch}]
  set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {autoSwitch}]



 set_property -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports {tx}];#Sch name = JB4
 set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports {rx}];#Sch name = JC4




## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]