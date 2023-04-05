# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: Labor_SoC-Design\SoC_Project\Vitis_workspace\zynq_hw_system\_ide\scripts\systemdebugger_zynq_hw_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source Labor_SoC-Design\SoC_Project\Vitis_workspace\zynq_hw_system\_ide\scripts\systemdebugger_zynq_hw_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zed 210248A49C90" && level==0 && jtag_device_ctx=="jsn-Zed-210248A49C90-23727093-0"}
fpga -file Labor_SoC-Design/SoC_Project/Vitis_workspace/zynq_hw/_ide/bitstream/hardware_platform.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw Labor_SoC-Design/SoC_Project/Vitis_workspace/hardware_platform/export/hardware_platform/hw/hardware_platform.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source Labor_SoC-Design/SoC_Project/Vitis_workspace/zynq_hw/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow Labor_SoC-Design/SoC_Project/Vitis_workspace/zynq_hw/Debug/zynq_hw.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
