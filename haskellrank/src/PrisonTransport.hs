module PrisonTransport where

import Data.Vector.Unboxed ((!), (//))
import qualified Data.Vector.Unboxed as V

union :: V.Vector Int -> (Int, Int) -> V.Vector Int
union uf (a,b) | uf ! a > 0 = union uf (uf ! a, b)
union uf (a,b) | uf ! b > 0 = union uf (a, uf ! b)
union uf (a,b) = let ufa = uf ! a
                     ufb = uf ! b
                 in uf // [(a, ufa + ufb), (b, a)]

groups :: V.Vector Int -> V.Vector Int
groups = V.map abs . V.filter (<0)

busCost :: V.Vector Int -> Int
busCost = V.sum . V.map (ceiling . sqrt . fromIntegral)


parseInput :: [String] -> (Int, V.Vector (Int, Int))
parseInput ls = let n = read $ head ls
                    ls' = drop 2 ls
                    pairs = map ((\[x,y] -> (read x - 1, read y - 1)) . words) ls'
                in (n, V.fromList pairs)


solve :: Int -> V.Vector (Int, Int) -> Int
solve n = busCost . groups . V.foldl' union (V.replicate n (-1::Int))

testInput2 = "4\n2\n1 2\n1 4\n"

main :: IO ()
main = interact $ (++ "\n") . show . uncurry solve . parseInput . lines

