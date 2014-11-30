module Shadows_Test where

import Shadows
import Test.HUnit


-- Test the input->expected of `createShadows`
assertShadows testName light walls expected =
    assertEqual testName expected $
        createShadows light walls

-- Test the input->expected of `wallToShadow`
assertWallToShadow testName light wall expected =
    assertEqual testName expected $
        wallToShadow light wall

-- Test the input->expected of `pointToShoint`
assertPointToShoint testName light point expected =
    assertEqual testName expected $
        pointToShoint light point

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
        {- This test is too big, we need to break it down
        ,assertShadows "A wall behind a bigger wall is hidden"
            (Point 0 0)
            [(Wall (Point (-1) 1) (Point 1 1)),
             (Wall (Point (-1) 2) (Point 1 2))]
            [(Wall (Point (-1) 1) (Point 1 1))]
        -}
        {- This test is too big, we need to break it down
        ,assertWallToShadow "Simple wall to shadow"
            (Point 0 0)
            (Wall (Point 1 0) (Point 0 1))
            (Shadow (Shoint 0 1) (Shoint (pi/4) 1))
        -}
        ,assertPointToShoint "Origin shoint"
            (Point 0 0)
            (Point 0 0)
            (Shoint 0 0)
    ]

main = runTestTT testList
