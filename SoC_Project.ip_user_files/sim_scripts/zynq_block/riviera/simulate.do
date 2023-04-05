onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+zynq_block  -L xilinx_vip -L xpm -L xil_defaultlib -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.zynq_block xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {zynq_block.udo}

run 1000ns

endsim

quit -force
