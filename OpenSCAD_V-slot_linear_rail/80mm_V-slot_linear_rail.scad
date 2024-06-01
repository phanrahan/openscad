//set length of V-slot linear rail
linear_rail_length = 500;


linear_extrude(height = linear_rail_length, center = 0, convexity = 10)
                import(file = "V-slot 2080_fullscale.dxf");