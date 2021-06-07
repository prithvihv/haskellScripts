{- learnyouahaskell
    Typeclasses, help give type behavioural properties! by adding hidden implementations
    Functor is a type class, 
        that defines fmap
        the f represents not a type but a type contructor
-}

{- WIKI math:
    In mathematics, specifically category theory, a functor is a mapping between categories. Functors were first considered in algebraic topology, where algebraic objects (such as the fundamental group) are associated to topological spaces, and maps between these algebraic objects are associated to continuous maps between spaces. Nowadays, functors are used throughout modern mathematics to relate various categories. Thus, functors are important in all areas within mathematics to which category theory is applied.
-}

{- learnyouahaskell
    In the same vein, if we write fmap :: (a -> b) -> (f a -> f b), we can think of fmap not as a function that takes one function and a functor and returns a functor, but as a function that takes a function and returns a new function that's just like the old one, only it takes a functor as a parameter and returns a functor as the result. It takes an a -> b function and returns a function f a -> f b. This is called lifting a function
-}

-- there are some laws functors have a obey according to Math but not enforced by haskell
{- learnyouahaskell
1. The first functor law states that if we map the id function over a functor, the functor that we get back should be the same as the original functor.
2. The second law says that composing two functions and then mapping the resulting function over a functor should be the same as first mapping one function over the functor and then mapping the other one. Formally written, that means that fmap (f . g) = fmap f . fmap g. Or to write it in another way, for any functor F, the following should hold: fmap (f . g) F = fmap f (fmap g F).
-}

-- Be carefull while implementing a functor, if the fmap implementation of our functor does any complex operation, it wont obey the laws
data CMaybe a = CNothing | CJust Int a deriving (Show)  
instance Functor CMaybe where  
    fmap f CNothing = CNothing  
    fmap f (CJust counter x) = CJust (counter+1) (f x)  

testFunctor1 = do
    print $ fmap id (CJust 0 "haha")
    print $ id (CJust 0 "haha")

-- functor typeclasses tell us that we can operator on the things inside of it!

-- type TODOItem a = StringItem a
-- type Category = String
-- type Priority = Int

-- type TodoItems = Reminder | Habbit | Todo

-- class TODOFeatures a where
--     completed :: a -> Bool
--     message :: a -> String
--     category :: a -> Category
--     priority :: a -> Priority
--     deadline :: a -> String

