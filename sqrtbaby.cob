*> --------------------------------------------------------------------------------------------
identification division.
	program-id. sqrtbaby.
*> --------------------------------------------------------------------------------------------
environment division.
	input-output section.
*> --------------------------------------------------------------------------------------------
data division.
	working-storage section.
		77 diff picture v9(5).
		77 z    picture 9(11)v9(6).
		77 k    picture s9999.
		77 x    picture 9(11)v9(6).
		77 y    picture 9(11)v9(6).
		77 temp picture s9(11)v9(6).
		77 done pic 9 value 0.

		77 squareRoot pic s9(11)v9(6).
		01 doMainLoop pic X(3) value 'yes'.
		77 formattedSquareRoot pic z(11).9(6).
*> --------------------------------------------------------------------------------------------
procedure division.
	*> Main program loop here
	perform until doMainLoop = 'no'
		*> Reset values, get user input and calculate the square root
		move 0 to done
		move 1 to k

		display "Enter the number to find the square root of: "
		accept squareRoot

	    if squareRoot > 0 then
	    	perform findSquareRoot
	    else
	    	display "invalid input"
	    end-if

	    display "Do you want to calculate another root? (yes/no): "
	    accept doMainLoop
	end-perform.
stop run.

findSquareRoot. 
    move squareRoot to z.
    divide 2 into z giving x rounded.

    *> Make sure to exit program if too many iterations were reached to prevent infinite loop
    perform doCalculation varying k from 1 by 1
        until done = 1 or k > 1000.

    if k > 1000
    	display "attempt aborted, too many iterations"
    else
    	move 0 to k
    end-if.

doCalculation. 
    compute y rounded = 0.5 * (x + z / x).
    subtract x from y giving temp.
    if temp < zero
    	compute temp = - temp
    end-if.

    if temp / (y + x) > diff 
    	*> Not done calculating square root yet
    	move y to x
    else
    	*> Square root is calculated, print it out and set the finished computing flag to 1
    	move y to formattedSquareRoot
    	display "The square root is: ", formattedSquareRoot
    	move 1 to done
    end-if.
