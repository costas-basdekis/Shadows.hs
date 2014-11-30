module Shadows_Test where

import Shadows
import Test.HUnit


-- Test the input->expected of function
assertExpected function testName a expected =
    assertEqual testName expected $
        function a
assertExpected2 function testName a b expected =
    assertEqual testName expected $
        function a b

-- Test the [input->expected] of function
assertManyExpected function testName args_expected_pairs =
    zipWith (\index (a, expected) ->
        assertExpected function (testName ++ " " ++ show index) a expected)
        [1..] args_expected_pairs


assertShadows = assertExpected2 createShadows

assertWallToShadow = assertExpected2 wallToShadow

assertPointToShoint = assertExpected2 pointToShoint

assertAngleOf = assertExpected angleOf
assertManyAngleOf = assertManyExpected angleOf

testList = TestList $ map TestCase $ [
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
    ] ++ assertManyAngleOf "Angle of points on axles"
        [
            ((Point 0 0), 0)
            ,((Point 1 0), 0)
            ,((Point (-1) 0), (-pi))
            ,((Point 0 1), (pi/2))
            ,((Point 0 (-1)), (-pi/2))
    ] ++ [
        {- This test is too big, we need to break it down
        ,assertPointToShoint "Shoint on +x axis"
            zeroPoint
            (Point 1 0)
            (Shoint 0 1)
        -}
    ]

main = runTestTT testList
