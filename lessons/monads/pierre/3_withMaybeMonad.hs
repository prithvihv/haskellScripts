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


landLeft :: Birds -> Pole -> Maybe Pole  
landLeft n (left,right)  
	| abs ((left + n) - right) < 4 = Just (left + n, right)  
	| otherwise                    = Nothing  

landRight :: Birds -> Pole -> Maybe Pole  
landRight n (left,right)  
	| abs (left - (right + n)) < 4 = Just (left, right + n)  
	| otherwise                    = Nothing  

-- cal1 :: Pole
-- cal1 = landLeft 2 (landRight 1 (landLeft 1 (0,0)))  
{-- 
	just doing actions sequentially
	this can be done in a better way

	what if we had a function that would could help us chain
--}
x -: f = f x

cal1Cooler :: Maybe Pole
cal1Cooler = pure (0,0) >>= landLeft 1 >>= landRight 1 >>= landLeft 2 -- return / pure are interchangable
-- much more reable already


banana :: Pole -> Maybe Pole  
banana _ = Nothing  

cal2Cooler :: Maybe Pole
cal2Cooler = pure (0,0) >>= landLeft 1 >>= banana >>= landRight 1 >>= landLeft 2


cal2UsingArrows :: Maybe Pole
cal2UsingArrows = pure (0,0) >>= landLeft 1 >> Nothing >>= landRight 1 >>= landLeft 2 -- no use of banana