{-# LANGUAGE BangPatterns #-}
module Fences where

import Control.Monad
import Control.Monad.ST
--import Control.Monad.Primitive
import qualified Data.Vector.Unboxed as V
--import qualified Data.Vector.Unboxed.Mutable as MV


--import Data.List
--rectangle :: Int -> [Int] -> Int
--rectangle k = maximum. map ((*k) . length) . filter (elem False) . group . map (<k)
--
--solve :: [Int] -> Int
--solve xs = maximum . map (`rectangle` xs) $ xs

solve :: [Int] -> Int
solve xs = snd . V.head . reduceFences 1 $ V.fromList xs'
           where xs' = map (\x -> (x,x)) xs

reduceFences :: Int -> V.Vector (Int,Int) -> V.Vector (Int,Int)
reduceFences _ xs | 1 >= V.length xs = xs
reduceFences n xs = reduceFences (n+1) $ (V.zipWith (reduce2 (n+1)) <*> V.tail) xs

reduce2 :: Int -> (Int, Int) -> (Int, Int) -> (Int, Int)
reduce2 n (min_height, max_rect) (min_height', max_rect') = let new_min = min min_height min_height'
                                                            in (new_min, maximum [new_min * n, max_rect, max_rect'])

fences :: String -> String
fences = (++ "\n") . show . solve . map read . words . (!! 1) . lines
