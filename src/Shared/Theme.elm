module Shared.Theme exposing (Theme(..), decoder, encodeTheme, fromString, toString, tsDecoder, tsEncoder)

import Json.Decode exposing (..)
import Json.Encode exposing (..)
import TsJson.Decode exposing (..)
import TsJson.Encode exposing (..)


type Theme
    = Light
    | Dark


decoder : Json.Decode.Decoder Theme
decoder =
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


tsDecoder : TsJson.Decode.Decoder Theme
tsDecoder =
    TsJson.Decode.stringUnion
        [ ( "light", Light )
        , ( "dark", Dark )
        ]


encodeTheme : Theme -> Json.Encode.Value
encodeTheme theme =
    case theme of
        Light ->
            Json.Encode.string "light"

        Dark ->
            Json.Encode.string "dark"


tsEncoder : TsJson.Encode.Encoder Theme
tsEncoder =
    TsJson.Encode.union
        (\vLight vDark value ->
            case value of
                Light ->
                    vLight

                Dark ->
                    vDark
        )
        |> variantLiteral (Json.Encode.string "light")
        |> variantLiteral (Json.Encode.string "dark")
        |> buildUnion


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
