module Main where

solve :: String -> Int
solve xs = let level = (scanl (+) 0) $ map (\c -> if c == 'D' then -1 else 1) xs
        in length $ filter (\(l1,l2) -> l1 == -1 && l2 == 0) $ zip level (tail level)
          

main :: IO ()
main = interact $ (++ "\n") .show . solve . (!! 1) . lines
