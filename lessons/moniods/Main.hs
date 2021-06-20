-- TODO not complete

{--
ghci> 4 * 1  
4
ghci> 1 * 9  
9
ghci> [1,2,3] ++ [] 
[1,2,3]
ghci> [] ++ [0.5, 2.5]  
[0.5,2.5]
--}

{--
observations of func ++ and * (binary functions):
1. take 2 params
2. return same type as params
3. identify function exsits
4. associativity, and be done in any order

5-4-3 , 5-(4-3), (5-4)-3 break 4


This is a monoid! We just discorved monoid

More formally:
A monoid is when you have an associative binary function and a value which acts as an identity with respect to that function.
--}

class Monoid m where  
    mempty :: m  
    mappend :: m -> m -> m -- binary associative function, not related to append
    mconcat :: [m] -> m  
    mconcat = foldr mappend mempty 

{--
implementation of the laws:
TO check manually?
3. mempty `mappend` x = x
    x `mappend` mempty = x
4. (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)

can make a breaking moniod in haskell
--}