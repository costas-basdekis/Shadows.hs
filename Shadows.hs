module Shadows where

type Coordinate = Float
data Point = Point Coordinate Coordinate deriving (Eq, Show)
data Wall = Wall Point Point deriving (Eq, Show)

type Angle = Float
type Length = Float
data Shoint = Shoint Angle Length deriving (Eq, Show)
data Shadow = Shadow Shoint Shoint deriving (Eq, Show)

zeroPoint = Point 0 0
origin = Shoint anZero 0

anZero = 0 ::Angle
anXPlus = 0 :: Angle
anXMinus = (-pi) :: Angle
anYPlus = (pi/2) :: Angle
anYMinus = (-pi/2) :: Angle
anQuarter1 = (-pi/4) :: Angle
anQuarter2 = (-pi*3/4) :: Angle
anQuarter3 = (-pi*5/4) :: Angle
anQuarter4 = (-pi*7/4) :: Angle

createShadows :: Point -> [Wall] -> [Wall]
createShadows _ walls = walls

wallToShadow :: Point -> Wall -> Shadow
wallToShadow = undefined

angleOf :: Point -> Angle
angleOf (Point 0 0) = 0
angleOf (Point x 0) = case (x > 0) of
    True -> 0
    False -> (-pi)
angleOf (Point x y) = atan (y / x)

pointToShoint :: Point -> Point -> Shoint
pointToShoint _ _ = origin
