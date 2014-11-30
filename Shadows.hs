module Shadows where

data Point = Point Float Float deriving (Eq, Show)
data Wall = Wall Point Point deriving (Eq, Show)

createShadows :: Point -> [Wall] -> [Wall]
createShadows _ walls = walls
