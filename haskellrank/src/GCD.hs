module Main where

lgcd :: [Int] -> [Int] -> [Int]
lgcd _ [] = []
lgcd [] _ = []
lgcd xs@(x:n:xs') ys@(y:m:ys')
  | (x < y) = lgcd xs' ys
  | (x > y) = lgcd xs ys'
  | otherwise = x:min n m:lgcd xs' ys'

mlgcd :: [[Int]] -> [Int]
mlgcd = foldr1 lgcd

main :: IO ()
main = interact $ unwords . map show . mlgcd . map ((map read) . words) . tail . lines
