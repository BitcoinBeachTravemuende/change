module Utils.Html exposing (..)

import Dict exposing (Dict)
import Html
import Html.Events exposing (keyCode, on)
import Json.Decode



-- Key codes
-- @see https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode#constants_for_keycode_value


enter : Int
enter =
    13


escape : Int
escape =
    27



-- Generic `onKey` handler for HTML elements
-- Friendly borrowed (and slightly modified) from https://github.com/motis-project/motis/blob/9eace97dd51c1093d6894b7ffba40f28ceba350d/ui/web/src/Widgets/Typeahead.elm#L451C1-L467


onKey : msg -> Dict Int msg -> Html.Attribute msg
onKey fail msgs =
    let
        tagger code =
            Dict.get code msgs |> Maybe.withDefault fail
    in
    on "keydown" (Json.Decode.map tagger keyCode)
