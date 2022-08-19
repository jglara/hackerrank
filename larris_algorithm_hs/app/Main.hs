module Main where


merge :: [Int] -> [Int] -> ([Int], Int)
merge xs [] = (xs, 0)
merge [] ys = (ys, 0)
merge xs@(x:xs') ys@(y:ys')
  | x <= y = let (ms, mc) = merge xs' ys
             in (x:ms, mc)
  | otherwise = let (ms, mc) = merge xs ys'
                in (y:ms, length xs + mc)

mergeSort :: [Int] -> ([Int], Int)
mergeSort [] = ([], 0)
mergeSort [x] = ([x], 0)
mergeSort xs = let
                 splitHalf = (flip splitAt <*> ((`div` 2) .length))
                 (l,r) = splitHalf xs
                 (ls, c1) = mergeSort l
                 (rs, c2) = mergeSort r
                 (ms, c3) = merge ls rs
               in (ms, c1+c2+c3)
                    

solve :: [Int] -> Bool
solve xs = let inversions = (snd . mergeSort) xs
           in even inversions 

solve' :: [String] -> [Bool]
solve' [] = []
solve' (_:y:xs) = solve (map read (words y)) : solve' xs
solve' _ = undefined

main :: IO ()
main = interact $ unlines . map (\x -> if x then "YES" else "NO") . solve' . drop 1 . lines
