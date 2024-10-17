
# IBEX results

This directory holds results for the Ibex core through simulation, synthesis, and placement.

Each subdirectory is titled with the version of the Ibex core used in the evaluation along with the date. The version "base" represents the basic core with no modifications.

## Viewing ASIC results

Within each results directory, "syn" and "pnr" correspond, respectively, to the results for ASIC synthesis then place and route using a Cadence flow with the ASAP7 PDK. We have attached some filtered results alongside the full db files. To view the DB files, start Cadence genus or innovus and run the command `read_dbs <PATH_TO_SPECIFIC_DB>`.

