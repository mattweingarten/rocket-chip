#################################################################################
#
# Created by Genus(TM) Synthesis Solution 21.16-s062_1 on Tue Oct 15 10:05:37 EDT 2024
#
#################################################################################

## library_sets
create_library_set -name default_emulate_libset_max \
    -timing { /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_AO_LVT_SS_nldm_211120.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_AO_RVT_SS_nldm_211120.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_AO_SLVT_SS_nldm_211120.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_INVBUF_LVT_SS_nldm_220122.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_INVBUF_RVT_SS_nldm_220122.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_INVBUF_SLVT_SS_nldm_220122.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_OA_LVT_SS_nldm_211120.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_OA_RVT_SS_nldm_211120.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_OA_SLVT_SS_nldm_211120.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SEQ_LVT_SS_nldm_220123.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SEQ_RVT_SS_nldm_220123.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SEQ_SLVT_SS_nldm_220123.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SIMPLE_LVT_SS_nldm_211120.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SIMPLE_RVT_SS_nldm_211120.lib.gz \
              /courses/ee6693/tech/asap7/asap7sc7p5t_28/LIB/NLDM/asap7sc7p5t_SIMPLE_SLVT_SS_nldm_211120.lib.gz }

## opcond
create_opcond -name default_emulate_opcond \
    -process 1.0 \
    -voltage 0.629999 \
    -temperature 100.0

## timing_condition
create_timing_condition -name default_emulate_timing_cond_max \
    -opcond default_emulate_opcond \
    -library_sets { default_emulate_libset_max }

## rc_corner
create_rc_corner -name default_emulate_rc_corner \
    -temperature 100.0 \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name default_emulate_delay_corner \
    -early_timing_condition { default_emulate_timing_cond_max } \
    -late_timing_condition { default_emulate_timing_cond_max } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner

## constraint_mode
create_constraint_mode -name cstr_mode_default_mode \
    -sdc_files { ../output/design/ibex_top.cstr_mode_default_mode.sdc }

## analysis_view
create_analysis_view -name default_mode \
    -constraint_mode cstr_mode_default_mode \
    -delay_corner default_emulate_delay_corner

## set_analysis_view
set_analysis_view -setup { default_mode } \
                  -hold { default_mode }
