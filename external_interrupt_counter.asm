$NOMOD51
$INCLUDE (8051.MCU)

      ORG 0000H               ;reset vector                    
      AJMP MAIN
      ORG 0003H               ;interrupt vector for external interrupt 0 (P3.2)
      AJMP IP0                ;interrupt handler
MAIN:
      SETB IT0                ;TCON bit0, interrupt tiggered by falling edge
      SETB EA                 ;IE (interrpt enable reigister bit7), enable global interrupt flag
      SETB EX0                ;IE bit0, enable external interrupt 0
      MOV R7, #00H            
LP:
      ACALL DISP
      AJMP LP
IP0:
      INC R7
      RETI
DISP:
      MOV P1, R7
      RET
      END
