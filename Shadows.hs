module Shadows where

data Point = Point Float Float deriving (Eq, Show)
data Wall = Wall Point Point deriving (Eq, Show)
data Shoint = Shoint Float Float deriving (Eq, Show)
data Shadow = Shadow Shoint Shoint deriving (Eq, Show)

createShadows :: Point -> [Wall] -> [Wall]
createShadows _ walls = walls

wallToShadow :: Point -> Wall -> Shadow
wallToShadow = undefined

pointToShoint :: Point -> Point -> Shoint
pointToShoint = undefined
