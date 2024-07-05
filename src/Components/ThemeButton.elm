module Components.ThemeButton exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Shared.Theme exposing (Theme(..))
import Svg exposing (circle, path, svg)
import Svg.Attributes exposing (cx, cy, d, fill, height, r, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox, width)


view : { theme : Theme, onClick : msg, class : String } -> Html msg
view props =
    button [ onClick props.onClick, class props.class ]
        [ if props.theme == Dark then
            svg
                [ fill "none"
                , height "100%"
                , stroke "currentColor"
                , strokeLinecap "round"
                , strokeLinejoin "round"
                , strokeWidth "1.5"
                , viewBox "0 0 24 24"
                , width "100%"
                ]
                [ circle
                    [ cx "12", cy "12", r "4" ]
                    []
                , path [ d "M12 2v2" ]
                    []
                , path [ d "M12 20v2" ]
                    []
                , path [ d "m4.93 4.93 1.41 1.41" ]
                    []
                , path [ d "m17.66 17.66 1.41 1.41" ]
                    []
                , path [ d "M2 12h2" ]
                    []
                , path [ d "M20 12h2" ]
                    []
                , path [ d "m6.34 17.66-1.41 1.41" ]
                    []
                , path [ d "m19.07 4.93-1.41 1.41" ]
                    []
                ]

          else
            svg
                [ width "100%"
                , height "100%"
                , viewBox "0 0 24 24"
                , fill "none"
                , stroke "currentColor"
                , strokeWidth "1.5"
                , strokeLinecap "round"
                , strokeLinejoin "round"
                ]
                [ path [ d "M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z" ] [] ]
        ]
