Hydrogen-Fuelling-Station
=========================

Library for creating models of Hydrogen fuelling stations in Dymola, part of Erasmus Rothuizen's PhD. 

Installation:
Make sure dymola is installed and working correctly (Hence, modelica and visual studio/express 2010 should be installed).

Download hydrogen fuelling package.
Extract files in Dymola folder in Docments. Keep library structure within the "Hydrogen-Fuelling-Station" folder. 

Installation of CoolProp.
Copy "CoolPropLib.lib" from CoolPropFiles folder into installation folder of dymola "Dymola/bin/lib".
Copy "CoolPropLib.h" from CoolPropFiles folder into installation folder of dymola "Dymola/source".
Please note that the standard version of CoolProp2Modelica does not work with this package, yet. 

Open Dymola, load "HydrogenRefuelingCoolProp", change directory to the base path of "Hydrogen-Fuelling-Station" and Enjoy :)
