module Shadows where

import Data.Eq.Approximate
import TypeLevel.NaturalNumber

type ApproximateDouble = AbsolutelyApproximateValue (Digits N5) Double
type NumberType = ApproximateDouble

type Coordinate = NumberType
data Point = Point Coordinate Coordinate deriving (Eq, Show)
data Wall = Wall Point Point deriving (Eq, Show)

type Angle = NumberType
type Length = NumberType
data Shoint = Shoint Angle Length deriving (Eq, Show)
data Shadow = Shadow Shoint Shoint deriving (Eq, Show)

zeroPoint = Point 0 0
origin = Shoint anZero 0

anZero = 0 ::Angle
anXPlus = 0 :: Angle
anXMinus = (-pi) :: Angle
anYPlus = (pi/2) :: Angle
anYMinus = (-pi/2) :: Angle
anQuarter1 = (pi/4) :: Angle
anQuarter2 = (pi*3/4) :: Angle
anQuarter3 = (-pi*3/4) :: Angle
anQuarter4 = (-pi/4) :: Angle

type Rotation = Angle
rotHalf = pi :: Rotation
rotQuarter = (pi/2) :: Rotation

type Light = Point

createShadows :: Light -> [Wall] -> [Wall]
createShadows _ walls = walls

wallToShadow :: Light -> Wall -> Shadow
wallToShadow light (Wall start end) =
    Shadow (pointToShoint light start) (pointToShoint light end)

angleOf :: Point -> Angle
angleOf (Point 0 0) = 0
angleOf (Point x 0) = case (x > 0) of
    True -> anXPlus
    False -> anXMinus
angleOf (Point 0 y) = case (y > 0) of
    True -> anYPlus
    False -> anYMinus
angleOf (Point x y) = case (x > 0) of
    True -> rawAngle
    False -> case (y > 0) of
        True -> rawAngle + rotHalf
        False -> rawAngle - rotHalf
    where rawAngle = atan (y / x)

lengthOf :: Point -> Length
lengthOf (Point x y) = sqrt $ x * x + y * y

(.-) :: Point -> Point -> Point
(Point lx ly) .- (Point rx ry) = Point (lx - rx) (ly - ry)

pointToShoint :: Light -> Point -> Shoint
pointToShoint light point = Shoint (angleOf vector) (lengthOf vector)
    where vector = point .- light

xOf :: Shoint -> Coordinate
xOf (Shoint angle length) = cos angle * length

yOf :: Shoint -> Coordinate
yOf (Shoint angle length) = sin angle * length
