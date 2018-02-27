module Graphs.Graph exposing (..)

import Plot exposing (..)
import Models exposing (Respondent)

ageCountData: (List Respondent) -> List ( Float, Float )
ageCountData respondents =
  List.map ageData respondents

ageData: Respondent -> ( Float, Float )
ageData respondent =
  ( respondent.id, respondent.age )

labelStyle : List (Label.StyleAttribute msg)
labelStyle =
    [ Label.fontSize 12
    , Label.displace ( 0, -2 )
    ]