# File: keyboardTo7SD/scripts/create_project.tcl

create_project keyboardTo7SD ../vivado -part xc7a35tcpg236-1 -force

# Add HDL files
add_files ../sources/PS2_data_capture.v  ;# or your actual module name
add_files ../sources/spot.v
# Add constraints
add_files -fileset constrs_1 ../constrs/debounce_basys_constraints.xdc

# Set top module
set_property top PS2_data_capture [current_fileset]

update_compile_order -fileset sources_1
