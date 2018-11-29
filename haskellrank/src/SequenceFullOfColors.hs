module Main where


solve :: String -> -- sequence of colors R,G,Y,B
         Int    -> -- number of red balls
         Int    -> -- number of green balls
         Int    -> -- number of yellow balls
         Int    -> -- number of blue balls
         Bool      -- whether is a sequence full of colors or not
solve [] r g y b | (r == g) && (y == b) = True
                 | otherwise = False

solve ('R':colors) r g y b | r > g = False
                           | otherwise = solve colors (r+1) g y b
                           
solve ('G':colors) r g y b | g > r = False
                          | otherwise = solve colors r (g+1) y b
         
solve ('Y':colors) r g y b | y > b = False
                           | otherwise = solve colors r g (y+1) b

solve ('B':colors) r g y b | b > y = False
                           | otherwise = solve colors r g y (b+1)


main :: IO ()
main = interact $ unlines . map show . map (\s -> solve s 0 0 0 0) . tail . lines
