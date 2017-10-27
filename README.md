# purescript_3D_cube
purescript_3D_cube

Do:

`bower i`

`pulp build`

`pulp build -O --to output.js`

`vertices[edges[i][0]][0],y:vertices[edges[i][0]][1]`
fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! 0) !! 0)) !! 0)


fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! n) !! 0)) !! 0)
fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! n) !! 0)) !! 1)
fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! n) !! 1)) !! 0)
fromMaybe 0 (fromMaybe [0] (vertices !! fromMaybe 0 (fromMaybe [0] (edges !! n) !! 1)) !! 1)
