      org 0000h
      ljmp main
      org 000Bh                                 ;timer/counter 0 interrupt vector
      ljmp into_to
      org   0030h
main:	
      mov tmod, #01h                            ;M1 0 M0 0, mode 1, use THX and TLX as 8-bit registers  
      mov th0, #6fh                             ;timer reload value = maximum register count (65 535) - delay value
      mov tl0, #0ffh                            ;delay value = timer delay (20 ms) - timer clock cycle duration (6 / 11.0592 MHz)
      mov r0, #50                               ;reloading the timer 50 times before inverting p1.0 gives us a total delay time of 1s
      setb et0
      setb ea
      setb tr0
      sjmp $
into_to:	
      push acc
      push psw
      mov th0, #3Ch
      mov tl0, #0B0h
      djnz r0, intend
      cpl p1.0
      mov r0, #50
intend:
      pop psw
      pop acc
      reti
      end

