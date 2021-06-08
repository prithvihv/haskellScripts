-- this file doesnt actually compile it just represent logic and meaning


-- what happens when functions that take 2 arguments are applied to a functios
ex0 = do
    let a = fmap (*) [1,3,2]
    a
{-
    a :: [Integer -> Integer]
    all elements are partially applied
-}


{-
    imagine we had a Just 5 and a Just (*3) it's impossible to operate on the values of these assuming that they are just functors
    applicative typeclass:
-}
class (Functor f) => Applicative f where  
    pure :: a -> f a  
    (<*>) :: f (a -> b) -> f a -> f b  

-- applicatives are also referred to as applicative functors, cause they have to be functors
{-
    pure part is very borning
    <*> part: extracts the function from the first functor and then maps it over the second one.
-}

instance Applicative Maybe where  
    pure = Just  
    Nothing <*> _ = Nothing
    (Just f) <*> something = fmap f something  

{-
ghci> pure "Hey" :: [String]  
["Hey"]  
ghci> pure "Hey" :: Maybe String  
Just "Hey" 
-}

-- now this works
ex1 = do
    let  a = Just (*3)
    let b = Just 5
    c = a <*> b

-- want to see something cooler?
ex2 = do
    let a = Just (*)
    let b = Just 5
    let c = Just 3
    d = a <*> b <*> c
{-
    because of the way fmap + currying works, they carry the function instead the functor, and applicatives allow us to apply the internal functor
    learnyouahaskell: 
    Applicative functors and the applicative style of doing pure f <*> x <*> y <*> ... allow us to take a function that expects parameters that aren't necessarily wrapped in functors and use that function to operate on several values that are in functor contexts
-}

{-
    This pattern is so cool that we want to apply it to normal functions too
    So we have law 1 
        pure f <*> x = fmap f x 
    how is this helpful? What if <$> was a infix operatorf for fmap
        we could right the right hand side as: f <$> x

    now if we have a normie function (++) :: a -> a -> a
    we can do: f <$> a <*> a
-}

{-
    NOTE: with applicatives, sofar f has to be constant accoss all the params.
-}

ex3 = do
    (++) "what" " is happening"
    (++) <$> Just "what" <*> Just " is happening"
-- haskell is very powerfull in this way of representing logic! both those line return the almost the same thing but the second line handles so many extra condition to what happens when one those are Nothing. This would start looking very ugly in other programming languages.

-- Case study 2: List applicatives:
instance Applicative [] where  
    pure x = [x]  
    fs <*> xs = [f x | f <- fs, x <- xs]  
{-
ghci> [(+),(*)] <*> [1,2] <*> [3,4]  
[4,5,5,6,3,4,6,8]  
-}

{-
ghci> (++) <$> ["ha","heh","hmm"] <*> ["?","!","."]  
["ha?","ha!","ha.","heh?","heh!","heh.","hmm?","hmm!","hmm."]  

patterns of applying normal functions to functors

    EXPLAINATION TO LIST APPLICATIVES:
    You can view lists as non-deterministic computations. A value like 100 or "what" can be viewed as a deterministic computation that has only one result, whereas a list like [1,2,3] can be viewed as a computation that can't decide on which result it wants to have, so it presents us with all of the possible results. So when you do something like (+) <$> [1,2,3] <*> [4,5,6], you can think of it as adding together two non-deterministic computations with +, only to produce another non-deterministic computation that's even less sure about its result.
-}


--case study 4: functions applicative (skipped IO applicative)
instance Applicative ((->) r) where  
    pure x = (\_ -> x)  
    f <*> g = \x -> f x (g x)  
-- these are easy to miss cause function applicative/ functions properties are the onces applied by default
-- for example pure 3, applies this applicative

-- applicatives on functions is still confusing to me
{-
    ghci> (\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5  
    [8.0,10.0,2.5]  

after applying fmap looking by left associative
(Int -> Int -> [Int])  <*> (Int -> Int)

:t (<*>) @((->)_)
(w -> (a -> b)) -> (w -> a) -> w -> b
-}


-- INRESTING applicative funcitons:
{-
sequenceA :: (Applicative f) => [f a] -> f [a]  
sequenceA [] = pure []  
sequenceA (x:xs) = (:) <$> x <*> sequenceA xs  

ghci> sequenceA [Just 3, Just 2, Just 1]  
Just [3,2,1]  
ghci> sequenceA [Just 3, Nothing, Just 1]  
Nothing  
ghci> sequenceA [(+3),(+2),(+1)] 3  
[6,5,4]  
ghci> sequenceA [[1,2,3],[4,5,6]]  
[[1,4],[1,5],[1,6],[2,4],[2,5],[2,6],[3,4],[3,5],[3,6]]  
ghci> sequenceA [[1,2,3],[4,5,6],[3,4,4],[]]  
[]  

ghci> sequenceA [(>4),(<10),odd] 7  
[True,True,True]  
ghci> and $ sequenceA [(>4),(<10),odd] 7  
True 

vs noob way
ghci> map (\f -> f 7) [(>4),(<10),odd]  
[True,True,True]  
ghci> and $ map (\f -> f 7) [(>4),(<10),odd]  
True  
-}
ex4 = do
    let a = sequenceA [Just 10, Just 39, Just 2]
    a  -- Just [10,39,2]
