# Automatic Garage Door Opener Monitor

Sensor for tracking the state and position of the roller door.

## Tools

All parts modelled in OpenSCAD.

## Principle of operation

The rotary position sensor is inside a cog that meshes with the main gear that drives the roller door. 

Using a pair of optical sensors, a quadature output is generated to allow the sensor to determine the direction the door is moving. Each rotation of the cog provides 24 state changes.

The optical sensor outputs are improved using an Op Amp configured as a comparator. This provides a clean pair of square waves easily decoded with a microcontroller.

## BOM

Electronic components

* ITR20001 reflective optical sensors x2
* LM358 Dual Op Amp
* 560R resistor x2
* 10K resistor x2
* 10K trim pot x2
* 10pF MLC capacitor

Hardware components
* M4 bolt and nut x3
* ~22mm long, 8mm shaft (steel or brass)
* Skate bearing
* Washers to shim cog into position.
