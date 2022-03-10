{-# LANGUAGE BangPatterns #-}
module PrisonTransport where

import Data.Vector.Unboxed ((!), (//))
import qualified Data.Vector.Unboxed as V

-- Union Find implemented with a Vector of three values: parent, depth , size

type UFParent = Int
type UFDepth = Int
type UFSize = Int
type UFNode = (UFParent, UFDepth, UFSize)

parent :: UFNode -> Int
parent (p,_,_) = p

depth :: UFNode -> Int
depth (_,d,_) = d

size :: UFNode -> Int
size (_,_,s) = s



find :: V.Vector UFNode -> Int -> UFNode
find uf i = let p = parent (uf ! i)
            in if p /= i then find uf p else uf ! i

unionChanges :: UFNode -> UFNode -> [(Int, UFNode)]
unionChanges ufa ufb | depth ufa < depth ufb = unionChanges ufb ufa
unionChanges (p_a, d_a, s_a) (p_b, d_b, s_b) = [(p_a, (p_a, if d_a == d_b then d_a+1 else d_a, s_a+s_b)),
                                                (p_b, (p_a, 0, 0))]

pathCompression :: Int -> UFNode -> [(Int, UFNode)]
pathCompression a rep_a = [(a, (parent rep_a, 0 , 0)) | a /= parent rep_a]


union :: V.Vector UFNode -> (Int, Int) -> V.Vector UFNode
union uf (a,b) = let rep_a = find uf a
                     rep_b = find uf b
                 in if rep_a /= rep_b then uf // (unionChanges rep_a rep_b ++ pathCompression a rep_a ++ pathCompression b rep_b) else uf
groups :: V.Vector UFNode -> V.Vector Int
groups = V.map size

busCost :: V.Vector Int -> Int
busCost = V.sum . V.map (ceiling . sqrt . fromIntegral)


parseInput :: [String] -> (Int, V.Vector (Int, Int))
parseInput ls = let n = read $ head ls
                    ls' = drop 2 ls
                    pairs = map ((\[x,y] -> (read x - 1, read y - 1)) . words) ls'
                in (n, V.fromList pairs)


solve :: Int -> V.Vector (Int, Int) -> V.Vector UFNode
solve n = V.foldl' union (V.fromList [(i,0,1) | i <- [0..n-1]])

testInput2 = "4\n2\n1 2\n1 4\n"

testInput1 = "10\n9\n1 2\n3 4\n5 6\n7 8\n9 10\n1 3\n5 7\n1 5\n1 9\n"

main :: IO ()
main = interact $ (++ "\n") . show . busCost . groups . uncurry solve . parseInput . lines

