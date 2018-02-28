module Graphs.Graph exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
-- import Plot exposing (..)
import Models exposing (Respondent, DataPoint)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Respondents.Edit exposing (listBtn)

-- labelStyle : List (Label.StyleAttribute msg)
-- labelStyle =
--   [ Label.fontSize 12
--   , Label.displace ( 0, -2 )
--   ]

view : WebData (List Respondent) -> Html Msg
view response =
    div []
        [ nav
        , maybeGraph response
        ]

maybeGraph : WebData (List Respondent) -> Html Msg
maybeGraph response =
  case response of
    RemoteData.NotAsked ->
      text ""

    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success respondents ->
      graph respondents

    RemoteData.Failure error ->
      text (toString error)

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]

graph : List Respondent -> Html Msg
graph respondents =
  let
    dataPoints =
      ageCountData respondents
  in
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Age" ]
                    ]
                ]
            , tbody [] (List.map dataRow dataPoints)
            ]
        ]

ageCountData: (List Respondent) -> List DataPoint
ageCountData respondents =
  List.map ageData respondents

ageData: Respondent -> DataPoint
ageData respondent =
  DataPoint (toFloat respondent.id) (toFloat respondent.age)

dataRow: DataPoint -> Html Msg
dataRow data =
  tr []
    [ td [] [ text (toString data.x) ]
    , td [] [ text (toString data.y) ]
    ]