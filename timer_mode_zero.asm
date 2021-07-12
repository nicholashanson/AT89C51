      org 0000h
main:
      mov R0, #0Ah                ;decimal 10
      mov R1, #32h                ;decimal 50
loop:
      mov R0, #0Ah                ;decimal 10
loop1:
      mov TH0, #0E0h
      mov TL0, #18h
      mov IE, #10000010B          ;enable CPU interrupts and interrupt for timer0
      setb TR0
      jnb TF0, $
      clr TF0
      djnz R0, loop1
      djnz R1, loop
      setb P1.0
      clr P1.0
      mov R0, #0Ah
      mov R1, #32h
      sjmp main
      end
