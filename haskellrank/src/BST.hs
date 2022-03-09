module BST where

import Data.Bool

consumeBST :: (Int, Int) -> [Int] -> [Int]
consumeBST _ [] = []
consumeBST (l,r) xs@(n:_) | n < l || n > r = xs
consumeBST _ [x] = []
consumeBST (l,r) (n:x:xs') = let rest = if x<n then consumeBST (l,n) (x:xs') else x:xs'
                             in consumeBST (n,r) rest


validBST :: [Int] -> Bool
validBST [] = True
validBST xs = let rest = consumeBST (minBound :: Int, maxBound :: Int) xs
                  in null rest




parseInput :: String -> [[Int]]
parseInput = map (map read . words . snd) . filter (\(i,l) -> odd i) . zip [0..] . tail . lines

sampleInput :: String
sampleInput = "5\n3\n1 2 3\n3\n2 1 3\n6\n3 2 1 5 4 6\n4\n1 3 4 2\n5\n3 4 5 1 2\n1\n1\n"

sampleInput2 :: String
sampleInput2 = "10\n3\n3 2 1\n1\n1\n3\n2 3 1\n3\n2 1 3\n4\n3 1 4 2\n9\n2 3 6 7 4 8 9 5 1\n6\n3 2 1 4 6 5\n6\n3 2 1 4 5 6\n6\n5 1 4 2 6 3\n2\n1 2\n"

                                 
                                         
solveBST :: IO ()
solveBST = interact $ unlines . map (bool "NO" "YES" . validBST) . parseInput
