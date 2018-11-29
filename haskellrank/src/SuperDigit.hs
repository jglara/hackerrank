module Main where

sumDigits :: Integer -> Integer -> Integer
sumDigits n ac | n < 10 = n + ac
               | otherwise = sumDigits (n `div` 10) ac + (n `mod` 10)

superDigit :: Integer -> Integer
superDigit n | n < 10 = n
             | otherwise = superDigit $ sumDigits n 0

convertToDigit :: [String] -> Integer
convertToDigit (n:k:[]) = read k * sumDigits (read n) 0

main :: IO ()
main = interact $ show . superDigit . convertToDigit . words
