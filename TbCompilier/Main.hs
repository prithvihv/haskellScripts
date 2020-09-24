{-# LANGUAGE InstanceSigs #-}
import Data.List
import Data.Char
import Data.Bits

data TOKEN a = Operator a | 
               Function a | 
               KeyWord a | 
               VariableName a |
               Literal a |
               OPEN_BRACKETS |
               CLOSE_BRACKETS |
               OPEN_CURLY_BRACKETS | 
               CLOSE_CURLY_BRACKETS |
               WHITESPACE |
               INVALID
               deriving(Show)


isWhiteSpace :: [Char] -> Bool 
isWhiteSpace =  
    all (isSpaceChar)
    where
        isSpaceChar :: Char -> Bool
        isSpaceChar char = do 
            let num = ord char
            (== num) $ (.&.) whiteSpaceBinary num
        whiteSpaceBinary :: Int 
        whiteSpaceBinary = 
            foldl (.|.) 0
                [ (shiftL 1 (ord '\t')),
                (shiftL 1 (ord '\n')),
                (shiftL 1 (ord ' '))
                ]

-- parseToken a = undefined
-- parseToken needs context of the previous element
parseToken :: TOKEN [Char] -> [Char] -> TOKEN [Char]
parseToken _ "(" = OPEN_BRACKETS
parseToken _ ")" = CLOSE_BRACKETS
parseToken _ "{"  = OPEN_CURLY_BRACKETS
parseToken _ "}"  = CLOSE_CURLY_BRACKETS
parseToken (VariableName a) "+" = Operator "+"
parseToken (VariableName a) "-" = Operator "-"
parseToken _ "print" = Function "print" 
parseToken (KeyWord "READ") s = VariableName s
parseToken _ a 
    | isWhiteSpace a = WHITESPACE
    | "\"" `isPrefixOf` a && "\"" `isSuffixOf` a  = Literal a
    | otherwise = INVALID


lexParser :: Int -> [TOKEN a] -> [Char] -> [TOKEN a]
lexParser curr allTokens code = do
    let toParse1 = takeWhile (/=' ') (drop curr code) -- read till space
    [] :: [TOKEN a]

tblex :: String -> [TOKEN a]
tblex = lexParser 0 []

main :: IO()
main = 
    print "hello world"