*> --------------------------------------------------------------------------------------------
identification division.
	program-id. sqrtbaby.
*> --------------------------------------------------------------------------------------------
environment division.
*> --------------------------------------------------------------------------------------------
data division.
	working-storage section.
		77 userInput pic s9(11)v9(6).
		77 result pic s9(11)v9(6).
		77 formattedResult pic z(11).9(6).
		01 doMainLoop pic X(3) value 'yes'.
*> --------------------------------------------------------------------------------------------
procedure division.
	*> Main program loop here
	perform until doMainLoop = 'no'
		display "Enter the number to find the square root of: "
		accept userInput

	    if userInput > 0 then
	    	call "squareroot" using userInput, result
	    	if result = -1 then
	    		display "attempt aborted, too many iterations"
	    	else
	    		move result to formattedResult
	    		display "The square root is: " formattedResult
	    	end-if
	    else
	    	display "invalid input"
	    end-if

	    display "Do you want to calculate another root? (yes/no): "
	    accept doMainLoop
	end-perform.
stop run.