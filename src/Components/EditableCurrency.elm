module Components.EditableCurrency exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.Attributes as Attr
import Html.Events exposing (..)
import Platform.Cmd as Cmd
import Utils.Html exposing (enter, escape, onKey)


type alias InputValue =
    String


type Msg
    = Save InputValue
    | Update InputValue
    | Cancel
    | Edit InputValue
    | NoOp


type alias Model =
    { editable :
        Maybe InputValue
    }


initialModel : Model
initialModel =
    { editable = Nothing
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update value ->
            ( { model | editable = Just value }, Cmd.none )

        Save _ ->
            ( { model | editable = Nothing }, Cmd.none )

        Cancel ->
            ( { model | editable = Nothing }, Cmd.none )

        Edit value ->
            ( { model | editable = Just value }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


defaultView : InputValue -> Model -> Html Msg
defaultView value _ =
    button [ Attr.class "flex", onClick <| Edit value ] [ text value ]


editableView : InputValue -> Model -> Html Msg
editableView value model =
    let
        valueToSave =
            Maybe.withDefault "never" model.editable
    in
    div [ Attr.class "flex flex-row gap-1" ]
        [ input
            [ onInput Update
            , onKey NoOp
                (Dict.fromList
                    [ ( enter, Save valueToSave )
                    , ( escape, Cancel )
                    ]
                )
            , Attr.value value
            , Attr.class "flex-1"
            ]
            [ text value ]
        , button
            [ onClick Cancel ]
            [ text "X" ]
        , button
            [ onClick <| Save valueToSave ]
            [ text "S" ]
        ]


view : InputValue -> Model -> Html Msg
view value model =
    Maybe.map
        (\v -> editableView v model)
        model.editable
        |> Maybe.withDefault (defaultView value model)
