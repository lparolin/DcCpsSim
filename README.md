# DcCpsSim
This is part of the code developed during my Ph.D. at Carnegie Mellon University. 
The code is not actively maintained since 2012. Optimization toolboxes such as Tomlab may be needed in order to execute the code.

-- Layout generation: 
   To generate a new data center layout:
   1. Define a new layout_id in gen_dc_layout.m ;
   2. Edit generate_air_flow.m . Change the values of layout_num and 
      num_rack_per_zone so that airflow and temperature exchange matrices will
      be generated for the new layout. 

## License
See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).