module Shadows_Test where

import Shadows
import Test.HUnit


assertShadows testName light walls expected =
    assertEqual testName expected $
        createShadows light walls

testList = TestList $ map TestCase [
        assertEqual "The test suite runs"
            True True
        ,assertShadows "No walls produce no walls"
            (Point 0 0) []
            []
        ,assertShadows "One wall produces one wall"
            (Point 0 0) [(Wall (Point (-1) 1) (Point 1 1))]
            [(Wall (Point (-1) 1) (Point 1 1))]
    ]

main = runTestTT testList
