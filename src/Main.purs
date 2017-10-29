module Main where

import Data.Array
import Data.Maybe
import Data.Show
import Math
import Math
import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (log, CONSOLE, logShow)
import Control.Monad.Eff.Ref (REF, newRef, readRef, writeRef, modifyRef, Ref)
import Data.Foldable (for_)
import Data.Int (round, toNumber, fromNumber, ceil, floor)
import Graphics.Canvas (CANVAS, Context2D, Rectangle, arc, rotate, translate, closePath, beginPath, fillPath, getCanvasElementById, getContext2D, stroke, lineTo, moveTo, rect, setFillStyle, setStrokeStyle, setCanvasWidth, setCanvasHeight, getCanvasWidth, getCanvasHeight, clearRect)
import Partial.Unsafe (unsafePartial)



type Point1 e = { x :: Number
                , y :: Number
                | e
                }

type Point2 e = {
       x :: Number
     , y :: Number
     | e
}

line :: forall a b c. Context2D -> Point1 b -> Point2 c -> Eff ( canvas :: CANVAS | a ) Context2D
line ctx p1 p2 = do
    fillPath ctx $ do
      _ <- beginPath ctx
      _ <- moveTo ctx p1.x p1.y
      _ <- lineTo ctx p2.x p2.y
      _ <- closePath ctx
      stroke ctx

project ctx width height = do
    _ <- clearRect ctx $ { x: -500.0, y: -500.0, w:width, h:height }
    for_ [0,1,2,3,4,5,6,7,8,9,10,11] \n -> do
      let x1 = toNumber $ fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! n) !! 0)) !! 0)
      let y1 = toNumber $ fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! n) !! 0)) !! 1)
      let x2 = toNumber $ fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! n) !! 1)) !! 0)
      let y2 = toNumber $ fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! n) !! 1)) !! 1)
      line ctx {x:x1,y:y1} {x:x2,y:y2}


-- vertices = [[-100.0,-100.0,-100.0],[-100.0,-100.0,100.0],[-100.0,100.0,-100.0], [-100.0,100.0,100.0],[100.0,-100.0,-100.0],[100.0,-100.0,100.0],[100.0,100.0,-100.0],[100.0,100.0,100.0]]
vertices = [[-100,-100,-100],[-100,-100,100],[-100,100,-100], [-100,100,100],[100,-100,-100],[100,-100,100],[100,100,-100],[100,100,100]]

verticesLength = length vertices


edges = [[0,1],[1,3],[3,2],[2,0],[4,5],[5,7],[7,6],[6,4],[0,4],[1,5],[2,6],[3,7]]

edgesLength = length edges

rotateX theta = do
    let sina = sin theta
    let cosa = cos theta
    for_ [0,1,2,3,4,5,6,7] \n -> do
      let vertice = fromMaybe [n] (vertices !! n)
      let y = toNumber $ fromMaybe 1 (vertice !! 1)
      let z = toNumber $ fromMaybe 2 (vertice !! 2)
      -- logShow $ round $ x * cosa - z * sina
      _ <- updateAt 1  (round $ y * cosa - z * sina) vertice
      updateAt 2  (round $ z * cosa + y * sina) vertice

rotateY theta = do
    let sina = sin theta
    let cosa = cos theta
    for_ [0,1,2,3,4,5,6,7] \n -> do
      let vertice = fromMaybe [n] (vertices !! n)
      let x = toNumber $ fromMaybe 0 (vertice !! 0)
      let z = toNumber $ fromMaybe 2 (vertice !! 2)
      -- logShow $ round $ x * cosa - z * sina
      -- _ <- updateAt 0  (round $ x * cosa - z * sina) vertice
      -- updateAt 2  (round $ z * cosa + x * sina) vertice
      logShow [(x * cosa - z * sina), toNumber $ fromMaybe 1 (vertice !! 1), (z * cosa + x * sina)]
      pure $ [(x * cosa - z * sina), toNumber $ fromMaybe 1 (vertice !! 1), (z * cosa + x * sina)]


rotateZ theta = do
    let sina = sin theta
    let cosa = cos theta
    for_ [0,1,2,3,4,5,6,7] \n -> do
      let vertice = fromMaybe [n] (vertices !! n)
      let x = toNumber $ fromMaybe 0 (vertice !! 0)
      let y = toNumber $ fromMaybe 1 (vertice !! 1)
      -- logShow $ round $ x * cosa - y * sina
      -- _ <- updateAt 0  (round $ x * cosa - y * sina) vertice
      -- updateAt 1  (round $ y * cosa + x * sina) vertice
      logShow [(x * cosa - y * sina), (y * cosa + x * sina), toNumber $ fromMaybe 2 (vertice !! 2)]
      pure $ [(x * cosa - y * sina), (y * cosa + x * sina), toNumber $ fromMaybe 2 (vertice !! 2)]

render count ctx = void do
    let scaleX = sin (toNumber count * pi / 4.0) + 1.5
    let scaleY = sin (toNumber count * pi / 6.0) + 1.5

    _ <- translate { translateX: 300.0, translateY:  300.0 } ctx
    _ <- rotate (toNumber count * pi / 18.0) ctx
    translate { translateX: -100.0, translateY: -100.0 } ctx

-- main :: Eff (canvas :: CANVAS, console :: CONSOLE) Unit
main = void $ unsafePartial do
  Just canvas <- getCanvasElementById "canvas"
  ctx <- getContext2D canvas

  _ <- translate {translateX : 1260.0/2.0-150.0, translateY : 700.0/2.0-100.0 } ctx
  _ <- setStrokeStyle "#0099FF" ctx

  rotateZ 60.0
  rotateY 60.0
  rotateZ 60.0
  project ctx 1260.0 700.0
