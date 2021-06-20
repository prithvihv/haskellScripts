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


cal1NotCool :: Maybe Pole  
cal1NotCool = case landLeft 1 (0,0) of  
	Nothing -> Nothing  
	Just pole1 -> case landRight 4 pole1 of   
		Nothing -> Nothing  
		Just pole2 -> case landLeft 2 pole2 of  
			Nothing -> Nothing  
			Just pole3 -> landLeft 1 pole3  