################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 10/15/2024 10:05:40
#
################################################################################
if { ![is_common_ui_mode] } { error "ERROR: This script requires common_ui to be active."}

read_netlist ../output/design/ibex_top.v

init_design -skip_sdc_read
