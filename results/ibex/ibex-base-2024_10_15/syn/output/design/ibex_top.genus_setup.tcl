################################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 21.16-s062_1
#   on 10/15/2024 10:05:41
#
# This file can only be run in Genus Common UI mode.
#
################################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 21.16-s062_1


# Remove Existing Design
################################################################################
if {[::legacy::find -design design:ibex_top] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:ibex_top
}


# To allow user-readonly attributes
################################################################################
::legacy::set_attribute -quiet force_tui_is_remote 1 /


# Libraries
################################################################################
::legacy::set_attribute library {/courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_AO_LVT_SS_nldm_211120.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_AO_RVT_SS_nldm_211120.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_AO_SLVT_SS_nldm_211120.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_INVBUF_LVT_SS_nldm_220122.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_INVBUF_RVT_SS_nldm_220122.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_INVBUF_SLVT_SS_nldm_220122.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_OA_LVT_SS_nldm_211120.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_OA_RVT_SS_nldm_211120.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_OA_SLVT_SS_nldm_211120.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SEQ_LVT_SS_nldm_220123.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SEQ_RVT_SS_nldm_220123.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SEQ_SLVT_SS_nldm_220123.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SIMPLE_LVT_SS_nldm_211120.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SIMPLE_RVT_SS_nldm_211120.lib.gz /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SIMPLE_SLVT_SS_nldm_211120.lib.gz} /


# Design
################################################################################
read_netlist -top ibex_top ../output/design/ibex_top.v
read_metric -id current ../output/design/ibex_top.metrics.json

phys::read_script ../output/design/ibex_top.g
puts "\n** Restoration Completed **\n"


# Data Integrity Check
################################################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "21.16-s062_1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: 21.16-s062_1  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack design:ibex_top]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "0.2"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: 0.2,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
if {"[string_representation [::legacy::get_attribute slack_by_mode design:ibex_top]]" != "{{mode:ibex_top/default_mode 0.2}}"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack_by_mode: {{mode:ibex_top/default_mode 0.2}}  current slack_by_mode: [string_representation [::legacy::get_attribute slack_by_mode design:ibex_top]]"
}
# tns
set _tns_ [::legacy::get_attribute tns design:ibex_top]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 0,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:ibex_top]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "734"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 734,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:ibex_top]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 0,  current net area: $_net_area_"
}
unset _net_area_
