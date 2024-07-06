module Flags exposing (Flags, decoder, tsDecoder)

import Json.Decode exposing (..)
import Shared.Theme exposing (Theme(..))
import TsJson.Decode exposing (..)


type alias Flags =
    { theme : Theme }


decoder : Json.Decode.Decoder Flags
decoder =
    Json.Decode.map Flags (Json.Decode.field "theme" Shared.Theme.decoder)


tsDecoder : TsJson.Decode.Decoder Flags
tsDecoder =
    TsJson.Decode.map Flags (TsJson.Decode.field "theme" Shared.Theme.tsDecoder)
