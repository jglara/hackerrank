module Main where


diffs :: [Int] -> [Int]
diffs = map (negate . signum) . (zipWith (-) <*> tail)


streaks' :: [Int] -> Int -> Int -> [Int] -> [[Int]] -> [[Int]]
streaks' [] _ l cs xss = (l:cs):xss

streaks' (x:xs) 0 l [] xss | x - l > 0 = streaks' xs 1 x [l] xss
                           | otherwise = streaks' xs (-1) x [l] xss

streaks' (x:xs) 0 l cs xss | x - l > 0 = streaks' xs 1 x [l] (cs:xss)
                           | otherwise = streaks' xs (-1) x [l, head cs] (tail cs:xss)

streaks' (x:xs) 1 l cs xss | x - l > 0 = streaks' xs 1 x (l:cs) xss
                           | x - l < 0 = streaks' xs 0 x (l:cs) xss
                          
streaks' (x:xs) (-1) l cs xss | x - l < 0 = streaks' xs (-1) x (l:cs) xss
                              | x - l > 0 = streaks' xs 0 x [] ((l:cs):xss)

streaks' _ _ _ _ _ = undefined                          


streaks :: [Int] -> [[Int]]
streaks [] = [[]]
streaks (x:xs) = reverse $ map reverse $ streaks' xs 0 x [] []

dir :: [Int] -> Int
dir [] = 1
dir [x] = 1
dir (x:y:xs) = signum (y-x)


solve :: [Int] -> String
solve xs = let ss = streaks xs
               ds = map dir ss
               l = length ss
           in solve' l ss ds


solve' :: Int -> [[Int]] -> [Int] -> String
solve' 0 [] [] = "yes"
solve' 1 [xs] [1] ="yes"
solve' 1 [xs] [-1] = printReverseSolution 1 xs
solve' 2 [si,sd] [1,-1] = if last sd > last si then printReverseSolution (length si + 1) sd else "no"
solve' 2 [sd,si] [-1,1] = if head sd < head si then printReverseSolution 1 sd else "no"
solve' 2 [si,[x']] [1,1] = if last si > x' then printSwapSolution (length si) (length si + 1) else "no"
solve' 2 [si,x':xs'] [1,1] = if head si < x' && last si < head xs'  then printSwapSolution (length si) (length si + 1) else "no"
solve' 3 [si,sd,si'] [1,-1,1] = if last sd > last si && head sd < head si' then printReverseSolution (length si + 1) sd else "no"
solve' 3 [si,si',si''] [1,1,1] = if last si > last si' && head si'' < head si' then printSwapSolution (length si) (length si + length si' + 1) else "no"
solve' _ _ _ = "no"


printSwapSolution :: Int -> Int -> String
printSwapSolution a b = "yes\nswap " ++ (unwords $ map show [a,b])

printReverseSolution :: Int -> [Int] -> String
printReverseSolution delta xs | length xs == 2 = "yes\nswap " ++ (unwords $ map show [delta, delta+1])
                              | otherwise = "yes\nreverse " ++ (unwords $ map show [delta, delta + length xs - 1])





              

main :: IO ()
main = interact $ (++ "\n") . solve . map read . words . (!! 1) . lines
