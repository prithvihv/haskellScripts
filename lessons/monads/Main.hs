-- TODO: not complete
-- Monads are a natural extension of applicative functors

(>>=) :: (Monad m) => m a -> (a -> m b) -> m b  
-- moniods allow us to operate on functions that return a (m b) by accepting a (m a)


-- Maybe Monad
applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b  
applyMaybe Nothing f  = Nothing  
applyMaybe (Just x) f = f x  

{--
> (\x -> Just (x+1)) 100 
Just 101

imagine we have a just 100, then what?
using applicatives:

> (\x -> Just (x+1)) <$> (Just 100)
Just(Just 100)

bruh can't do shit with this?

A monad solves this problem
>>= or =<<
the side with the `=`  has the func

> (\x -> Just (x+1)) =<< (Just 100)
Just 101
--}

class Monad m where  
   return :: a -> m a  
      
   (>>=) :: m a -> (a -> m b) -> m b -- just studied
      
   (>>) :: m a -> m b -> m b  
   x >> y = x >>= \_ -> y  -- never reimplement
      
   fail :: String -> m a  
   fail msg = error msg   -- used by haskell itself in special cases

-- UNTOLD RULE: `Every monad is an applicative functor, even if the Monad class declaration doesn't say so. `



{--
---------- STUDY maybe monad
--}

instance Monad Maybe where  
   return x = Just x  
   Nothing >>= f = Nothing  
   Just x >>= f  = f x  
   fail _ = Nothing  

-- Go through the pierre example

{--
Studing >>
>> :: m a -> m b -> m b  
m >> n = m >>= \_ -> n  

Although the function looks like it's doing nothing but returning the second argument. It does more.


The interesting part about `>>` is that it applied >>=! That means if m is empty we wont move forward to return n.

Normally, passing some value to a function that ignores its parameter and always just returns some predetermined value would always result in that predetermined value. With monads however, their context and meaning has to be considered as well. Here's how >> acts with Maybe: 

here's how these functions react with monads:
ghci> Nothing >> Just 3  
Nothing
ghci> Just 3 >> Just 4  
Just 4
ghci> Just 3 >> Nothing  
Nothing
--}


{--
Maybe monad saves us a lot of time when we have to successively do computations that are based on computations that might have failed. 
--}


--- DO notation
{--
imagine we had a use cases where multiple Monadic values had to be computed, then used. Not of the same type/purpose (unlike our last example)

say we had to do 
ghci> Just 3 >>= (\x -> Just "!" >>= (\y -> Just (show x ++ y)))  
Just "3!"  

Just "!" is another computation that needs to be run before we can get the resutls of the initial monadic computations
--}
foo :: Maybe String  
foo = Just 3   >>= (\x -> 
      Just "!" >>= (\y -> 
      Just (show x ++ y)))  

-- WE HATE NESTING HERE :) therefore DO

foo2:: Maybe String 
foo2 = do
   x <- Just 3
   y <- Just "!"
   Just (x ++ y) -- if Any of the do would fail, the whole block would fail!
{--
this is different from chaining! We arent tryint to chain the same computation?

much like how >>= can be used to extact and pass to a function
<- can be used to inspect safely

another simple example of a converstion
ghci> Just 9 >>= (\x -> Just (x > 8))  
Just True  
--}
marySue :: Maybe Bool  
marySue = do
   x <- Just 9  
   Just (x > 8)  

{-- WITH MAYBE MONAD AND DO BLOCK --}
routine :: Maybe Pole  
routine = do  
   start <- return (0,0)  
   first <- landLeft 2 start  
   second <- landRight 2 first  
   landLeft 1 second  

-- We didnt need to use a do block here cause there's only 1 monad, what about a multiple monad block?