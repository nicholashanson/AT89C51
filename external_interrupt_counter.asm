;GENERAL DESCRIPTION:
;when an external interrupt signal comes in on pin 2 of port 3
;the contents of general purpose register R7 are incremented and
;then sent to port 1

;CONFIGURATION AND INITIALIZATION:
;before an interrupt can be recieved, we first need to enable gloabal interrupts
;and then enable external interrupt 0, both these flags are in the IE register
;we also set a flag in the TCON register so that an interrupt event occurs on the 
;falling edge of the interrupt signal
;before counting interrupts signals we initiate the contents of R7 to 0

;MAIN LOOP:
;in the main loop we call the display function so that the contents of 
;R7 are moved to port 1 after an interrupt occurs

;CODE:
      ORG 0000H               ;reset vector                    
      AJMP MAIN
      ORG 0003H               ;interrupt vector for external interrupt 0 (P3.2)
      AJMP IP0                ;interrupt handler
MAIN:
      ;set LSB of TCON register
      SETB IT0                ;TCON bit0, interrupt tiggered by falling edge
      ;set MSB of IE register
      SETB EA                 ;IE (interrpt enable reigister bit7), enable global interrupt flag
      ;set LSB of IE register
      SETB EX0                ;IE bit0, enable external interrupt 0
      ;initiate the contents of R7 to 0
      MOV R7, #00H            
LP:
      ACALL DISP
      AJMP LP
IP0:
      ;add a one to the contents of general purpose register R7
      INC R7
      ;return from interrupt sub-routine
      RETI
DISP:
      ;move the contents of register R7 to port 1
      MOV P1, R7
      ;return back to the main loop
      RET
      END
