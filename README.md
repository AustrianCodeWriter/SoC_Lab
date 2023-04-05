# SoC-lab
FPGA design of the built-in self-test (BIST) for the SoC-lab


## 🗂️ Structure
This section gives an overview about the folders inside this repository:
- 📁 `SoC_Project.cache`: Cached IPs and syntheses
- 📁 `SoC_Project.gen`: Synthesized IPs
- 📁 `SoC_Project.hw`
- 📁 `SoC_Project.ip_user_files`
- 📁 `SoC_Project.runs`: Synthesis runs
- 📁 `SoC_Project.srcs`: IP sources
- 📁 `SoC_Project_Components`: VHDL design files
  - 📄 `bist.vhd`: BIST (built-in self test) design file
  - 📄 `controller.vhd`: BIST-controller design file
  - 📄 `design_top.vhd`: Top design file for Zynq
  - 📄 `lfsr.vhd`: LFSR (Linear Feedback Shift Register) design file
  - 📄 `misr.vhd`: MISR (Multiple-Input Signature Register) design file
  - 📄 `SoC_Project.xdc`: Hardware constraints file
- 📁 `SoC_Project_Testbenches`: VHDL test benches
  - 📄 `bist_tb.vhd`: Test bench of BIST
  - 📄 `bist_testbench.wcfg`: Waveform configuration file of BIST
  - 📄 `lfsr_tb.vhd`: Test bench of LFSR
  - 📄 `lfsr_testbench.wcfg`: Waveform configuration file of LFSR
- 📁 `Tcl`: Tcl-scripts to run a specific simulation
  - 📄 `README.txt`: How to run the simulation using Tcl
  - 📄 `run_bist_sim.tcl`: Simulation of BIST
  - 📄 `run_lfsr_sim.tcl`: Simulation of LFSR
- 📁 `Vitis_workspace`: Workspace of Vitis (Microprocessor IDE)
- 📄 `.gitignore`: Contains ignored files and folders
- 📄 `hardware_platform.xsa`: Hardware platform file
- 📄 `README.md`: This ReadMe file
- 📄 `SoC_Project.xpr`: Vivado Project file
