FLAGS = --std=08
SRCS  = "sim.vhd top.vhd"

all:
	mkdir -p build
	cd build && /opt/vivado/Vivado/2023.1/bin/vivado -mode tcl -source ../build_script.tcl

test:
	ghdl -a $(FLAGS) src/top.vhd
	ghdl -a $(FLAGS) src/sim.vhd
	ghdl -e $(FLAGS) test_top
	ghdl -r $(FLAGS) test_top --wave=wave.ghw --stop-time=20ms
	ghdl --clean $(FLAGS)
	rm work-obj*.cf
	gtkwave wave.ghw