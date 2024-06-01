                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


http://www.thingiverse.com/thing:636119
Cut your own gears with profile shift - OpenSCAD library  by Parkinbot is licensed under the Creative Commons - Attribution - Non-Commercial license.
http://creativecommons.org/licenses/by-nc/3.0/

# Summary

*last update 2016-06-18*
- uses new features of OpenSCAD-2015.03 and renders much faster
- help() echos module prototypes
- fixed: helix angle is now height independent
- added torsen differential as programming example

###Background
With this ongoing project I want to present an unusual approach for gear calculation in library form. It is meant for scholars, students and tinkerers, who have started to program with OpenSCAD. Offering many useful, well defaulted parameters, it also addresses most of the needs of professional and semi-professional programmers, who will not only find a large scope of functionality, but also an inspiring self explaining library design. 

Usual code for drawing gears uses the involute function in a constructive way. There are some nice projects in this forum showing that path. It was also my first approach some years ago. But somehow I never really found out how to do proper profile shifting within that approach. And it seems to me, others also didn't. OK, there is not much explicit code published about gears and also math is not everybody’s darling.  

To do the really nasty tricks with gears it is essential to have profile shifting. So my idea was to use a cycling tool and cut gears out from a circle, just the way they are crafted in industry. 
Easy principle, easy and amazingly powerful solution. It's 'subtractiveness' also nicely fits to the declarative paradigm of OpenSCAD. 



# How I Designed This

I think, my little concept video explains the principle better, than I could do it with words.  

<iframe src="//www.youtube.com/embed/SG3iNqUBNhQ" frameborder="0" allowfullscreen></iframe>
The principle

The code uses a description of the tool (a toothed rack) and a blank (a simple circle in this case). And it lets the tool eat up the blank. In OpenSCAD this is expressed with a *difference()* operation that covers each phase of the crafting process. To simulate the movement of the tool OpenSCAD's *translate()* and *rotate()* operators are engaged.

With parameters

- *m* denoting the modulus,
- *z* denoting the number of teeth,
- *x* denoting the profile shift (see below),
- *w* denoting the pressure angle (tooth gradient) of the rack,
- *clearance* denoting a 'free space' factor better distancing.
- *iterations* globally setting the desired angle resolution for the 'crafting',

the central piece code to do this in 2D is quite simple:
```
module gear2D(m = 1, z = 10, x = 0, w = 20, clearance = 0.1)
{
    r_pitch = m*z/2 + x; 
    Dia = m*z*PI; 
    dy = m;  
    r_fkc = r_pitch + dy *(1-clearance/2);  
  s = 360/iterations; 
  difference()
  {
    circle(r_fkc, $fn=300);  // workpiece
    for(i=[0:s:360])
      rotate([0, 0, -i])
      translate([-i/360*Dia, 0, 0])
      Rack(m, z, x, w, clearance);  // Tool
  }
}
```
The modulus *m* of a gear may be viewed as a scale factor. With *m=1*, a gear with *z=10* teeth will have a pitch diameter *d* of 10 mm, and a gear with *z=12* teeth will have a *d* of 12 mm. Doubling the modulus will double the pitch diameter, increasing 'z' will also increase it. The larger the modulus, the more teeth, the larger the gear. It is as simple as this. You can specify any reasonable positive decimal value as modulus. 

## Profile shifting

To cut a gear with profile shift *x* the tool is moved at a radius slightly distanced (by *x*) to the normal pitch radius defined by the modulus *m*. Using appropriate positive and negative shift values you can account for a given axes distance, give more "flesh" to strengthen a gear with a low number of teeth, and even craft gears with different number of teeth while using the same pitch radius and vice versa. 
The following concept video shows how profile shifting works.

<iframe src="//www.youtube.com/embed/RqIEy56xKJY" frameborder="0" allowfullscreen></iframe>

## Gear types

As a matter of mathematics, involute gears with any number of teeth may be combined together, provided they are crafted with the same modulus. The rack being used as tool to craft the gears may also be viewed as an involute gear - the one with infinite diameter. 

By specifying a modulus *m*, a teeth number *z* and a profile shift *x* which is common to all involute gear types 2D gears can be crafted. With a little bit extra information like a height *h* and some angles you can also craft more sophisticated types. 

The library covers spur gears, helix gears, herringbone gears, and bevel gears each type with inner and outer spline. All this is done by use of OpenSCAD's linear_extrude(). Have a look what this means. 


<iframe src="//www.youtube.com/embed/dSa61uRYneA" frameborder="0" allowfullscreen></iframe>

# The library

## What's in the library?

As promised, the library provides modules that craft all the gear types shown in the animation. It uses the naming convention that outer spline gear types are named with *gear*, and inner spline gear types with *Gear*, followed by the specialized gear type. 

The modules use the same core set parameters with the same meaning. 
- For inner spline gears you will want to additionally specify a reasonable outer ring diameter *D*. The code generates one, but better check, if this fits to your needs. 
- For helix and herringbone gears you will want to define the helix angle or an absolute twist angle
- For a bevel gear you will want to specify a bevel angle plus a helix or an absolute twist. 

But you don't have to remember how to use all this. It is enough to remember that the library has a *help()* module, that will prompt you all information about the modules in the library as console output. Spelling, parameters (and their sequence) and default values. This is what you get:

```
iterations=150;
verbose=true;
help();
gear(m=1, z=10, x=0, h=4, w=20, clearance=0.1, center=true);
gear_helix(m=1, z=10, x=0, h=4, w=20, w_helix=45, w_abs=0, clearance=0.1, center=true, 
       verbose=true);
gear_herringbone(m=1, z=10, x=0, h=4, w=20, w_helix=45, w_abs=0, clearance=0.1, 
       center=true);
gear_bevel(m=1, z=10, x=0, h=4, w=20, w_bevel=45, w_helix=45, w_abs=0, clearance=0.1, 
       center=true);
gear_info(m=1, z=10, x=0, h=0, w=20, w_bevel=0, w_helix=0, w_abs=0, clearance=0.1, 
       center=true);

Gear(m=1, z=10, x=0, h=4, w=20, D=0, clearance=-.1, center=true);
Gear_herringbone(m=1, z=10, x=0, h=4, w=20, w_helix=45, w_abs=0, D=0, clearance=-.1, 
       center=true);
Gear_helix(m=1, z=10, x=0, h=4, w=20, w_helix=45, w_abs=0, D=0, clearance=-.1, 
       center=true);
Gear_bevel(m=1, z=10, x=0, h=4, w=20, w_bevel=45, w_helix=0, w_abs=0, D=0, 
       clearance=-0.1, center=true);

gear2D(m=1, z=10, x=0, w=20, clearance=0.1);
Rack(m=1, z=10, x=0, w=20, clearance=0);
```
Additionally each gear that you craft will prompt its characteristic data to console. 
```
ECHO: "modulus = 1"
ECHO: "Z = 10"
ECHO: "profile angle = 20°"
ECHO: "d = 10"
ECHO: "d_outer = 12mm"
ECHO: "d_inner = 8mm"
ECHO: "height = 4mm"
ECHO: "clearance factor = 0.1"
ECHO: "d_outer_cleared = 11.9mm"
ECHO: "d_inner_cleared = 7.9mm"
ECHO: "helix angle = 0°"
ECHO: "bevel angle = 0°"
```
This will provide you the necessary information for sizing and spacing. 

To switch that output off, just set *verbose = false;* in your code. 


## Usage

I've crafted the code into a modularized library for private use, study and further discussion but not for commercial use. This means, the code should stay together in a separate file and must be published with the same or an even stronger license. At best you reference it using a link to this post and let people download it themselves from there. Since I am maintaining the library off and on, they'll always get the latest update. 

To explore the library, just open the file *gears.scad* in OpenSCAD and best start with uncommenting one or another of the many usage examples I provided for demonstration (and testing). Then press F5 to render and see what happens. There are examples for each module. Remember to comment everything again, if you make changes and want to save them. 

Also note that I have appended some STLs containing the gear types grouped into outer splines and inner splines. Try to find and render the corresponding example code with F6 to get an impression of how much time rendering will take. It can take a pretty while and depends on the gear type you are using (helix and herringbone have significantly more points to be calculated), the number of teeth, the height and of course of the value of the global variable *iterations*.

For using the library as production code for your own projects, you copy *gears.scad* into your OpenSCAD library folder (for possible use in all projects) or into your current project folder (for using it only in this specific project). 
To finally include the library into your scad file you write:
```
include <gears.scad>
```
Now you can use all modules defined in the library. Just write 

```
gear(z=6, m=3, x=1); 
```
and F5 presents you a lovely gear with six teeth, some profile shift and the default height of 4 mm. Look into the console window to find all parameters echoed there. 


![Alt text](https://cdn.thingiverse.com/assets/2c/74/48/92/4a/five.png)

## Parameters

As you will expect, you can customize your gears with
 
-  any height
-  any number of teeth *z* (integer > 2)
-  any modulus *m* (real > 0)
-  any profile shift *x, (roughly -2 <= *x* <= ... 2)
-  any clearance (roughly 0<= clearance <=.3)
-  any helical and bevel angles (-90 < w_helix < 90, w_bevel < 90)), independant of height
-  any absolute twist angle (supersedes a given helical angle)

To set own values, use help() and find the parameter list of the module you want to use. This is the interface you can use with that gear type.

To keep the library code as easy as possible, I did not provide any code for adding pivot holes and so on. I think you will be able to add this kind of 'decoration' yourself. 

- Take it as an exercise to design a 'nice' gear having everything a gear should have. 
- Second, craft a double gear as you find them in gear boxes. 
- If that works, continue with a planetary gear. 

Interested in animations? There is some commented code in the library, I used to sample the videos. What about trying an animation of a harmonic drive? 


# Examples

## Herringbone bevel gear

Ever seen a herringbone bevel gear? Use my library to do it in 5 minutes. This is my pair that once made a boring afternoon. 

<iframe src="//www.youtube.com/embed/L-_DujXtRLQ" frameborder="0" allowfullscreen></iframe>

## Gear pump

A current project of mine, which I foster together with some students, is the development of a stepper driven gear pump that can mimic any human aortic flows and heart beats. To drive the fluid I designed a five teeth herringbone gear with some profile shift and softened pressure angle. The twist angle is 72° to get a linear flow on fixed speed. 
See my design animation and a video of the first print of the parts (which admittedly could have been of better quality).


<iframe src="//www.youtube.com/embed/NA3Zcl2nfVA" frameborder="0" allowfullscreen></iframe>

<iframe src="//www.youtube.com/embed/zS7mKvsrQKg" frameborder="0" allowfullscreen></iframe>

## High ratio gear set 1560:1

This is a motorized print of a high ratio gear set using 4 gears only. It is a differential eccentric drive. I designed two inner spline spur gears with 40 and 41 teeth, and two outer spline spur gears with 39, 40 teeth fixed together. 
Of course there is some cheating with profile shift and modulus going on. But see it with your own eyes - it has no secrets.

<iframe src="//www.youtube.com/embed/CJs3H5AS1_Y" frameborder="0" allowfullscreen></iframe>

## Torsen differential

To give you an impression, how you can use the little library for your own purposes, see my quick design of the gearing part of a Torsen differential. You'll find the code in torsen.scad for download. It took me not more than 30 minutes to create it with the library. Just some helix and spur gears quickly sticked together. 

![Alt text](https://cdn.thingiverse.com/assets/19/ad/53/7e/c0/torsen.png)

## Emmet cube

Emmet.scad is some kind of a funny answer to Emmet's famous gear design that can meanwhile be found in Thingiverse in many shapes - cubes, hearts, even heads.
This one is a fake. It will never turn. Do you see why?


![Alt text](https://cdn.thingiverse.com/assets/fc/fe/f7/a1/e5/emmett.png)

## Links to my other gearing projects

Here are some links to other projects, where I used this library or a similar, but more general approach for crafting geary things: 

[Nautilus gears - simple](http://www.thingiverse.com/thing:769012)
[Nautilus gears - herringbone](http://www.thingiverse.com/thing:773764)
[K8200 herringbone extruder gears](http://www.thingiverse.com/thing:922538)
[Elliptic gears](http://www.thingiverse.com/thing:761363)