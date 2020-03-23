*> File: squareroot.cob
*> Name: Peter Hudel
*> Student Number: 1012673
*> Date: 03/27/2020
*> Description: This is the external function which is called by sqrtbabyex.cob

*> --------------------------------------------------------------------------------------------
identification division.
    program-id. squareroot.
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
*> --------------------------------------------------------------------------------------------
linkage section.
    77 userInput pic s9(11)v9(6).
    77 result pic s9(11)v9(6).
*> --------------------------------------------------------------------------------------------

*> This function is responsible for calculating the babylonian square root of a number.
*> Param: userInput: The value entered by the user
*> Returns: result: The square root of the number inputted. Returns -1 if it went over in iterations

*> This calculates the babylonian square root by performing the following:
*> 1. Divide the number by an approximation (2 to begin with)
*> 2. Average the original approximation and the new approximation
*> 3. Set the new approximation to be that average, go back to step 2

procedure division using userInput, result.

    move userInput to z.
    move 0 to doneComputation.

    *> This is the estimation
    compute x rounded = z / 2.

    *> Make sure to exit program if too many iterations were reached to prevent infinite loop
    perform doCalculation varying numIterations from 1 by 1
        until doneComputation = 1 or numIterations > 1000.

    if numIterations > 1000
        move -1 to result
    end-if.

    move 0 to numIterations.
    goback.

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
        move y to result
        move 1 to doneComputation
    end-if.
