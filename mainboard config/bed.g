M290 R0 S0    ; clear baby stepping
M561          ; reset all bed adjustments
M400          ; flush move queue

; Sprawdź, czy osie są whomowane
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  echo "not all axes homed, homing axes first"
  G28

; Pomiar punktów przy śrubach napędowych
; Szybki ruch do pierwszego punktu
G1 X20 Y21.8 Z10 F24000 ; Przesuń do pierwszego punktu z wyższą prędkością

; Przemieszczenie między punktami
G1 X10 Y21.8 F24000 ; Przesuń do pozycji pierwszej śruby napędowej
G30 P0 X10 Y21.8 Z-99999 ; Pomiar przy pierwszej śrubie napędowej

G1 X10 Y348 F24000 ; Przesuń szybko do drugiego punktu
G30 P1 X10 Y348 Z-99999 ; Pomiar przy drugiej śrubie napędowej

G1 X334 Y348 F24000 ; Przesuń szybko do trzeciego punktu
G30 P2 X334 Y348 Z-99999 ; Pomiar przy trzeciej śrubie napędowej

G1 X334 Y21.8 F24000 ; Przesuń szybko do czwartego punktu
G30 P3 X334 Y21.8 Z-99999 S4 ; Pomiar przy czwartej śrubie napędowej i kalibracja


; Wyświetl bieżące odchylenie
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

; Zwiększ prędkość sondowania
M558 K0 H5 F100

; Pętla kalibracji do uzyskania pożądanej dokładności
while move.calibration.initial.deviation > 0.003
  if iterations >= 7
    echo "Error: Max attempts failed. Deviation: " ^ move.calibration.initial.deviation
    break
  echo "Deviation over threshold. Executing pass" , iterations+2, "deviation", move.calibration.initial.deviation
  G30 P0 X10 Y21.8 Z-99999
  G30 P1 X10 Y348 Z-99999
  G30 P2 X334 Y348 Z-99999
  G30 P3 X334 Y21.8 Z-99999 S4
  echo "Current deviation: " ^ move.calibration.initial.deviation
  continue

echo "Final deviation: " ^ move.calibration.initial.deviation
G1 X175 Y175 Z10 F18000

; Przywróć prędkość sondowania
M558 K0 F600:100

; Wykonaj homing osi Z
G28 Z
