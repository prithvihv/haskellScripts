{--
---------- THE REAL DEAL
--}

{--
THE PIERRE BALANCING PROBLEM

left side - right side is within 3
example :
L = 4 and R = 1 -- all good
L = 5 and R = 1 -- die
--}

type Birds = Int  
type Pole = (Birds,Birds) 

landLeft :: Birds -> Pole -> Pole  
landLeft n (left,right) = (left + n, right)

landRight :: Birds -> Pole -> Pole  
landRight n (left,right) = (left,right + n)


cal1 :: Pole
cal1 = landLeft 2 (landRight 1 (landLeft 1 (0,0)))  
{-- 
	just doing actions sequentially
	this can be done in a better way

	what if we had a function that would could help us chain
--}
x -: f = f x

cal1Cooler :: Pole
cal1Cooler = (0,0) -: landLeft 1 -: landRight 1 -: landLeft 2
-- much more reable already
