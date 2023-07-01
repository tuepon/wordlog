module Hello exposing (..)

import Html exposing (text)

port noun : String

main =
  text ("Hello " ++ noun)