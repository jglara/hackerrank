module Main where


sumsOfPowers :: Int -> Int -> Int -> Int -> Int
sumsOfPowers i x n acum | (i ^ n) == x = acum+1
                        | (i ^ n) > x = 0
                        | otherwise = sumsOfPowers (i+1) x n acum + sumsOfPowers (i+1) (x-(i ^ n)) n acum


sumsOfPowersWrapper :: [Int] -> Int
sumsOfPowersWrapper (x:n:[]) = sumsOfPowers 1 x n 0

main :: IO ()
main = interact $ show . sumsOfPowersWrapper . map read . words 
