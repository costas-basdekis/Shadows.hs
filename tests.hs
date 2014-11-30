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
        ,assertShadows "One wall produces same wall"
            (Point 0 0) [(Wall (Point (-1) 1) (Point 1 1))]
            [(Wall (Point (-1) 1) (Point 1 1))]
        ,assertShadows "Two non-overlapping walls produce same walls"
            (Point 0 0)
            [(Wall (Point (-1) 1) (Point 1 1)),
             (Wall (Point (-1) (-1)) (Point 1 (-1)))]
            [(Wall (Point (-1) 1) (Point 1 1)),
             (Wall (Point (-1) (-1)) (Point 1 (-1)))]
        ,assertShadows "A wall behind a bigger wall is hidden"
            (Point 0 0)
            [(Wall (Point (-1) 1) (Point 1 1)),
             (Wall (Point (-1) 2) (Point 1 2))]
            [(Wall (Point (-1) 1) (Point 1 1))]
    ]

main = runTestTT testList
