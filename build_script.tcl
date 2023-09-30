# lecture des fichiers sources VHDL
catch {remove_files [get_files]}
read_vhdl -vhdl2008 ../src/top.vhd
#read_vhdl -vhdl2008 ../src/clk_wiz_0.vhd
#read_vhdl -vhdl2008 ../src/clk_wiz_0_clk_wiz.vhd

# lecture du fichier de contraintes xdc; choisir la ligne qui correspond à votre carte
read_xdc ../xdc/basys_3_top.xdc

# synthèse - choisir la ligne qui correspond à votre carte
synth_design -top based_graphic_card -part xc7a35tcpg236-1 -assert

# implémentation (placement et routage)
place_design
route_design

# génération du fichier de configuration
write_bitstream -force based_graphic_card.bit

# programmation du FPGA
open_hw_manager
catch {connect_hw_server}
get_hw_targets
open_hw_target

# choisir les trois lignes qui correspondent à votre carte
current_hw_device [get_hw_devices xc7a35t_0]
set_property PROGRAM.FILE {based_graphic_card.bit} [get_hw_devices xc7a35t_0]
program_hw_devices [get_hw_devices xc7a35t_0]
