module Main where

import Data.List (sort)


findPivot :: String -> (String, String)
findPivot s@(f:_) = let s_max = scanl max f s
                        (l,r) = span (\(a,b) -> b<=a) $ zip s (tail s_max)
                    in (map fst l, map fst r) 

findPivot [] = ([],[])


exchange :: Char -> String -> String
exchange c [] = [c]
exchange c s = let (l,r) = span (<= c) $ sort s
               in [head r] ++ l ++ [c] ++ tail r

biggerIsGreater :: String -> String
biggerIsGreater w = let (l,r) = findPivot $ reverse w
                    in if null r then "no answer"
                                 else reverse (tail r) ++ exchange (head r) l                                                                   
main = interact $ unlines . map biggerIsGreater . drop 1 . lines
