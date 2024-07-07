module Main exposing (main)

import Browser
import Components.EditableCurrency as EditableCurrency
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
    { theme : Shared.Theme.Theme
    , editableBtcModel : EditableCurrency.Model
    , btcValue : EditableCurrency.InputValue
    , editableFiatModel : EditableCurrency.Model
    , fiatValue : EditableCurrency.InputValue
    }


init : Json.Decode.Value -> ( Model, Cmd Msg )
init flags =
    let
        decoded =
            InteropPorts.decodeFlags flags
                |> Result.withDefault { theme = Light }
    in
    ( { theme = decoded.theme
      , editableBtcModel = EditableCurrency.initialModel
      , editableFiatModel = EditableCurrency.initialModel
      , btcValue = "21000"
      , fiatValue = "42"
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = ToggleTheme
    | EditableBtcMsg EditableCurrency.Msg
    | EditableFiatMsg EditableCurrency.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg m =
    case msg of
        ToggleTheme ->
            let
                newTheme =
                    if m.theme == Light then
                        Dark

                    else
                        Light
            in
            ( { m
                | theme =
                    newTheme
              }
            , Cmd.batch
                [ InteropPorts.fromElm (InteropDefinitions.SetDarkMode (newTheme == Dark))
                , InteropPorts.fromElm (InteropDefinitions.SaveTheme newTheme)
                ]
            )

        EditableBtcMsg subMsg ->
            let
                ( btcModel, _ ) =
                    EditableCurrency.update subMsg m.editableBtcModel

                newModel =
                    case subMsg of
                        EditableCurrency.Save value ->
                            { m | btcValue = value }

                        _ ->
                            m
            in
            ( { newModel | editableBtcModel = btcModel }
            , Cmd.none
            )

        EditableFiatMsg subMsg ->
            let
                ( fiatModel, _ ) =
                    EditableCurrency.update subMsg m.editableBtcModel

                newModel =
                    case subMsg of
                        EditableCurrency.Save value ->
                            { m | fiatValue = value }

                        _ ->
                            m
            in
            ( { newModel | editableFiatModel = fiatModel }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view m =
    div
        [ class "container py-10 px-6" ]
        -- header
        [ div
            [ class "flex justify-end font-bold text-gray-600 dark:text-gray-200 text-8xl" ]
            [ ThemeButton.view { theme = m.theme, onClick = ToggleTheme, class = "w-6 h-6" }
            ]
        , -- content
          h1
            [ class "flex justify-center text-orange-400 text-4xl " ]
            [ text "Hello World"
            ]
        , Html.map EditableBtcMsg <| EditableCurrency.view m.btcValue m.editableBtcModel
        , Html.map EditableFiatMsg <| EditableCurrency.view m.fiatValue m.editableFiatModel
        , h2 [] [ text <| "btc " ++ m.btcValue ]
        , h2 [] [ text <| "fiat " ++ m.fiatValue ]
        ]
