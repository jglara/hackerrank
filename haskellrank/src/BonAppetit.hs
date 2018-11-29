module Main where

getList :: IO [Int]
getList = do
    line <- getLine
    return $ map read $ words line

solve :: Int ->      -- kth element of the bill that should be removed
         [Int] ->    -- bill 
         Int ->      -- amount charged
         Maybe Int   --
solve k bill charged | total == charged = Nothing
                     | otherwise        = Just (charged - total)
                     where (a,_:b) = splitAt k bill
                           total   = sum (a ++ b) `div` 2

main :: IO ()
main = do
    [n, k] <- getList
    bill <- getList
    [charged] <- getList
    putStrLn $ maybe "Bon Appetit" show $ solve k bill charged
    
