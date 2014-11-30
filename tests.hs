module Shadows_Test where

import Shadows
import Test.HUnit


-- Test the input->expected of `createShadows`
assertExpected2 function testName a b expected =
    assertEqual testName expected $
        function a b

-- Test the input->expected of `createShadows`
assertShadows = assertExpected2 createShadows

-- Test the input->expected of `wallToShadow`
assertWallToShadow = assertExpected2 wallToShadow

-- Test the input->expected of `pointToShoint`
assertPointToShoint = assertExpected2 pointToShoint

testList = TestList $ map TestCase [
        assertEqual "The test suite runs"
            True True
        ,assertShadows "No walls produce no walls"
            zeroPoint []
            []
        ,assertShadows "One wall produces same wall"
            zeroPoint [(Wall (Point (-1) 1) (Point 1 1))]
            [(Wall (Point (-1) 1) (Point 1 1))]
        ,assertShadows "Two non-overlapping walls produce same walls"
            zeroPoint
            [(Wall (Point (-1) 1) (Point 1 1)),
             (Wall (Point (-1) (-1)) (Point 1 (-1)))]
            [(Wall (Point (-1) 1) (Point 1 1)),
             (Wall (Point (-1) (-1)) (Point 1 (-1)))]
        {- This test is too big, we need to break it down
        ,assertShadows "A wall behind a bigger wall is hidden"
            zeroPoint
            [(Wall (Point (-1) 1) (Point 1 1)),
             (Wall (Point (-1) 2) (Point 1 2))]
            [(Wall (Point (-1) 1) (Point 1 1))]
        -}
        {- This test is too big, we need to break it down
        ,assertWallToShadow "Simple wall to shadow"
            zeroPoint
            (Wall (Point 1 0) (Point 0 1))
            (Shadow (Shoint 0 1) (Shoint (pi/4) 1))
        -}
        ,assertPointToShoint "Origin shoint"
            zeroPoint
            zeroPoint
            origin
    ]

main = runTestTT testList
