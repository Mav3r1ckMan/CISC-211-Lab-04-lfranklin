/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Levi Franklin"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align


    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
   /* Set output variables to 0 */
   
   ldr r1, =we_have_a_problem	    /* loads we_have_a_problem into register 1 */
   mov r2, 0	    /* sets register 2 to zero */
   str r2, [r1]		/* stores the value in register 2 into the memory address we_have_a_problem */
   
   ldr r1, =eat_out	    /* loads eat_out into register 1 */
   mov r2, 0	    /* sets register 2 to zero */
   str r2, [r1]		/* stores the value in register 2 into the memory address eat_out */
   
   ldr r1, =stay_in	    /* loads stay_in into register 1 */
   mov r2, 0	    /* sets register 2 to zero */
   str r2, [r1]		/* stores the value in register 2 into the memory address stay_in */
   
   ldr r1, =eat_ice_cream	/* loads eat_ice_cream into register 1 */
   mov r2, 0	    /* sets register 2 to zero */
   str r2, [r1]		/* stores the value in register 2 into the memory address eat_ice_cream */
   
   ldr r1, =transaction		/* loads transaction into register 1 */
   mov r2, 0	    /* sets register 2 to zero */
   str r2, [r1]		/* stores the value in register 2 into the memory address transaction */
   
   /* Copy r0 to transaction */
   
   ldr r1, =transaction		/* loads transaction into register 1 */
   str r0, [r1]		/* copies register 0 to the memory address transaction */
   
   /* compare transaction to 1000 and -1000 */
   
   ldr r6, =0x03E8	/* loads 1000 into register 6 */
   cmp r0, r6	    /* compares transaction to 1000 */
   bgt problem	    /* branches to problem if greater than 1000 */
   
   ldr r6, =0xFFFFFC18	/* loads -1000 into register 6 (32-bit two's complement) */
   cmp r0, r6	    /* compares transaction to -1000 */
   blt problem	    /* branches to problem if less than -1000 */
   
   ldr r2, =balance	/* loads balance into register 2 */
   ldr r3, [r2]		/* loads memory address balance in register 2 into register 3 */
   mov r5, 0		/* sets register 5 to zero */
   adds r5, r3, r0	/* does transaction (r0) + balance (r3) and stores it in register 5 while setting the flags */
   bvs problem	    /* branches to problem if overflow flag is set */
   
   /* balance = tmpBalance */
   
   mov r0, r5		/* moves balance in register 5 into register 0 */
   str r0, [r2]		/* stores balance in register 0 into memory address (=balance) in register 2 */
   
   cmp r0, 0                  /* compare balance to 0 */
   bgt set_eat_out            /* branch to set_eat_out if balance > 0 */
   blt set_stay_in            /* branch to set_stay_in if balance < 0 */
   b set_eat_ice_cream        /* branch to set eat_ice_cream if == 0  */

    set_eat_out:
     ldr r4, =eat_out       /* loads address eat_out into register 4 */
     mov r6, 1              /* sets r6 to 1 */
     str r6, [r4]           /* stores 1 into memory adress eat_out in register 4 */
     b done

    set_stay_in:
    ldr r4, =stay_in       /* loads address stay_in into register 4 */
    mov r6, 1              /* sets r6 to 1 */
    str r6, [r4]           /* stores 1 into memory adress stay_in in register 4 */
    b done

    set_eat_ice_cream:
    ldr r4, =eat_ice_cream /* loads address eat_ice_cream into register 4 */
    mov r6, 1              /* sets r6 to 1 */
    str r6, [r4]           /* stores 1 into memory adress eat_ice_cream in register 4 */

    b done
   
   /* transaction out of bounds or overflow */
   
    problem:
    ldr r1, =transaction	/* loads transaction in register 1 */
    mov r6, 0	    /* sets register 6 to 0 */
    str r6, [r1]	/* stores value in register 6 into transaction in register 4 */
    
    ldr r4, =we_have_a_problem	    /* loads we_have_a_problem into register 4 */
    mov r6, 1	    /* sets register 6 to 1 */
    str r6, [r4]	/* stores value in register 6 into we_have_a_problem in register 4 */
    
    ldr r2, =balance	    /* loads balance into register 2 */
    ldr r0, [r2]	/* loads original balance from memory into r0 */
    
    b done	/* branches to done */
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




