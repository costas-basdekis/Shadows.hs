module Shadows_Test where

import Shadows
import Test.HUnit


testList = TestList $ map TestCase [
        assertEqual "The test suite runs"
            True True
        ,assertEqual "No walls produce no walls"
            []
            (createShadows (Point 0 0) [])
        ,assertEqual "One wall produces one wall"
            [(Wall (Point (-1) 1) (Point 1 1))]
            (createShadows (Point 0 0) [(Wall (Point (-1) 1) (Point 1 1))])
    ]

main = runTestTT testList
