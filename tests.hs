module Shadows_Test where

import Shadows
import Test.HUnit


testList = TestList $ map TestCase [
        assertEqual "The test suite runs"
            True True
    ]

main = runTestTT testList
