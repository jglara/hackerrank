module Main where

solve :: [Int] -> Int
solve [] = maxBound :: Int
solve [x] = if x == 0 then 0 else maxBound :: Int
solve [x,y] = if x == 0 then 1 + solve [y] else maxBound :: Int
solve (x:xs) = if x == 0 then 1 + min (solve xs) (solve $ tail xs)
               else maxBound :: Int

solve2 :: [String] -> Int
solve2 [s,b] = let n = read b
                   count_a = length $ filter (== 'a') s
                   count_a_rest = length $ filter (== 'a') $ take (n `mod` length s ) s
               in count_a * (n `div` length s) + count_a_rest
solve2 _ = 0                  
                            

main :: IO ()
main = interact $ (++ "\n") . show . solve . map read . words . (!! 1) . lines
