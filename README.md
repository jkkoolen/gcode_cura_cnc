# gcode_cura_cnc
some script to convert a 3d gcode from cura to a cnc gcode which can be used for my cnc machine

when i have a stl file which doesn't fit in cura i scale it e.g. to 10%. When this gcode is generated i use filter_gcode to convert it to 
cnc specific gcode.
After this i use the scale_gcode to scale it 10 times.
