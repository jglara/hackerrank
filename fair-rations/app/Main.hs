module Main where


solve :: [Int] -> Maybe Int
solve xs = let fun x (b,n) = if b then (not x, n+2) else (x, n)
               (b,n) = foldr (fun . odd) (False,0) xs
           in if b then Nothing else Just n




main :: IO ()
main = interact $ (++ "\n") . maybe "NO" show . solve . map read . words . (!! 1) . lines
