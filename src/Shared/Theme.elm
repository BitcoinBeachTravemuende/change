port module Shared.Theme exposing (Theme(..), decodeTheme, encodeTheme, fromString, setDarkMode, toString)

import Json.Decode
import Json.Encode


type Theme
    = Light
    | Dark


decodeTheme : Json.Decode.Decoder Theme
decodeTheme =
    Json.Decode.string
        |> Json.Decode.andThen
            (\str ->
                case str of
                    "light" ->
                        Json.Decode.succeed Light

                    "dark" ->
                        Json.Decode.succeed Dark

                    _ ->
                        Json.Decode.fail ("Unknown theme: " ++ str)
            )


encodeTheme : Theme -> Json.Encode.Value
encodeTheme theme =
    case theme of
        Light ->
            Json.Encode.string "light"

        Dark ->
            Json.Encode.string "dark"


toString : Theme -> String
toString theme =
    case theme of
        Light ->
            "light"

        Dark ->
            "dark"


fromString : String -> Theme
fromString s =
    case s of
        "light" ->
            Light

        "dark" ->
            Dark

        _ ->
            Light


port setDarkMode :
    Bool
    -> Cmd msg
