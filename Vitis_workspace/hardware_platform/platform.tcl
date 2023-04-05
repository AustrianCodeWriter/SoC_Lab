# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct Labor_SoC-Design\SoC_Project\Vitis_workspace\hardware_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source Labor_SoC-Design\SoC_Project\Vitis_workspace\hardware_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {hardware_platform}\
-hw {Labor_SoC-Design\SoC_Project\hardware_platform.xsa}\
-out {Labor_SoC-Design/SoC_Project/Vitis_workspace}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {hardware_platform}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform active {hardware_platform}
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform clean
platform active {hardware_platform}
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform generate
platform clean
platform active {hardware_platform}
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
platform generate
platform clean
platform active {hardware_platform}
platform config -updatehw {Labor_SoC-Design/SoC_Project/hardware_platform.xsa}
platform generate
platform clean
