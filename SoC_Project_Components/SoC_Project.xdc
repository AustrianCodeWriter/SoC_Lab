
                    #####################################################
                    #       File:           SoC_Project.xdc             #
                    #       Contains:       Hardware constraints        #
                    #       System:         ZedBoard (Rev D.2)          #
                    #       FPGA:           XC7Z020-CLG484-1            #
                    #       CPU-Frequency:  100MHz                      #
                    #       IDE:            Xilinx Vivado 2022.2.0      #
                    #       Date:           2023.02.25.                 #
                    #####################################################



# ----------------------------------------------------------------------------
# Clock Source - Bank 13
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y9 [get_ports {clk_i}];    # "GCLK"

#   Specify clock with "10ns" (100MHz) and duty cycle of "5ns" (50%)
create_clock -add -name sys_clk_pin -period 10.000 -waveform {0.000 5.000} [get_ports {clk_i}];

# ----------------------------------------------------------------------------
# User LEDs - Bank 33
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN T22 [get_ports {LED[0]}];  # "LD0"
# set_property PACKAGE_PIN T21 [get_ports {LED[1]}];  # "LD1"
# set_property PACKAGE_PIN U22 [get_ports {LED[2]}];  # "LD2"
# set_property PACKAGE_PIN U21 [get_ports {LED[3]}];  # "LD3"
# set_property PACKAGE_PIN V22 [get_ports {LED[4]}];  # "LD4"
# set_property PACKAGE_PIN W22 [get_ports {LED[5]}];  # "LD5"
# set_property PACKAGE_PIN U19 [get_ports {LED[6]}];  # "LD6"
# set_property PACKAGE_PIN U14 [get_ports {LED[7]}];  # "LD7"

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN P16 [get_ports {BTNC}];    # "BTNC"
# set_property PACKAGE_PIN R16 [get_ports {BTND}];    # "BTND"
# set_property PACKAGE_PIN N15 [get_ports {BTNL}];    # "BTNL"
# set_property PACKAGE_PIN R18 [get_ports {BTNR}];    # "BTNR"
# set_property PACKAGE_PIN T18 [get_ports {BTNU}];    # "BTNU"

# ----------------------------------------------------------------------------
# Miscellaneous - Bank 34
# ----------------------------------------------------------------------------
# set_property PACKAGE_PIN K16 [get_ports {PUDC_B}];  # "PUDC_B"

# ----------------------------------------------------------------------------
# User DIP Switches - Bank 35
# ----------------------------------------------------------------------------
# set_property PACKAGE_PIN F22 [get_ports {SW0}];     # "SW0"
# set_property PACKAGE_PIN G22 [get_ports {SW1}];     # "SW1"
# set_property PACKAGE_PIN H22 [get_ports {SW2}];     # "SW2"
# set_property PACKAGE_PIN F21 [get_ports {SW3}];     # "SW3"
# set_property PACKAGE_PIN H19 [get_ports {SW4}];     # "SW4"
# set_property PACKAGE_PIN H18 [get_ports {SW5}];     # "SW5"
# set_property PACKAGE_PIN H17 [get_ports {SW6}];     # "SW6"
# set_property PACKAGE_PIN M15 [get_ports {SW7}];     # "SW7"

# ----------------------------------------------------------------------------
# IOSTANDARD Constraints
# ----------------------------------------------------------------------------
# Note that the bank voltage for IO Bank 33 is fixed to 3.3V on ZedBoard.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];

# Set the bank voltage for IO Bank 34 to 1.8V by default.
# set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];

# Set the bank voltage for IO Bank 35 to 1.8V by default.
# set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 35]];
# set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];

# Note that the bank voltage for IO Bank 13 is fixed to 3.3V on ZedBoard.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
