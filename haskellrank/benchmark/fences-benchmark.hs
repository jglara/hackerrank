module Main where

import Criterion
import Criterion.Main (defaultMain)
import System.Random

import qualified Fences (solve)

main :: IO ()
main = do
  [l1, l2, l3, l4, l5, l6] <- mapM 
    randomList [1, 10, 100, 1000, 10000, 1]
  defaultMain
    [ bgroup "fences tests" 
      [ bench "Size 1 Test" $ whnf Fences.solve l1
      , bench "Size 10 Test" $ whnf Fences.solve l2
      , bench "Size 100 Test" $ whnf Fences.solve l3
      , bench "Size 1000 Test" $ whnf Fences.solve l4
      , bench "Size 10000 Test" $ whnf Fences.solve l5
      , bench "Size 3000 Test" $ whnf Fences.solve l6
      ]
    ]

-- Generate a list of a particular size
randomList :: Int -> IO [Int]
randomList n = sequence $ replicate n (randomRIO (1, 10000 :: Int))
