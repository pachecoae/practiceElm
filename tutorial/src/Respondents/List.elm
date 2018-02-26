module Respondents.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Respondent)
import RemoteData exposing (WebData)
import Routing exposing (respondentPath)

view : WebData (List Respondent) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]

maybeList : WebData (List Respondent) -> Html Msg
maybeList response =
  case response of
    RemoteData.NotAsked ->
      text ""

    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success respondents ->
      list respondents

    RemoteData.Failure error ->
      text (toString error)

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Respondents" ] ]

list : List Respondent -> Html Msg
list respondents =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Age" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map respondentRow respondents)
            ]
        ]

respondentRow : Respondent -> Html Msg
respondentRow respondent =
    tr []
        [ td [] [ text (toString respondent.id) ]
        , td [] [ text respondent.name ]
        , td [] [ text (toString respondent.age) ]
        , td []
            [ editBtn respondent ]
        ]

editBtn : Respondent -> Html.Html Msg
editBtn respondent =
  let
      path =
        respondentPath respondent.id

  in
    a
      [ class "btn regular"
      , href path
      ]
      [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]