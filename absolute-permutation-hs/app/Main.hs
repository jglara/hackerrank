module Main where

import Control.Applicative ((<|>))
import Data.Maybe (fromMaybe)


solve1 :: [Int] -> [Int]
solve1 [n,k] = fromMaybe [-1] $ solve n k (reverse [1..n]) []
solve1 _ = [-1]

solve :: Int -> Int -> [Int] -> [Int] -> Maybe [Int]
solve _ _ [] acum = Just acum
solve n k (x:rest) acum = let s1 = if x-k>0 && notElem (x-k) acum then solve n k rest ((x-k):acum) else Nothing
                              s2 = if x+k<=n && notElem (x+k) acum then solve n k rest ((x+k):acum) else Nothing
                          in s1 <|> s2

main :: IO ()
main = interact $ unlines . map ( unwords . map show . solve1 . map read . words) . drop 1 . lines
