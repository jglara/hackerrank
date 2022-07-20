module Main where

import Data.List (transpose)

solve :: [[Int]] -> Int
solve g = sum $ map sum [map count_surface g,
               map (count_surface . reverse) g,
               map count_surface g_transpose,
               map (count_surface . reverse) g_transpose,
               [total_len, total_len]
              ]
          where count_surface :: [Int] -> Int
                count_surface v = head v + (sum $ zipWith (\a b -> if b>a then b-a else 0) v (tail v))
                g_transpose = transpose g
                total_len = length g * length (head g)


main :: IO ()
main = interact $ (++ "\n") . show . solve . map (map read . words) . drop 1 . lines
