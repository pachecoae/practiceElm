module Respondents.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Models exposing (Respondent)
import Routing exposing (respondentsPath)

view : Respondent -> Html Msg
view model =
  div []
    [ nav model
    , form model
    ]

nav : Respondent -> Html Msg
nav model =
  div [ class "clearfix mb2 white bg-black p1" ]
      [ listBtn ]

form : Respondent -> Html Msg
form respondent =
  div [ class "m3" ]
      [ h1 [] [ text respondent.name ]
      , formLevel respondent
      ]

formLevel : Respondent -> Html Msg
formLevel respondent =
  div
      [ class "clearfix py1"
      ]
      [ div [ class "col col-5" ] [ text "level" ]
      , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString respondent.level) ]
            , btnLevelDecrease respondent
            , btnLevelIncrease respondent
            ]
      ]

btnLevelDecrease : Respondent -> Html Msg
btnLevelDecrease respondent =
  let
    message =
      Msgs.ChangeLevel respondent -1
  in
      a [ class "btn ml1 h1", onClick message ]
        [ i [ class "fa fa-minus-circle" ] [] ]

btnLevelIncrease : Respondent -> Html Msg
btnLevelIncrease respondent =
  let
    message =
      Msgs.ChangeLevel respondent 1
  in
      a [ class "btn ml1 h1", onClick message ]
      [ i [ class "fa fa-plus-circle" ] [] ]

listBtn : Html Msg
listBtn =
  a
    [ class "btn regular"
    , href respondentsPath
    ]
    [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]