identification division.
	program-id. sqrtbaby.
environment division.
	input-output section.


data division.
	working-storage section.
		77 diff picture v9(5).
		77 z    picture 9(11)v9(6).
		77 k    picture s9999.
		77 x    picture 9(11)v9(6).
		77 y    picture 9(11)v9(6).
		77 temp picture 9(11)v9(6).
		77 done pic 9 value 0.

		77 squareRoot pic s9(11)v9(6).
		01 doMainLoop pic X(3) value 'yes'.
		77 formattedSquareRoot pic z(11).9(6).

procedure division.
	perform until doMainLoop = 'no'
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

    perform doCalculation varying k from 1 by 1
        until done = 1 or k is greater than 1000.

    if k > 1000
    	display "attempt aborted, too many iterations"
    else
    	move 0 to k
    end-if.

doCalculation. 
    compute y rounded = 0.5 * (x + z / x).
    subtract x from y giving temp.
    if temp is less than zero compute temp = - temp.

    if temp / (y + x) > diff 
    	move y to x
    else
    	move y to formattedSquareRoot
    	display "The square root is: ", formattedSquareRoot
    	move 1 to done
    end-if.
