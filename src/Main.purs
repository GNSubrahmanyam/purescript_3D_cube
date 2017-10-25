module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..))
import Graphics.Canvas (CANVAS, arc, closePath, beginPath, fillPath, getCanvasElementById, getContext2D, stroke, lineTo, moveTo, rect, setFillStyle, setStrokeStyle, setCanvasWidth, setCanvasHeight, getCanvasWidth, getCanvasHeight)
import Math
import Partial.Unsafe (unsafePartial)


main :: Eff (canvas :: CANVAS) Unit
main = void $ unsafePartial do
  Just canvas <- getCanvasElementById "canvas"
  ctx <- getContext2D canvas

  w <- getCanvasWidth canvas
  h <- getCanvasHeight canvas
  _ <- setCanvasWidth w canvas
  _ <- setCanvasHeight h canvas

  _ <- setFillStyle "#0099FF" ctx
  _ <- setStrokeStyle "#0099FF" ctx


  fillPath ctx $ do
    _ <- beginPath ctx
    _ <- moveTo ctx 9.0 8.0
    _ <- lineTo ctx 900.0 100.0
    _ <- stroke ctx
    closePath ctx
