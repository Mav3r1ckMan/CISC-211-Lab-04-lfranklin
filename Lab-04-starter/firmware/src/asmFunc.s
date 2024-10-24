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
   ldr r1, =transaction /* Loads the address of transaction */
   str r0, [r1] /* Loads the value of transaction into r0 */
    
   /* Compares transaction against 1000 */
   cmp r1, #1000
   bgt transaction_out_of_bounds /* Branch if greater than 1000 */
   
   /* Compares transaction against -1000 */
   cmp r1, #-1000
   blt transaction_out_of_bounds /* Branch if less than 1000 */
   
   /* If transaction is within bounds */
   transaction_ok:
   ldr r1, =balance
   ldr r2, [r1]
   
   adds r3, r2, r0
   
   bvs overflow_detected
   ldr r1, =tmpBalance
   str r3, [r1]
   
   b done
   
   /* Overflow */
   overflow:
    ldr r1, =we_have_a_problem
    move r0, #1
    str r0, [r1]
   
    
   /* If transaction is greater than 1000 or less than -1000 */
   transaction_out_of_bounds:
    mov r0, #0
    str r0, [r1]
    
    ldr r1, =we_have_a_problem
    move r0, #1
    str r-, [r1]
    
    ldr r1, =balance
    ldr r0, [r1]
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




