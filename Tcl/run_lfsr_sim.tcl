set_property top lfsr_testbench [get_filesets Simulation]
set_property top_lib xil_defaultlib [get_filesets Simulation]
set_property is_enabled true [get_files [get_property DIRECTORY [current_project]]/SoC_Project_Testbenches/lfsr_testbench.wcfg]
set_property is_enabled false [get_files [get_property DIRECTORY [current_project]]/SoC_Project_Testbenches/blockmem_testbench.wcfg]
set_property is_enabled false [get_files [get_property DIRECTORY [current_project]]/SoC_Project_Testbenches/bist_testbench.wcfg]
update_compile_order -fileset Simulation
launch_simulation -simset [get_filesets Simulation ]