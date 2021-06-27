$NOMOD51
$INCLUDE (8051.MCU)

      ORG 0000H
      AJMP MAIN
      ORG 0003H
      AJMP IP0
      ORG 0030H
MAIN:
      MOV SP, #60H
      SETB IT0
      SETB EA
      SETB EX0
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
