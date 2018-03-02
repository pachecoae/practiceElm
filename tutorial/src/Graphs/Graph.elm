module Graphs.Graph exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Plot exposing (..)
-- import Plot.area as Area
-- import Plot.axis as Axis
-- import Plot.Grid as Grid
-- import Plot.Hint as Hint
-- import Plot.Label as Label
-- import Plot.Line as Line
-- import Plot.Tick as Tick
import Models exposing (Respondent, DataPoint)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Respondents.Edit exposing (listBtn)
import Svg exposing (Svg)


labelStyle : List (Label.StyleAttribute msg)
labelStyle =
    [ Label.fontSize 12
    , Label.displace ( 0, -2 )
    ]


view : WebData (List Respondent) -> Html Msg
view response =
    div []
        [ nav
        , maybeGraph response
        ]


graph : State -> Svg (Interaction msg)
graph state =
    div []
        [ plotInteractive
            [ size ( 400, 400 )
            , padding ( 40, 40 )
            , margin ( 15, 20, 40, 15 )
            ]
            [ horizontalGrid
                [ Grid.lines [ Line.stroke "#f2f2f2" ] ]
            , verticalGrid
                [ Grid.lines [ Line.stroke "#f2f2f2" ] ]
            , scatter
                []
                dataScat
            , yAxis
                [ Axis.anchorInside
                , Axis.cleanCrossings
                , Axis.positionLowest
                , Axis.line
                    [ Line.stroke "#b9b9b9" ]
                , Axis.tickDelta 5
                , Axis.label
                    [ Label.view labelStyle
                    , Label.format (\{ value } -> toString value)
                    ]
                ]
            , xAxis
                [ Axis.cleanCrossings
                , Axis.line
                    [ Line.stroke "#b9b9b9" ]
                , Axis.tickDelta 2.5
                , Axis.tick
                    [ Tick.viewDynamic toTickStyle ]
                , Axis.label
                    [ Label.view
                        [ Label.fontSize 12
                        , Label.stroke "#b9b9b9"
                        ]
                    , Label.format (\{ value } -> toString value)
                    ]
                ]
            , hint
                [ Hint.lineStyle [ ( "background", "#b9b9b9" ) ] ]
                (getHoveredValue state)
            ]
        ]


maybeGraph : WebData (List Respondent) -> Html Msg
maybeGraph response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success respondents ->
            graphData respondents

        RemoteData.Failure error ->
            text (toString error)


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


graphData : List Respondent -> Html Msg
graphData respondents =
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


ageCountData : List Respondent -> List DataPoint
ageCountData respondents =
    List.map ageData respondents


ageData : Respondent -> DataPoint
ageData respondent =
    DataPoint (toFloat respondent.id) (toFloat respondent.age)


dataRow : DataPoint -> Html Msg
dataRow data =
    tr []
        [ td [] [ text (toString data.x) ]
        , td [] [ text (toString data.y) ]
        ]
