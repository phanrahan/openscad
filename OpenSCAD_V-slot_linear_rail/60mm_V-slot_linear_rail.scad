//set length of V-slot linear rail
linear_rail_length = 200;


linear_extrude(height = linear_rail_length, center = 0, convexity = 10)
                import(file = "V-slot 2060_fullscale.dxf");