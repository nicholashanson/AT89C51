      org 0000h
main:
      mov R0, #0Ah                ;decimal 10
      mov R1, #32h                ;decimal 50
;outer loop
loop:
      mov R0, #0Ah                ;decimal 10
;inner loop
loop1:
      mov TH0, #0E0h
      mov TL0, #18h
      ;IE:B7 - EA - enable all interrupts
      ;IE:B6 - don't care
      ;IE:B5 - don't care
      ;IE:B4 - ES - enable serial port interrupt
      ;IE:B3 - ET1 - enable timer-1 interrupt
      ;IE:B2 - EX1 - enable external interrupt-1
      ;IE:B1 - ET0 - enable timer-0 interrupt
      ;IE:B0 - EX0 - enable external interrupt-0
      mov IE, #10000010B          ;enable CPU interrupts and interrupt for timer0
      setb TR0                    ;start timer0
      jnb TF0, $                  ;wait for timer0 to finish
      clr TF0                     ;timer 0 finished, so clear the flag that says it has finished
      ;decrement register R0 and check to see if the result is equal to zero
      ;if not, return to the start of loop1
      djnz R0, loop1
      ;decrement register R1 and check to see if the result is equal to zero
      ;if not, return to the start of loop
      ;the combination of the and the above djnz statement creates a loop of
      ;R0 x R1 = dec10 x dec50 = dec500 iterations
      djnz R1, loop              
      setb P1.0                  ;toggle the LSB of P1 to create a pulse   
      clr P1.0
      mov R0, #0Ah
      mov R1, #32h
      ;return to main to start loop from beginning
      sjmp main
      end
