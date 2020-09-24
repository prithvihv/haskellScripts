{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE BlockArguments #-}
module Main where

import Data.List (sortBy)

data Vertex = 
    Vertex {
        id :: Int,
        props :: [Int]
    } deriving (Show,Eq)

-- weight of edge
data Edge = Edge Int
    deriving (Show,Eq)

-- generates vertex with random prop values
genVertex:: Int -> Int -> [Vertex]
genVertex count propCount = do
    [ Vertex id propArr  | 
        id <- [1..count], 
        let propArr = [ (id+i) `mod` propCount | i  <- [1..propCount] ]]

-- generates edges to random vertices
genEdges:: Int -> [Vertex] -> Int -> Int -> [(Vertex,Edge)]
genEdges count vArr eWeight index = 
    [ (v,e) |
        j <- [1 .. count]
        , let ranGen = (index * j + index * j `mod` 5) `mod` cVertex
        , let v = vArr !! ranGen
        , let e = Edge if eWeight == 0 then ranGen else eWeight
    ]
    where 
        cVertex = length vArr - 1

-- comparing value of 2 neighbours with respect to a vertex
compareNeighours :: (Vertex,Edge) -> (Vertex,Edge) -> Ordering
compareNeighours vA vB = 
    if (nodeValue vA) > nodeValue vB then GT else LT
    where
        betaValues = [4,7,9,3]  -- set beta values for our linear equation
        nodeValue:: (Vertex,Edge) -> Int
        nodeValue (n,Edge e) = sum (map 
                                    (\(a,b)-> a * b) 
                                    (zip (props n) betaValues))
                                + (e)

main :: IO ()
main = do 
    let allVertex = genVertex 14000000 4
        graph = map (genEdges 800 allVertex 0) [0..(length allVertex-1)]
        recommendations = sortBy compareNeighours (graph !! 4) 
    print $ "Number of neighbours : "
    print  (length (graph !! 4))
    print $ graph !! 4
    print $ recommendations == (graph !! 4)

    
