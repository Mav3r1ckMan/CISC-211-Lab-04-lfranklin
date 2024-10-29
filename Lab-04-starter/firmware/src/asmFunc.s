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
   
   ldr r1, =we_have_a_problem
   mov r2, #0
   str r2, [r1]
   
   ldr r1, =eat_out
   mov r2, #0
   str r2, [r1]
   
   ldr r1, =stay_in
   mov r2, #0
   str r2, [r1]
   
   ldr r1, =eat_ice_cream
   mov r2, #0
   str r2, [r1]
   
   ldr r1, =transaction
   mov r2, #0
   str r2, [r1]
   
   /* Copy r0 to transaction */
   
   ldr r1, =transaction
   str r0, [r1]
   
   /* compare transaction to 1000 and -1000 */
   
   ldr r5, =0x03E8	/* loads 1000 into register 5 */
   cmp r0, r5	    /* compares transaction to 1000 */
   bgt problem	    /* branches to problem if greater than 1000 */
   
   ldr r5, =0xFFFFFC18	/* loads -1000 into register 5 (32-bit two's complement) */
   cmp r0, r5	    /* compares transaction to -1000 */
   blt problem	    /* branches to problem if less than -1000 */
   
   ldr r2, =balance	/* load balance into register 2 */
   ldr r3, [r2]		/* loads memory address balance in register 2 into register 3 */
   adds r5, r3, r0	/* does transaction + balance and stores it in register 5 while setting the flags */
   bvs problem	    /* branches to problem if overflow flag is set */
   
   /* continue normal execution here if no problem or overflow */
   
   /* balance = tmpBalance */
   str r5, [r2]
   
   b done
   
   /* transaction out of bounds or overflow */
   
   problem:
    ldr r3, =we_have_a_problem	    /* loads we_have_a_problem into register 3 */
    mov r4, #1	    /* sets register 4 to 1 */
    str r4, [r3]	/* stores value in register 4 into destination address in register 3 */
    
    ldr r1, =transaction	/* loads transaction in register 1 */
    mov r2, #0	    /* sets register 2 to 0 */
    str r2, [r1]	/* stores value in register 2 into transaction variable */
    
    ldr r2, =balance	    /* loads the address of balance into r2 */
    ldr r0, [r2]	/* loads the current value of balance into r0 (I KNOW ITS REDUNDANT BUT IM SLOW AND NEED TO SEE IT) */
    
    b done	/* branches to done */
    
    /* second part of flow diagram */
    
    ldr r2, =balance
    ldr r0, [r2]
    
    cmp r0, #0	    /* compares balance to 0 */
    bgt set_eat_out	    /* branches to eat_out if balance is greater than 0 */
    
    blt set_stay_in	    /* branches to stay_in if balance is less than 0 */
    
    b set_eat_ice_cream	/* branches to eat_ice_cream if balance neither greater nor less than 0 */
    
    set_eat_out:
    ldr r1, =eat_out	    /* loads address eat_out into register 1 */
    mov r2, #1	    /* sets register 2 to 1 */
    str r2, [r1]	/* stores value in register 2 into eat_out variable  */
    b return_bal
    
    set_stay_in:
    ldr r1, =stay_in	    /* loads address stay_in into register 1 */
    mov r2, #1		/* sets register 2 to 1 */
    str r2, [r1]	/* stores value in register 2 into stay_in variable */
    b return_bal
    
    set_eat_ice_cream:
    ldr r1, =eat_ice_cream	    /* loads address eat_out into register 1 eat_ice_cream */
    mov r2, #1		/* sets register 2 to 1 */
    str r2, [r1]	/* stores value in register 2 into eat_ice_cream variable */
    b return_bal
    
    return_bal:
    ldr r2, =balance	    /* loads the address of balance into r2 */
    ldr r0, [r2]	/* loads the current value of balance into r0 (yes... again) */
    
    b done
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




