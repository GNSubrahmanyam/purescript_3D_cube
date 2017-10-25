module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..))
import Graphics.Canvas (CANVAS, arc, closePath, fillPath, getCanvasElementById, getContext2D, stroke, lineTo, moveTo, rect, setFillStyle, setStrokeStyle, setCanvasWidth, setCanvasHeight, getCanvasWidth, getCanvasHeight)
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
    _ <- moveTo ctx 0.0 0.0
    _ <- lineTo ctx 200.0 100.0
    _ <- stroke ctx
    closePath ctx
