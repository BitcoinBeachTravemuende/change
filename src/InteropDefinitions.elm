module InteropDefinitions exposing (Flags, FromElm(..), ToElm, interop)

import Flags exposing (Flags)
import Shared.Theme
import TsJson.Decode as TsDecode exposing (Decoder)
import TsJson.Encode as TsEncode exposing (Encoder)


interop :
    { toElm : Decoder ToElm
    , fromElm : Encoder FromElm
    , flags : Decoder Flags
    }
interop =
    { toElm = toElm
    , fromElm = fromElm
    , flags = flags
    }


type FromElm
    = SaveTheme Shared.Theme.Theme
    | SetDarkMode Bool


type alias ToElm =
    ()


type alias Flags =
    Flags.Flags


fromElm : Encoder FromElm
fromElm =
    TsEncode.union
        (\vSaveTheme vSetDarkMode value ->
            case value of
                SaveTheme v ->
                    vSaveTheme v

                SetDarkMode v ->
                    vSetDarkMode v
        )
        |> TsEncode.variantTagged "saveTheme"
            Shared.Theme.tsEncoder
        |> TsEncode.variantTagged "setDarkMode"
            TsEncode.bool
        |> TsEncode.buildUnion


toElm : Decoder ToElm
toElm =
    TsDecode.null ()



-- TsDecode.int
--     |> TsDecode.map String.fromInt


flags : TsDecode.Decoder Flags
flags =
    Flags.tsDecoder
