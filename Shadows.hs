module Shadows where

type Coordinate = Float
data Point = Point Coordinate Coordinate deriving (Eq, Show)
data Wall = Wall Point Point deriving (Eq, Show)

type Angle = Float
type Length = Float
data Shoint = Shoint Angle Length deriving (Eq, Show)
data Shadow = Shadow Shoint Shoint deriving (Eq, Show)

zeroPoint = Point 0 0
origin = Shoint 0 0

createShadows :: Point -> [Wall] -> [Wall]
createShadows _ walls = walls

wallToShadow :: Point -> Wall -> Shadow
wallToShadow = undefined

angleOf :: Point -> Angle
angleOf _ = 0

pointToShoint :: Point -> Point -> Shoint
pointToShoint _ _ = origin
