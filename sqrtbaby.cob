*> File: sqrtbaby.cob
*> Name: Peter Hudel
*> Student Number: 1012673
*> Date: 03/27/2020
*> Description: Task 1: This program is a modernized version of cobol to calculate the babylonian square root

*> --------------------------------------------------------------------------------------------
identification division.
	program-id. sqrtbaby.
*> --------------------------------------------------------------------------------------------
environment division.
*> --------------------------------------------------------------------------------------------
data division.
	working-storage section.
		77 numIterations    picture s9999.
		77 x    picture 9(11)v9(6).
		77 y    picture 9(11)v9(6).
		77 z    picture 9(11)v9(6).
		77 temp picture s9(11)v9(6).
		77 doneComputation pic 9 value 0.

		77 userInput pic s9(11)v9(6).
		01 doMainLoop pic X(3) value 'yes'.
		77 formatteduserInput pic z(11).9(6).
*> --------------------------------------------------------------------------------------------
procedure division.
	*> Main program loop here
	perform until doMainLoop = 'no'
		*> Reset values, get user input and calculate the square root
		move 0 to doneComputation

		display "Enter the number to find the square root of: "
		accept userInput

	    if userInput > 0 then
	    	perform findSquareRoot
	    else
	    	display "invalid input"
	    end-if

	    display "Type 'no' to stop calculating roots, anything else to continue: "
	    accept doMainLoop
	end-perform.
stop run.

*> This calculates the babylonian square root by performing the following:
*> 1. Divide the number by an approximation (2 to begin with)
*> 2. Average the original approximation and the new approximation
*> 3. Set the new approximation to be that average, go back to step 2

findSquareRoot. 
    move userInput to z.
    *> This is the estimation
    compute x rounded = z / 2.

    *> Make sure to exit program if too many iterations were reached to prevent infinite loop
    perform doCalculation varying numIterations from 1 by 1
        until doneComputation = 1 or numIterations > 1000.

    if numIterations > 1000
    	display "attempt aborted, too many iterations"
    end-if.
    move 0 to numIterations.

doCalculation. 
    compute y rounded = 0.5 * (x + z / x).
    compute temp = y - x.
    if temp < 0
    	compute temp = - temp
    end-if.

    if temp / (y + x) > 0
    	*> Not done calculating square root yet
    	move y to x
    else
    	*> Square root is calculated, print it out (formatted) and set the finished computing flag to 1
    	move y to formatteduserInput
    	display "The square root is: ", formatteduserInput
    	move 1 to doneComputation
    end-if.
