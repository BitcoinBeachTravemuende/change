module Main exposing (main)

import Browser
import Components.ThemeButton as ThemeButton
import Html exposing (..)
import Html.Attributes exposing (class)
import InteropDefinitions exposing (..)
import InteropPorts exposing (..)
import Json.Decode exposing (..)
import Shared.Theme exposing (Theme(..))



-- MAIN


main : Program Json.Decode.Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { theme : Theme
    }


init : Json.Decode.Value -> ( Model, Cmd Msg )
init flags =
    let
        decoded =
            InteropPorts.decodeFlags flags
                |> Result.withDefault { theme = Light }
    in
    ( { theme = decoded.theme
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = ToggleTheme
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleTheme ->
            let
                newTheme =
                    if model.theme == Light then
                        Dark

                    else
                        Light
            in
            ( { model
                | theme =
                    newTheme
              }
            , Cmd.batch
                [ InteropPorts.fromElm (InteropDefinitions.SetDarkMode (newTheme == Dark))
                , InteropPorts.fromElm (InteropDefinitions.SaveTheme newTheme)
                ]
            )

        NoOp ->
            ( model
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view { theme } =
    div
        [ class "container py-10 px-6" ]
        -- header
        [ div
            [ class "flex justify-end font-bold text-gray-600 dark:text-gray-200 text-8xl" ]
            [ ThemeButton.view { theme = theme, onClick = ToggleTheme, class = "w-6 h-6" }
            ]
        , -- content
          h1
            [ class "flex justify-center text-orange-400 text-4xl " ]
            [ text "Hello World"
            ]
        ]
