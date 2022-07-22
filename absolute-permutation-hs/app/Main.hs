module Main where

import Control.Applicative ((<|>))
import Data.Maybe (fromMaybe)



solve1 :: [Int] -> [Int]
solve1 [n,0] = [1..n]
solve1 [n,k] | (n `mod`k == 0) && even (n `div` k) = solve n k
solve1 _ = [-1]

solve :: Int -> Int -> [Int]
solve n k = let mask = replicate k k ++ replicate k (-k)
            in zipWith (+) [1..n] (cycle mask)

main :: IO ()
main = interact $ unlines . map ( unwords . map show . solve1 . map read . words) . drop 1 . lines
