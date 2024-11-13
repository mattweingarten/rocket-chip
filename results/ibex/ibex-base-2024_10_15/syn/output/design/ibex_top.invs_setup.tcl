################################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution 21.16-s062_1
#   on 10/15/2024 10:05:40
#
################################################################################
#
# Genus(TM) Synthesis Solution setup file
# This file can only be run in Innovus Common UI mode.
#
################################################################################


# Version Check
###########################################################

      namespace eval ::genus_innovus_version_check { 
        set minimum_version 21
        set maximum_version 22
        regexp {\d\d} [get_db program_version] this_version
        puts "Checking Innovus major version against Genus expectations ..."
        if { $this_version < $minimum_version || $this_version > $maximum_version } {
          error "**ERROR: this operation requires Innovus major version to be between '$minimum_version' and '$maximum_version'."
        }
      }
    
set _t0 [clock seconds]
puts [format  {%%%s Begin Genus to Innovus Setup (%s)} \# [clock format $_t0 -format {%m/%d %H:%M:%S}]]
set_db read_physical_allow_multiple_port_pin_without_must_join true
set_db must_join_all_ports true
set_db timing_cap_unit 1ff
set_db timing_time_unit 1ps


# Design Import
################################################################################
source -quiet /tools/cadence/GENUS/21.16/tools.lnx86/lib/cdn/rc/edi/innovus_procs_common_ui.tcl
## Reading FlowKit settings file
source ../output/design/ibex_top.flowkit_settings.tcl

source ../output/design/ibex_top.invs_init.tcl

# Reading metrics file
################################################################################
read_metric -id current ../output/design/ibex_top.metrics.json

## Reading common preserve file for dont_touch and dont_use preserve settings
source -quiet ../output/design/ibex_top.preserve.tcl

## Reading Innovus Mode attributes file
pqos_eval {rcp::read_taf ../output/design/ibex_top.mode_attributes.taf.gz}


# Mode Setup
################################################################################
source ../output/design/ibex_top.mode


# MSV Setup
################################################################################

# Reading write_name_mapping file
################################################################################

      if { [is_attribute -obj_type port original_name] &&
           [is_attribute -obj_type pin original_name] &&
           [is_attribute -obj_type pin is_phase_inverted]} {
        source ../output/design/ibex_top.wnm_attrs.tcl
      }
    

# Reading NDR file
source ../output/design/ibex_top.ndr.tcl

# Reading Instance Attributes file
pqos_eval { rcp::read_taf ../output/design/ibex_top.inst_attributes.taf.gz}

# Reading minimum routing layer data file
################################################################################
pqos_eval {rcp::load_min_layer_file ../output/design/ibex_top.min_layer {} {}}
eval_legacy {set edi_pe::pegConsiderMacroLayersUnblocked 1}
eval_legacy {set edi_pe::pegPreRouteWireWidthBasedDensityCalModel 1}

      set _t1 [clock seconds]
      puts [format  {%%%s End Genus to Innovus Setup (%s, real=%s)} \# [clock format $_t1 -format {%m/%d %H:%M:%S}] [clock format [expr {28800 + $_t1 - $_t0}] -format {%H:%M:%S}]]
    
