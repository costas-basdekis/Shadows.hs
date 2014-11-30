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
assertManyExpected2 function testName args_expected_pairs =
    zipWith (\index (a, b, expected) ->
        assertExpected2 function (testName ++ " " ++ show index) a b expected)
        [1..] args_expected_pairs


assertShadows = assertExpected2 createShadows

assertWallToShadow = assertExpected2 wallToShadow

assertPointToShoint = assertExpected2 pointToShoint

assertAngleOf = assertExpected angleOf
assertManyAngleOf = assertManyExpected angleOf

assertLengthOf = assertExpected lengthOf
assertManyLengthOf = assertManyExpected lengthOf

assertPointSubtraction = assertExpected2 (.-)
assertManyPointSubtraction = assertManyExpected2 (.-)

assertPointAddition = assertExpected2 (.+)
assertManyPointAddition = assertManyExpected2 (.+)

assertXOf = assertExpected xOf
assertManyXOf = assertManyExpected xOf

assertYOf = assertExpected yOf
assertManyYOf = assertManyExpected yOf

assertShointToPoint = assertExpected2 shointToPoint
assertManyShointToPoint = assertManyExpected2 shointToPoint

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
        ,assertWallToShadow "Simple wall to shadow"
            zeroPoint
            (Wall (Point 1 0) (Point 0 1))
            (Shadow (Shoint 0 1) (Shoint (pi/2) 1))
        ,assertPointToShoint "Origin shoint"
            zeroPoint
            zeroPoint
            origin
    ] ++ assertManyAngleOf "Angle of points on axles"
        [
            ((Point 0 0), anZero)
            ,((Point 1 0), anXPlus)
            ,((Point (-1) 0), anXMinus)
            ,((Point 0 1), anYPlus)
            ,((Point 0 (-1)), anYMinus)
    ] ++ assertManyAngleOf "Angle of points on quarters"
        [
            ((Point 1 1), anQuarter1)
            ,((Point (-1) 1), anQuarter2)
            ,((Point (-1) (-1)), anQuarter3)
            ,((Point 1 (-1)), anQuarter4)
    ] ++ assertManyAngleOf "Angle of points on near axis"
        [
            ((Point 1 0.1), 0.09966865249116204)
            ,((Point (-1) 0.1), 3.0419240010986313)
            ,((Point (-1) (-0.1)), -3.0419240010986313)
            ,((Point 1 (-0.1)), -0.09966865249116204)
    ] ++ assertManyLengthOf "Length of points on axles"
        [
            ((Point 0 0), 0)
            ,((Point 1 0), 1)
            ,((Point (-1) 0), 1)
            ,((Point 0 1), 1)
            ,((Point 0 (-1)), 1)
    ] ++ assertManyLengthOf "Length of points on quarters"
        [
            ((Point 1 1), sqrt 2)
            ,((Point (-1) 1), sqrt 2)
            ,((Point (-1) (-1)), sqrt 2)
            ,((Point 1 (-1)), sqrt 2)
    ] ++ assertManyLengthOf "Length of points"
        [
            ((Point 3 4), 5)
    ] ++ assertManyPointSubtraction "Point subtraction"
        [
            ((Point 0 0), (Point 0 0), (Point 0 0))
            ,((Point 1 1), (Point 1 1), (Point 0 0))
            ,((Point 3 4), (Point 2 6), (Point 1 (-2)))
    ] ++ [
        assertPointToShoint "Shoint on +x axis"
            zeroPoint
            (Point 1 0)
            (Shoint 0 1)
    ] ++ assertManyPointSubtraction "Point subtraction"
        [
            ((Point 0 0), (Point 0 0), (Point 0 0))
            ,((Point 1 1), (Point 1 1), (Point 0 0))
            ,((Point 3 4), (Point 2 6), (Point 1 (-2)))
    ] ++ assertManyShointToPoint "Point->Shoint->Point on Axis"
        (map (\point -> (zeroPoint, pointToShoint zeroPoint point, point)) [
            (Point 0 0)
            ,(Point 1 0)
            ,(Point (-1) 0)
            ,(Point 0 1)
            ,(Point 0 (-1))
    ]) ++ assertManyShointToPoint "Point->Shoint->Point on quarters"
        (map (\point -> (zeroPoint, pointToShoint zeroPoint point, point)) [
            (Point 1 1)
            ,(Point (-1) 1)
            ,(Point (-1) (-1))
            ,(Point 1 (-1))
    ]) ++ assertManyShointToPoint "Point->Shoint->Point near axis"
        (map (\point -> (zeroPoint, pointToShoint zeroPoint point, point)) [
            (Point 1 0.1)
            ,(Point (-1) 0.1)
            ,(Point (-1) (-0.1))
            ,(Point 1 (-0.1))
    ]) ++ assertManyPointAddition "Point addition"
        [
            ((Point 0 0), (Point 0 0), (Point 0 0))
            ,((Point 1 1), (Point 0 0), (Point 1 1))
            ,((Point 2 6), (Point 1 (-2)), (Point 3 4))
    ]

main = runTestTT testList
