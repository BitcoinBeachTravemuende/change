port module Shared.LocalStorage exposing (LocalStorageData, saveLocalStorage, themeKey)

import Json.Encode


type alias LocalStorageData =
    { key : String, value : Json.Encode.Value }


themeKey : String
themeKey =
    "theme"


port saveLocalStorage :
    { key : String
    , value : Json.Encode.Value
    }
    -> Cmd msg
