module Pages.Home_ exposing (page)

import Html exposing (..)
import Html.Attributes exposing (class)
import View exposing (View)


page : View msg
page =
    { title = "Homepage"
    , body =
        [ div
            [ class "flex justify-center font-bold text-orange-400 text-8xl" ]
            [ text "Hello World" ]
        ]
    }
