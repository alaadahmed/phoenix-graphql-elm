module Main exposing (Model, Msg(..), init, main, update, view, viewInput, viewValidation)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view _ =
    section [ class "" ]
        [ div [ class "" ]
            [ h1 [ class "" ]
                [ text "Section from ELM"
                ]
            , h2 [ class "" ]
                [ text "A simple container to divide your page into "
                , strong [ class "" ] [ text "sections" ]
                , text ", like the one you're currently reading, which by the way from "
                , strong [ class "" ] [ text "ELM" ]
                ]
            ]
        ]


viewInput : String -> String -> String -> String -> (String -> msg) -> Html msg
viewInput c t p v toMsg =
    input [ class c, type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if model.password == model.passwordAgain then
        button [ class "" ] [ text "Success" ]

    else
        button [ class "" ] [ text "Failed" ]
