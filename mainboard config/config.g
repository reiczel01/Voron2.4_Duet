; Configuration file for RepRapFirmware on Duet 3 Main Board 6HC

; General
G90 ; absolute coordinates
M83 ; relative extruder moves
M550 P"Voron2" ; set hostname

; Network


; Wait a moment for the CAN expansion boards to become available
G4 S2

; Accelerometers
M955 P121.0 I16 ; configure accelerometer on board #121

; Smart Drivers
M569 P0.0 S1 D2 V2000 ; driver 0.0 (Z motor )
M569 P0.1 S1 D2 V2000 ; driver 0.1 (Z motor 2)
M569 P0.2 S0 D2 V2000 ; driver 0.2 (Z motor 3)
M569 P0.3 S0 D2 V2000 ; driver 0.3 (Y axis)
M569 P0.4 S0 D2 V2000 ; driver 0.4 (X axis)
M569 P0.5 S1 D2 V2000 ; driver 0.5 (Z motor 4)
M569 P121.0 S0 D2 ; driver 121.0 (extruder 0)

; Motor Idle Current Reduction
M906 I30 ; set motor current idle factor
M84 S30 ; set motor current idle timeout

; Axes
M584 X0.4 Y0.3 Z0.1:0.5:0.0:0.2 E121.0 ; set drive mapping for four Z motors
M350 X16 Y16 Z16 I1 ; configure microstepping with interpolation
M906 X1500 Y1500 Z800 ; set axis driver currents
M92 X160 Y160 Z400 ; configure steps per mm
M208 X0:348 Y0:358 Z0:318.64 ; set minimum and maximum axis limits
M566 X450 Y450 Z350 ; set maximum instantaneous speed changes (mm/min)
M204 P3500 T5500 Z3400 ; set maximum speeds (mm/min) M203 X18000 Y18000 Z3400
M201 X6500 Y6500 Z450 ; set accelerations (mm/s^2) M201 X8000 Y8000 Z450
M204 P3500 T5500 ; Set printing acceleration and travel accelerations M204 P4000 T6000

; Custom shaper — lepsze tłumienie wielu rezonansów
  M593 P"mzv" F41 S0.10

; Extruders
M584 E121.0 ; set extruder mapping
M350 E16 I1 ; configure microstepping with interpolation
M906 E800 ; set extruder driver currents
M92 E408.16327 ; configure steps per mm
M566 E120 ; set maximum instantaneous speed changes (mm/min)
M203 E3600 ; set maximum speeds (mm/min)
M201 E250 ; set accelerations (mm/s^2)
M572 D0 S0.055 ; presure advance (poprzednia wrtosc 0.037)


; Kinematics
M669 K1 ; configure CoreXY kinematics

; Probes
M558 K0 P8 C"!^121.io2.in" H5 F600 T12000 ; configure digital probe with filtering
G31 P500 X0 Y0 Z-0.858 ; set Z probe trigger value, offset and trigger height
M671 X330:330:-10:-10 Y325:-25:-25:330 S20				; Define Z belts locations (Front_Left, Back_Left, Back_Right, Front_Right)
														; Position of the bed leadscrews.. 4 Coordinates
														; Snn Maximum correction to apply to each leadscrew in mm (optional, default 1.0)
                                            			; S20 - 20 mm spacing
M557 X20:324 Y31.8:338 P5       

; Endstops
M574 X1 S1 P"!121.io1.in" ; configure X axis endstop
M574 Y1 S1 P"!io0.in" ; configure Y axis endstop
M574 Z1 S2 ; configure Z axis endstop for probe

; Mesh Bed Compensation
M557 X25:325 Y25:325 S40 P5:5 ; define grid for mesh bed compensation

; Sensors
M308 S0 P"temp0" Y"thermistor" A"Heated Bed" T100000 B4725 C7.06e-8 ; configure sensor #0
M308 S1 P"121.temp0" Y"pt1000" A"Nozzle" ; configure sensor #1
M308 S2 P"temp1" Y"pt1000" A"Enclosure" ; configure sensor #2

; Heaters
M950 H0 C"out0" T0 ; create heater #0
M143 H0 P0 T0 C0 S120 A0 ; configure heater monitor #0 for heater #0
M307 H0 R0.662 K0.349:0.000 D3.53 E1.35 S1.00 B0
M950 H1 C"121.out0" T1 ; create heater #1
M143 H1 P0 T1 C0 S300 A0 ; configure heater monitor #0 for heater #1
M307 H1 R2.249 K0.509:0.043 D6.99 E1.35 S1.00 B0 V23.8

; Heated beds
M140 P0 H0 ; configure heated bed #0

; Fans
M950 F0 C"121.out2" Q500 ; create fan #0 (part cooling fan) with a PWM frequency of 500Hz
M106 P0 S0 H-1 ; set fan #0 to be controlled manually

M950 F1 C"121.out1" Q500 ; create fan #1 (hotend fan) with a PWM frequency of 500Hz
M106 P1 S1 H1 T45 ; set fan #1 to turn on when the hotend temperature exceeds 45C

M950 F2 C"out3" Q500 ; create fan #2 (board cooling fan) with a PWM frequency of 500Hz
M106 P2 S0 H0 T50 ; set fan #2 to be controlled manually

M950 F3 C"out2" Q500 ; create fan #2 (board cooling fan) with a PWM frequency of 500Hz
M106 P3 S0 H0 T50 ; set fan #2 to be controlled manually


; Tools
M563 P0 D0 H1 F0 ; create tool #0
M568 P0 R0 S0 ; set initial tool #0 active and standby temperatures to 0C

; Konfiguracja paska Neopixel na porcie IO3
M950 E0 C"io3.out" T1 Q3000000   ; create a RGB Neopixel LED strip on the LED port and set SPI frequency to 3MHz

M150 E0 R255 P128 S20 F1     ; set first 20 LEDs to red, half brightness, more commands for the strip follow
M150 E0 U255 B255 P255 S20



