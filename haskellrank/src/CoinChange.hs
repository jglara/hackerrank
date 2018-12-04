module Main where
import qualified Data.Vector as V
import Data.List (sort)

solveWrapper :: [Int] -> Int
solveWrapper (n:_:coins) = coinChange n 0
                           where ncoins = length coins
                                 coinsV = V.fromList $ sort coins
                                 changes = V.fromList [ V.fromList [ coinChange pn ic | ic <- [0..ncoins]] | pn <- [0..n]]
                                 coinChange n i | i == ncoins = if n == 0 then 1 else 0
                                                | n == c = 1
                                                | n >= c = (changes V.! (n-c) V.! i) + (changes V.! n V.! (i+1))
                                                | otherwise = changes V.! n V.! (i+1)
                                                where c = coinsV V.! i


main :: IO ()
main = interact $ show . solveWrapper . map read . words

