module Main where

coinChange :: Int -> [Int] -> Int
coinChange n [] | n==0      = 1
                | otherwise = 0

coinChange n cs@(c:cs') | n == c = 1
                        | n >= c = coinChange (n-c) cs + coinChange n cs'
                        | otherwise = coinChange n cs'

solveWrapper :: [Int] -> Int
solveWrapper (n:_:coins) = coinChange n coins

main :: IO ()
main = interact $ show . solveWrapper . map read . words
